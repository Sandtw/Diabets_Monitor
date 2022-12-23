import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/scheduler.dart';
import 'package:diabets_monitor/screens/screens.dart';

class StagingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
            background(),
            Container(
              child: Row(
                children: [
                  LeftWidget(),
                ],
              ),
            ),
            
        ]
      ),
    );
  }
}

class LeftWidget extends StatefulWidget {
  LeftWidget({Key? key,}) : super(key: key);

  @override
  State<LeftWidget> createState() => _LeftWidgetState();
}

class _LeftWidgetState extends State<LeftWidget> with TickerProviderStateMixin{
  List<String> _list = ['Iniciar Sesión', 'Registrar'];
  List<GlobalKey> _keys = [GlobalKey(),GlobalKey()];
  int checkIndex = 0;

  Offset checkedPositionOffset = Offset(0,0);
  Offset lastCheckOffSet = Offset(0,0);

  Offset animationOffset = Offset(0,0);
  late Animation _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    checkIndex = _list.length - 1;    
    super.initState();

    SchedulerBinding.instance.endOfFrame.
      then((value) {
         calcuteCheckOffset();
         addAnimation();
      });
  }

  void calcuteCheckOffset() {
      lastCheckOffSet = checkedPositionOffset;
      RenderBox renderBox = _keys[checkIndex].currentContext!.findRenderObject() as RenderBox;
      Offset widgetOffset = renderBox.localToGlobal(Offset(0, 0));
      Size widgetSize = renderBox.size;
      checkedPositionOffset = Offset(widgetOffset.dx + widgetSize.width, 
                                     widgetOffset.dy + widgetSize.height);

  }

  void addAnimation() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            setState(() {
              animationOffset =
                  Offset(checkedPositionOffset.dx, _animation.value);
            });
          });

    _animation = Tween(begin: lastCheckOffSet.dy, end: checkedPositionOffset.dy)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.easeInOutBack));
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children: [
              Container(
                width: 70,
                decoration: BoxDecoration(
                color: Color.fromARGB(255, 44, 108, 135),
                borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:_buildList(),
          
                ),
              ),
              Positioned(
                top: animationOffset.dy,
                left: animationOffset.dx,
                child: CustomPaint(
                  painter: CheckPointPainter(Offset(10,0)),
                ),
              )
        ]
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> _widget_list = [];

    for(int i = 0; i < _list.length; i++){
      _widget_list.add(
        GestureDetector(
          onTap: (){
            indexedChecked(i);
          },
          child: Expanded(
            child: VerticalText(_list[i], _keys[i], 
                                checkIndex == i && (_animationController != null && _animationController!.isCompleted))
          ),
        )
      );
    }
    return _widget_list;
  }
  
  void indexedChecked(int i) {
    if (checkIndex == i) return;

    setState(() {
      checkIndex = i;
      calcuteCheckOffset();  
      addAnimation();
      
    });
  }
  
}

class CheckPointPainter extends CustomPainter{
  double pointRadius = 5;
  double radius = 30;
  Offset offset;

  CheckPointPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size){
    Paint paint = Paint()..style = PaintingStyle.fill;
    double startAngle = -math.pi/2;
    double sweepAngle = math.pi;

    paint.color = Color.fromARGB(255, 44, 108, 135);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(offset.dx, offset.dy), 
                      radius: radius), startAngle, 
                      sweepAngle, false, paint
    );
    paint.color = Color.fromARGB(255, 91, 222, 209);
    canvas.drawCircle(Offset(offset.dx - pointRadius/2, offset.dy - pointRadius/2),
                      pointRadius, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class VerticalText extends StatelessWidget {
  String name;
  bool checked;
  GlobalKey globalKey;
  VerticalText(this.name, this.globalKey, this.checked);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      key: globalKey,
      quarterTurns: 3,
      child: Text(
        name,
        style: TextStyle(
                color: checked ? Color.fromARGB(255, 91, 222, 209) : Color.fromARGB(255, 255, 255, 255), fontSize: 30),
      ),
    );
  }
}

Widget background() {
    return const Image(
      image: AssetImage('assets/img/dm_background.png'),
      height: double.infinity,
      fit: BoxFit.cover,
    );
}
