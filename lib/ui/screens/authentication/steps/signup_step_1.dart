import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:worker_app/provider/user_provider.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({super.key, required this.uid});

  final String uid;

  @override
  State<SignUpStep1> createState() => _SignUpStepsScreenState();
}

class _SignUpStepsScreenState extends State<SignUpStep1> {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool nameInvalid = false;
  bool phoneInvalid = false;

  bool get validateInputs {
    if (_phoneNumberController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      if (_nameController.text.length < 3) {
        setState(() {
          nameInvalid = true;
        });
        return false;
      }

      if (_phoneNumberController.text.length < 8) {
        setState(() {
          phoneInvalid = true;
        });
        return false;
      }

      return true;
    } else {
      setState(() {
        nameInvalid = true;
        phoneInvalid = true;
      });
    }

    return false;
  }

  void submit() {
    if (validateInputs) {
      String name = _nameController.text;
      String phone = _phoneNumberController.text;

      setState(() {
        nameInvalid = false;
        phoneInvalid = false;
      });

      final prefs = context.read<SharedPreferences>();
      prefs.setString('name', name).then((_) {
        prefs.setString('phone', phone).then((__) {
          context.read<UserProvider>().uid = widget.uid;
          context.read<UserProvider>().name = name;
          context.read<UserProvider>().phone = phone;

          context.go('/screens/authentication/signup/steps/2');
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 181, 31),
      // resizeToAvoidBottomInset: false,
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
                      afterLineStyle:
                          const LineStyle(color: Colors.white, thickness: 1),
                      endChild: Container(
                        constraints: const BoxConstraints(minWidth: 100),
                      ),
                    ),
                    TimelineTile(
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
                                "Enter Your Details",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextField(
                            controller: _nameController,
                            cursorColor:
                                Theme.of(context).colorScheme.onBackground,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 226, 181, 31)
                                        .withAlpha(175),
                                isDense: true,
                                prefixIcon: const Icon(Icons.person),
                                errorText: nameInvalid
                                    ? "Please enter correct name"
                                    : null,
                                hintText: "e.g. Mahesh",
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextField(
                            controller: _phoneNumberController,
                            cursorColor:
                                Theme.of(context).colorScheme.onBackground,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                errorText: phoneInvalid
                                    ? "Please enter correct phone number."
                                    : null,
                                labelText: 'Phone',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 226, 181, 31)
                                        .withAlpha(175),
                                isDense: true,
                                prefixIcon: const Icon(Icons.phone),
                                hintText: "e.g. +91 000000000",
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: submit,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              backgroundColor:
                                  const Color.fromARGB(255, 226, 181, 31)),
                          child: const Text(
                            'Next',
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
