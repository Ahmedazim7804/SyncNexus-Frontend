import 'package:flutter/material.dart';

class EmployerProfileScreen extends StatefulWidget {
  const EmployerProfileScreen({super.key});

  @override
  State<EmployerProfileScreen> createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          title: const Text(
            "Profile",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 234, 196, 72),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 120,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 226, 181, 31),
                    borderRadius: BorderRadius.only(
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
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage:
                          Image.asset('assets/images/default_user.png').image,
                    ),
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
                            labelText: 'Name',
                            labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Epilogue',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 226, 181, 31),
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
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Epilogue',
                              fontWeight: FontWeight.w500,
                              height: 0.06,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 226, 181, 31),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width / 4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      const Color.fromARGB(255, 226, 181, 31),
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () => {},
                              child: const Text(
                                'Save',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Epilogue',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  height: 0.06,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                )),
          ],
        ));
  }
}
