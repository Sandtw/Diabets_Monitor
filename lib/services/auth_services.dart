import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:diabets_monitor/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final _firestoreRegister = FirebaseFirestore.instance;
  
  //  Métodos para escuchar los cambios de estado de autenticación
  User? _userFromFirebase(auth.User? user){
    //* auth.User : El tipo de dato Usuario que maneja firebase_auth
    if(user == null){
      return null;
    }
    return User(user.uid, user.email);
  }

  // Firebase Auth le permite suscribirse en tiempo real a este estado a través de Stream . 
  // Una vez llamado,  el flujo proporciona un evento inmediato del estado de autenticación actual del usuario y luego proporciona eventos posteriores cada vez que cambia el estado de autenticación.
  Stream<User?>? get user{
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  } 

  Future<User?> signInWithEmailAndPassword(String email,String password) async {
    //? signInWithEmailAndPassword: Intentos de iniciar sesión de un usuario con la dirección de correo electrónico y la contraseña dadas
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  //? Intenta crear una nueva cuenta de usuario con la dirección de correo electrónico y la contraseña proporcionadas.
  Future<User?> createUserWithEmailAndPassword({required String firstName, required String lastName, required String email, required String password, required String phone, required String sex}) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    await _firestoreRegister.collection("users").doc(credential.user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'sex': sex
      });

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}