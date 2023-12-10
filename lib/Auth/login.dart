import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/login1.png', // Make sure the path is correct
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _handleLogin(context);
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('Don\'t have an account? Register now'),
          ),
        ],
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Using null-aware operators to handle null values
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;

    if (storedEmail != null && storedPassword != null) {
      if (enteredEmail == storedEmail && enteredPassword == storedPassword) {
        // Successful login
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Failed login
        _showMessage('Login Failed');
      }
    } else {
      // Handle the case where storedEmail or storedPassword is null
      _showMessage('Stored credentials not found');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
