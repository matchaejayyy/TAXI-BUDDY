import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A password reset link has been sent to your email.'),
        ),
      );
    } on FirebaseAuthException {
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

  