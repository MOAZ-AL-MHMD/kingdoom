import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign-In',
      theme: ThemeData(primarySwatch: Colors.red),
      home: AuthWrapper(), // 👈 هنا نقرر الصفحة حسب حالة الدخول
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // ⬅️ يستمع لتغير حالة الدخول
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          return HomePage(); // ✅ إذا مسجّل دخول، يعرض الصفحة الرئيسية
        } else {
          return LoginPage(); // 🟡 إذا غير مسجل، يعرض صفحة تسجيل الدخول
        }
      },
    );
  }
}
