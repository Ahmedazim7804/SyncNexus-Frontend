import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:worker_app/provider/user_provider.dart';

class SignUpStep2 extends StatefulWidget {
  const SignUpStep2({super.key});

  @override
  State<SignUpStep2> createState() => _SignUpStepsScreenState();
}

class _SignUpStepsScreenState extends State<SignUpStep2> {
  void nextEmployee() async {
    context.read<UserProvider>().employee = true;
    print(await FirebaseAuth.instance.currentUser!.getIdToken());
    context.read<UserProvider>().createUser().then((_) {
      final prefs = context.read<SharedPreferences>();
      prefs.setBool('employee', true);
      context.go('/screens/employer/homescreen');
    });
  }

  void nextEmployer() async {
    context.read<UserProvider>().employee = false;

    context.read<UserProvider>().createUser().then((_) {
      final prefs = context.read<SharedPreferences>();
      prefs.setBool('employee', false);
      context.go('/screens/employer/homescreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 181, 31),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 4.5,
              ),
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimelineTile(
                      isFirst: true,
                      axis: TimelineAxis.horizontal,
                      indicatorStyle: const IndicatorStyle(
                          color: Colors.lightGreen, width: 30, height: 30),
                      afterLineStyle: const LineStyle(
                          color: Colors.lightGreen, thickness: 1),
                      endChild: Container(
                        constraints: const BoxConstraints(minWidth: 100),
                      ),
                    ),
                    TimelineTile(
                      axis: TimelineAxis.horizontal,
                      beforeLineStyle: const LineStyle(
                          color: Colors.lightGreen, thickness: 1),
                      indicatorStyle: const IndicatorStyle(
                          color: Colors.lightGreen, width: 30, height: 30),
                      afterLineStyle:
                          const LineStyle(color: Colors.white, thickness: 1),
                      endChild: Container(
                        constraints: const BoxConstraints(minWidth: 100),
                      ),
                    ),
                    TimelineTile(
                      isLast: true,
                      axis: TimelineAxis.horizontal,
                      beforeLineStyle:
                          const LineStyle(color: Colors.white, thickness: 1),
                      indicatorStyle: const IndicatorStyle(
                          color: Colors.white, width: 30, height: 30),
                      afterLineStyle:
                          const LineStyle(color: Colors.white, thickness: 1),
                      endChild: Container(
                        constraints: const BoxConstraints(minWidth: 100),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.only(top: 24),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 234, 196, 72),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 30),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 226, 181, 31),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: const Text(
                                "Choose Your Role",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        ElevatedButton(
                          onPressed: nextEmployer,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              backgroundColor:
                                  const Color.fromARGB(255, 226, 181, 31)),
                          child: const Text(
                            "Employer",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: nextEmployee,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              backgroundColor:
                                  const Color.fromARGB(255, 226, 181, 31)),
                          child: const Text(
                            "Employee",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
