import 'package:flutter/material.dart';
import 'package:diabets_monitor/services/auth_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  String? title;
  String? uid;

  HomeScreen({Key? key,  this.title,  this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async => await authService.signOut(), 
            icon: const Icon(Icons.exit_to_app_outlined, color: Color.fromARGB(255, 11, 46, 98),)
          )
        ],
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Estas en el Home Screen'),
          Text('$title : $uid' ),
        ],
      ),
    );
  }
}
