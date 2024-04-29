import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  // for google sign in
  signInWithGoogle() async {
  // interactive sign in process
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();


  // obrain Auth details from request
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;


  // create new credentials for the user
  final Credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );

  // sign in
  return await FirebaseAuth.instance.signInWithCredential(Credential);
  }

  
}