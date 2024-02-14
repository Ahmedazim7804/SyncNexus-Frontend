import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployerProfileScreen extends StatefulWidget {
  const EmployerProfileScreen({super.key});

  @override
  State<EmployerProfileScreen> createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool showNameErrorText = false;
  bool showPhoneErrorText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: Text(
            "Profile",
            style:
                GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
            ),
            Positioned(
              left: (MediaQuery.sizeOf(context).width / 2) - 48,
              top: 120 - 48,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                        width: 48 * 2,
                        height: 48 * 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: Image.asset(
                          'assets/images/default_user.png',
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black87,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.sizeOf(context).height / 3.5,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: const TextStyle(
                              // color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Epilogue',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorText: showNameErrorText
                                ? "Please enter valid title"
                                : null,
                            filled: true,
                            fillColor: const Color(0xFFfafafa),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            labelStyle: const TextStyle(
                              // color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Epilogue',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorText: showPhoneErrorText
                                ? "Please enter valid title"
                                : null,
                            filled: true,
                            fillColor: const Color(0xFFfafafa),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.sizeOf(context).width / 3.5,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color.fromARGB(
                                          255, 226, 181, 31),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text(
                                    'Save',
                                    style: GoogleFonts.urbanist(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ]),
                )),
          ],
        ));
  }
}
