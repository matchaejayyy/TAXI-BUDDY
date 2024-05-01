import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Components/Buttons.dart';
import 'package:flutter_application_1/Components/My_Textfield.dart';
import 'package:flutter_application_1/Components/square_tile.dart';
import 'package:flutter_application_1/pages/forgot_password.dart';
import 'package:flutter_application_1/services/auth_service.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap; // Callback for sign up
  const LoginPage({super.key, required this.onTap});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  

  // Sign in method
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //remove loading thingi
      // ignore: use_build_context_synchronously
      Navigator.pop(context); 
      
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); 
      String message;
      // worng email
      if (e.code == 'user-not-found') {
        message = 'Invalid username or password.';
      // wong password
      } else if (e.code == 'wrong-password') {
        message = 'Invalid username or password.'; // Avoid logging password
      } else {
        message = 'Invalid Login Credentials. Please try again.';
      }
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
          child:SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                Image.asset(
                  'lib/logos/buddy.png',
                  width: 300,
                  height: 230,
                ),
                

                const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                  'SIGN IN',
                    style: TextStyle(
                      color: Colors.black, 
                      fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
                ),
              ),
              
              
        
                const SizedBox(height:15),
              
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height:15),
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height:15),
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn, 

                ),
                const SizedBox(height:15),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to ForgotPasswordPage (replace with your implementation)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height:1),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or Continue With',
                        style: TextStyle (fontWeight: FontWeight.bold))
                        
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,)
                      ),
                            
                    ],
                  ),
                ),


                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google Logo
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/logos/Googlelogo.png'),
                  ],
                )

             
            ],
          ),
        ),
      ),
    ),
  );
    
  }
}


