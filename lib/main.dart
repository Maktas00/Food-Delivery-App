import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yemekler/auth/auth_gate.dart';
import 'package:yemekler/firebase_options.dart';
import 'package:yemekler/ui/cubit/anasayfa_cubit.dart';
import 'package:yemekler/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemekler/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemekler/ui/views/anasayfa.dart';
import 'package:yemekler/ui/views/detay_sayfa.dart';
import 'package:yemekler/ui/views/giris_sayfa.dart';
import 'package:yemekler/ui/views/kayit_sayfa.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AnasayfaCubit()),
        BlocProvider(create: (context)=>DetaySayfaCubit()),
        BlocProvider(create: (context)=>SepetSayfaCubit()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
       home: AuthGate(),
       // home: Anasayfa(),
      
      ),
    );
  }
}

