import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/provider/uid_provider.dart';
import 'package:worker_app/widgets/overlay_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final OverlayPortalController overlayPortalController =
      OverlayPortalController();
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPermissionRequestDialog();
    });
    // TODO: implement initState
    super.initState();
  }

  void showPermissionRequestDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Permission Request",
            style:
                GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "This is app need Location permission to work. Please allow permission to continue to use app.",
            style: GoogleFonts.urbanist(fontSize: 16),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                requestPermission();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 234, 196, 72),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                "Allow",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void requestPermission() async {
    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }

    Permission.locationWhenInUse.request().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.denied ||
          permissionStatus == PermissionStatus.permanentlyDenied) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }

  void signInWithGoogle() async {
    overlayPortalController.show();
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
        overlayPortalController.hide();
        context.go(
          '/screens/authentication/other',
        );
      } else {
        overlayPortalController.hide();
        context.go('/screens/worker/homescreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // backgroundColor: const Color.fromARGB(255, 226, 181, 31),
      body: OverlayPortal(
        controller: overlayPortalController,
        overlayChildBuilder: overlayChildBuilder,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset('assets/images/login_image.png'),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Let's Get Started!",
                style: GoogleFonts.urbanist(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "With SyncNexus, coordinating tasks, tracking progress, and enhancing teamwork is simpler than ever before",
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  color: Colors.grey.shade700,
                  letterSpacing: 0.2,
                  fontSize: 17,
                ),
              ),
            ),
            const Text(
              "Continue with your google account!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: ListTile(
                onTap: signInWithGoogle,
                leading: Image.asset(
                  'assets/images/google.png',
                  width: 25,
                  height: 25,
                ),
                title: Center(
                  child: Text(
                    "Continue with Google",
                    style: GoogleFonts.urbanist(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/facebook.png',
                  width: 25,
                  height: 25,
                ),
                title: Center(
                  child: Text(
                    "Continue with Facebook",
                    style: GoogleFonts.urbanist(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Privacy Policy',
                      style: GoogleFonts.urbanist(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                Text('•',
                    style: GoogleFonts.urbanist(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                TextButton(
                    onPressed: () {},
                    child: Text('Terms of Service',
                        style: GoogleFonts.urbanist(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w600))),
              ],
            )
            // ElevatedButton.icon(
            //   onPressed: signInWithGoogle,
            //   icon: Image.asset(
            //     'assets/images/google.png',
            //     width: 25,
            //     height: 25,
            //   ),
            //   label: const Text("Sign in With Google"),
            //   style: ElevatedButton.styleFrom(
            //     // elevation: 5,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(4)),
            //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            //     shadowColor: Theme.of(context).scaffoldBackgroundColor,
            //     surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            //     // foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            //   ),
            // ),
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
      ),
    );
  }
}
