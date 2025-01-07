import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medex/firebase_options.dart';
import 'package:medex/screens/home_screen.dart';
import 'package:medex/screens/sign_up.dart';
import 'package:medex/sidebar/sidebar_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Medex());
}

class Medex extends StatefulWidget {
  const Medex({super.key});

  @override
  State<Medex> createState() => _MedexState();
}

class _MedexState extends State<Medex> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data != null) {
              return SidebarLayout();
            }
            return const SignUpPage();
          }),
    );
  }
}
