import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/provider/uid_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((userCredential) {
      context.read<UidProvider>().uid = userCredential.user!.uid;

      if (userCredential.additionalUserInfo!.isNewUser) {
        context.goNamed('/screens/authentication/signup/steps/1',
            pathParameters: {'uid': userCredential.user!.uid});
      } else {
        context.go('/screens/worker/homescreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 226, 181, 31),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),

          const Center(
            child: Icon(
              Icons.lock,
              size: 200,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "WELCOME",
            style: TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Continue with your google account!",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton.icon(
            onPressed: signInWithGoogle,
            icon: Image.asset(
              'assets/images/google.png',
              width: 25,
              height: 25,
            ),
            label: const Text("Sign in With Google"),
            style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: const Color.fromARGB(255, 226, 181, 31)),
          )
          // SizedBox(
          //   width: double.infinity,
          //   child: Image.asset(
          //     'assets/images/otp.png',
          //     height: 200,
          //     width: 200,
          //   ),
          // ),
        ],
      ),
    );
  }
}
