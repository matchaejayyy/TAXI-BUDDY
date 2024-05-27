import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Forgot password screen for password reset functionality
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Text field controller for user email
  final _emailController = TextEditingController();

  @override
  // gina clean up ya ang resources when the widget is disposed
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

// Function to send password reset email
  Future<void> passwordReset() async {
    try {
      // Send password reset email using Firebase Auth
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // ga Show success message after successful email sending
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A password reset link has been sent to your email.'),
        ),
      );
    } on FirebaseAuthException {
      // ga show siye error if invalid ang email
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Email"), // Display the error message
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Enter your email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: passwordReset,
                color: Colors.red, // Call the function directly on press
                child: const Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
