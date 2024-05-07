import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/buttons.dart';
import 'package:flutter_application_1/Components/My_Textfield.dart';

class Fillup extends StatefulWidget {
  final Function()? onTap;
  const Fillup({super.key, this.onTap});

  @override
  State<Fillup> createState() => _FillupState();
}

class _FillupState extends State<Fillup> {
  // Controllers
  final nameController = TextEditingController();
  final phoneNumberlController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final plateNumberlController = TextEditingController();
  final complainController = TextEditingController();
  final complain1Controller = TextEditingController();

  // Sign up method
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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
          message = 'SUBMITTED!';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
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
                        'REPORT FORM',
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
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: nameController,
                  hintText: 'Buong Pangalan ng Nagsumbong',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: phoneNumberlController,
                  hintText: 'Contact No.',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: plateNumberlController,
                  hintText: 'Plaka ng Sinakyan',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: complainController,
                  hintText: 'Uri ng sumbong o reklamo',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: complain1Controller,
                  hintText: 'Detalye ng iyong reklamo o sumbong',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyButton(
                  text: "SUBMIT",
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

// keyboardType: TextInputType.number, 
//                   inputFormatters: <TextInputFormatter> [
//                     LengthLimitingTextInputFormatter(11),
//                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                     FilteringTextInputFormatter.digitsOnly