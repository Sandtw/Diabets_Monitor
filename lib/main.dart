import 'package:diabets_monitor/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:diabets_monitor/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diabets Monitor App',
        initialRoute: '/start',
        routes: {
          '/start': (_) =>  StageScreen(),
          '/login': (_) => const LoginScreen(),
          '/register': (_) => RegisterScreen(),
        },
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                      primary:Colors.white,
          ),
        ),
      ),
    );
  }
}