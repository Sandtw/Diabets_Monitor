import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:diabets_monitor/utils/font.dart';
import 'package:diabets_monitor/widgets/widgets.dart';
import 'package:diabets_monitor/screens/screens.dart';
import 'package:diabets_monitor/services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 55),
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                   lottieAnimationLogin(),
                   FormLogin()
                ]
              ),
            )
              
          ],
        )  
      );
  }
}

class FormLogin extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final authService = Provider.of<AuthService>(context);
  final BoxDecoration decoration = BoxDecoration(
       color: const Color.fromARGB(248, 90, 120, 148).withOpacity(0.8),
       borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(80), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(40))
     );

    return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.only(bottom: 15),
     width: double.infinity,
     decoration: decoration,
     child: Column(
       children: [
        titleLogin(),
        InputField(hint: 'Correo electrónico', prefixIcon: Icons.mail, controller: emailController, type: 'text',),
        InputField(hint: 'Contraseña', prefixIcon: Icons.visibility_off, controller: passController, type: 'password',),
        forgotPassword(),
        const SizedBox(height: 20,),
        ButtonLogin(authService: authService, email : emailController, pass: passController)
      ],
     ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  final AuthService? authService;
  final TextEditingController? email;
  final TextEditingController? pass;

  const ButtonLogin({
    Key? key, this.authService, this.email,  this.pass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: MediaQuery.of(context).size.height*0.075,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            authService!.signInWithEmailAndPassword(email!.text, pass!.text);
          },
          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 35, 34, 55)),
          child: Text('Acceder', style: APTextStyle.titleInputButton,),
        ),
    );
  }
}


Widget lottieAnimationLogin(){
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5),
      child: Lottie.asset(
        'assets/json/dm_login.json',
        width: 320,
        height: 310,
        fit: BoxFit.fill
      ),
    );
}

Widget titleLogin(){
  return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          alignment: AlignmentDirectional.topStart,
          child: Text('Diabets Monitor' , style: APTextStyle.titleForm,)
        );
}

Widget forgotPassword(){
  return Container(
         padding: const EdgeInsets.only(right: 30,),
         alignment: AlignmentDirectional.centerEnd,
         child: GestureDetector(
           onTap: (){
             print('Olvidaste contraseña');
           }, 
           child: Text('Olvidaste tu contraseña?', style: APTextStyle.titleHaveAcount,)),
        );
}

