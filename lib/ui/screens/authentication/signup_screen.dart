import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

      FocusManager.instance.primaryFocus?.unfocus();
      context.push('/screens/authentication/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 226, 181, 31),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            dense: true,
            title: Text(
              "WELCOME",
              style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Enter your phone number to continue!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    cursorColor: Theme.of(context).colorScheme.onBackground,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 226, 181, 31)
                            .withAlpha(175),
                        isDense: true,
                        prefixIcon: const Icon(Icons.person),
                        errorText:
                            nameInvalid ? "Please enter correct name" : null,
                        hintText: "e.g. Mahesh",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _phoneNumberController,
                    cursorColor: Theme.of(context).colorScheme.onBackground,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        errorText: phoneInvalid
                            ? "Please enter correct phone number."
                            : null,
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 226, 181, 31)
                            .withAlpha(175),
                        isDense: true,
                        prefixIcon: const Icon(Icons.phone),
                        hintText: "e.g. +91 000000000",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
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
                      'Continue',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
