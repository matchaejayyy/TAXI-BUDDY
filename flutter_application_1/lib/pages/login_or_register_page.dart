import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
import 'package:flutter_application_1/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

 // Function to toggle between Login and Register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
   // Display Login Page and pass the toggle function as a callback
  Widget build(BuildContext context) {
    if  (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
        );
    } else {
       // Display Register Page and pass the toggle function as a callback
      return RegisterPage(
        onTap: togglePages,
          
    );
  }
}
}