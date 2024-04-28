import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:200),
                const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  'FORGOT PASSWORD',
                    style: TextStyle(
                      color: Colors.black, 
                      fontWeight: FontWeight.bold, fontSize: 30),
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
              )
            ),
            
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
              onPressed: () {
                // TODO: Implement password reset logic here
                final email = _emailController.text;
                print('Reset password for $email');
              },
              child: const Text('Submit'),
              )
            ),
          ],
        ),
      ),
    );
  }
}
                
  