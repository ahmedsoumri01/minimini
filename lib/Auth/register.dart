import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/register.png', // Make sure the path is correct
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
          const SizedBox(height: 20),
ElevatedButton(
  onPressed: () {
    _handleRegister(context);
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.green, // Set the background color to green
    onPrimary: Colors.white, // Set the text color to white
    minimumSize: const Size(200, 48), // Set the width and height of the button
  ),
  child: const Text('Register now'),
),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the login page
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegister(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;

    // Check if the email is already registered
    if (prefs.containsKey('email')) {
      _showMessage('Email already registered');
    } else {
      // Register the new user
      prefs.setString('email', enteredEmail);
      prefs.setString('password', enteredPassword);
      _showMessage('Registration Successful');
      _showRegisterSuccessDialog(context);
    }
  }

  void _showRegisterSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the login page
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
