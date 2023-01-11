import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diabets_monitor/services/auth_services.dart';
import 'package:diabets_monitor/models/user_model.dart';
import 'package:diabets_monitor/screens/screens.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          return user == null ? const StageScreen() : HomeScreen(uid: user.uid, title: 'Bienvenido: ',);
        }else{
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}