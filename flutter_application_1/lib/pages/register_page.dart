import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/buttons.dart';
import 'package:flutter_application_1/Components/My_Textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
   // Callback function for navigation
  final Function()? onTap; 
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   // Text field controllers para sa user input
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberlController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign up method
  Future<void> signUserUp() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    // ga create sng new document sa  "Users" collection sa firebase with user details
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'username': firstNameController.text,
        'email': emailController.text,
        'Phone Number': phoneNumberlController.text,
      });

      // Registration successful (handle accordingly)
      Navigator.pop(context); // Remove loading indicator
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Remove loading indicator

      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          message = 'The email address is invalid.';
          break;
        default:
          message = 'Registration failed. Please try again.';
      }
      // ga Show error message as a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                MyTextfield(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: phoneNumberlController,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
