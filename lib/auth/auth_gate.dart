import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yemekler/ui/views/anasayfa.dart';
import 'package:yemekler/ui/views/giris_sayfa.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Anasayfa();
          }
          else{
            return GirisSayfa();
          }
        },
      ),
    );
  }
}
