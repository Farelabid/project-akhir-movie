import 'package:flutter/material.dart';
import 'package:sudutmovie/database/database_helper.dart';
import 'package:sudutmovie/screens/home_screen.dart';
import 'package:sudutmovie/screens/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    bool isLoggedIn = await DatabaseHelper.instance.login(
      _emailController.text,
      _passwordController.text,
    );

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email', labelStyle: GoogleFonts.poppins()),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password', labelStyle: GoogleFonts.poppins()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text(
                'Login',
                style: GoogleFonts.poppins(),
              ),
            ),
            TextButton(
              onPressed: _goToRegister,
              child: Text(
                'Don\'t have an account? Register here',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
