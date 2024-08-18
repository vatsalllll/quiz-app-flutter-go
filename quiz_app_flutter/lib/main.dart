import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pattern Sniper™ Quiz',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color(0xFF8B64D3),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<String?>(
              future: _authService.getUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return HomeScreen(
                    userEmail: snapshot.data,
                    totalPoints: 0,
                    currentLevel: 1,
                  );
                }
              },
            ),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => FutureBuilder<String?>(
              future: _authService.getUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return HomeScreen(
                    userEmail: snapshot.data,
                    totalPoints: 0,
                    currentLevel: 1,
                  );
                }
              },
            ),
      },
    );
  }
}
