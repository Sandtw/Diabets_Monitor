import 'package:diabets_monitor/screens/screens.dart';
import 'package:flutter/material.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  AppContainer(),
    );
  }
}

class AppContainer extends StatefulWidget {
  AppContainer({Key? key}) : super(key: key);

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  final List<String> menuItems = ['Iniciar Sesión', 'Registrar'];
  final List<IconData> menuIcons = [Icons.login_outlined, Icons.app_registration];

  bool siderbarOpen = false;
  double yOffset = 0;
  double xOffset = 0;
  double pageScale = 1;

  int selectedMenuItem = 0;
  String pageTitle = "Inicio de sesión";
  Widget currentPage = LoginScreen();

  void setPageTitle(){
    switch(selectedMenuItem){
      case 0:
        pageTitle = "Inicio de sesión";
        currentPage = LoginScreen();
        break;
      case 1: 
        pageTitle = "Registrarse";
        currentPage = RegisterScreen();
        break;
    }
  }

  void setSidebarState(){
    setState(() {
      xOffset = siderbarOpen ? 265 : 60;
      yOffset = siderbarOpen ? 130 : 0;
      pageScale = siderbarOpen ? 0.7 : 1;
    });
  }

  @override
  void initState() {
    setSidebarState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        children: [
          Container(
            color: Color(0xFFB1F2B36),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: menuItems.length,
                      itemBuilder: ((_, index) {
                        return GestureDetector(
                          onTap: (){
                            siderbarOpen = false;
                            selectedMenuItem = index;
                            setSidebarState();
                            setPageTitle();
                          },
                          child: MenuItem(menuIcon: menuIcons[index], menuItem: menuItems[index], selected: selectedMenuItem, position: index,),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 200),
              transform: Matrix4.translationValues(xOffset, yOffset, 1.0)..scale(pageScale),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: siderbarOpen ? BorderRadius.circular(20) : BorderRadius.circular(0)
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 45),
                    height: 60,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            siderbarOpen = !siderbarOpen;
                            setSidebarState();
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            child: Icon(Icons.menu)
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(pageTitle, style: TextStyle(fontSize: 18),),

                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: currentPage,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.menuIcon,
    required this.menuItem, required this.selected, required this.position,
  }) : super(key: key);

  final IconData menuIcon;
  final String menuItem;
  final int selected;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected == position ? Color(0xFFB151E26):Color(0xFFB1F2B36),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Icon(menuIcon, color: Colors.white,)),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              menuItem,
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 16
            ),
            ),
          ),
                      
        ],
      )
    );
  }
}