import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:identicare/helper/helper_functions.dart';

class AuthServices {
  get context => displayMessageToUser;

  // google sign in method
  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
// try signing in with the signin method relying on the googlesignin instance above
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // condition
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      // pop it again
      displayMessageToUser(e.code, context);
    }
  }
}
