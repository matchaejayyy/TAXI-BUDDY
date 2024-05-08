import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/components/buttons.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

class Fillup extends StatefulWidget {
  final Function()? onTap;
  const Fillup({Key? key, this.onTap}) : super(key: key);

  @override
  State<Fillup> createState() => _FillupState();
}

class _FillupState extends State<Fillup> {
  // Controllers
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final plateNumberController = TextEditingController();
  final complain1Controller = TextEditingController();

  String? _selectedComplaint;

  // check if all fields are filled
  bool areAllFieldsFilled() {
    return emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        plateNumberController.text.isNotEmpty &&
        complain1Controller.text.isNotEmpty &&
        _selectedComplaint != null;
  }

  void signUserUp() async {
    if (!areAllFieldsFilled()) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill up all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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
                  controller: phoneNumberController,
                  hintText: 'Contact No.',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                MyTextfield(
                  controller: plateNumberController,
                  hintText: 'Plaka ng Sinakyan',
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedComplaint,
                            hint: Text('Uri ng sumbong o reklamo'),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedComplaint = value;
                              });
                            },
                            items: <String>[
                              'Fare (Pamasahe)',
                              'Safety (Kaligtasan)',
                              'Others (Iba pang bagay)'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
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
