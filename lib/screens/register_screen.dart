import 'package:flutter/material.dart';
import 'package:diabets_monitor/screens/screens.dart';
import 'package:diabets_monitor/utils/font.dart';
import 'package:diabets_monitor/services/auth_services.dart';
import 'package:diabets_monitor/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 60),
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                   lottieAnimationSignup(),
                   FormSignup()
                ]
              ),
            )
              
          ],
        )  
      );
  }
}

class FormSignup extends StatefulWidget {
  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final celController = TextEditingController();
  final sexController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  //final authService = Provider.of<AuthService>(context);
  final BoxDecoration decoration = BoxDecoration(
       color: const Color.fromARGB(248, 90, 120, 148).withOpacity(0.3),
       borderRadius:  BorderRadius.circular(25)
     );

    return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    padding: const EdgeInsets.symmetric(vertical: 30),
     width: double.infinity,
     decoration: decoration,
     child: Form(
      key: formKey,
       child: Column(
         children: [
          InputField(hint: 'Nombre', prefixIcon: Icons.account_circle, controller: nameController, type: 'text',),
          InputField(hint: 'Apellido', prefixIcon: Icons.account_circle, controller: lastnameController, type: 'text'),
          InputField(hint: 'Celular', prefixIcon: Icons.phone_android, controller: celController, type: 'phone',),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.only(bottom: 10),
            child: DropdownButtonFormField(
              style: GoogleFonts.nunito(
                   fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold
              ),
              dropdownColor: Color.fromARGB(248, 211, 228, 244),
              icon: Icon(Icons.arrow_drop_down_circle_outlined),
              decoration: InputDecoration(
                hintText: 'Sexo',
                hintStyle: GoogleFonts.nunito(
                   fontSize: 18, fontWeight: FontWeight.bold
                ),
                prefixIcon: const Icon(Icons.person),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
                )
                
              ),
              items: const [
                DropdownMenuItem(value: 'M', child: Text('Masculino')),
                DropdownMenuItem(value: 'F', child: Text('Femenino'))
              ],
              onChanged: (value) {
              }
            ),
          ),
          InputField(hint: 'Correo electrónico', prefixIcon: Icons.mail, controller: emailController, type: 'email',),
          InputField(hint: 'Contraseña', prefixIcon: Icons.visibility_off, controller: passController, type: 'password',),
          const SizedBox(height: 20,),
          ButtonSignup(email : emailController, pass: passController, formKey: formKey,)
        ],
       ),
     ),
    );
  }
}

Widget lottieAnimationSignup(){
    return Container(
      height: 150,
      width: 200,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: Lottie.asset(
          'assets/json/dm_signup.json',
          width: double.infinity,
          fit: BoxFit.fill
        ),
      ),
    );
}

class ButtonSignup extends StatelessWidget {
  final AuthService? authService;
  final TextEditingController? email;
  final TextEditingController? pass;
  final formKey;
  
  const ButtonSignup({
    Key? key, this.authService, this.email,  this.pass, this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        height: MediaQuery.of(context).size.height*0.075,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if(formKey.currentState!.validate()){
              print('corrrect');
            }
            /*
            authService!.signInWithEmailAndPassword(email!.text, pass!.text);*/
          },
          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 35, 34, 55)),
          child: Text('Registrarse', style: APTextStyle.titleInputButton,),
        ),
    );
  }
}

