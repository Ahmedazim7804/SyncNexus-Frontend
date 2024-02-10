import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/ui/screens/employer_screen/employees_list_screen.dart';

class AddJobWidget extends StatelessWidget {
  const AddJobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white
          // color: Color.fromRGBO(234, 196, 72, 1),
          ),
      child: SingleChildScrollView(
          child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Add New Job",
                  style: GoogleFonts.urbanist(
                      fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Text(
              "Title",
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: const Color(0xFFfafafa),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Payment (INR)",
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: '0',
                labelStyle: const TextStyle(
                  // color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Epilogue',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: const Color(0xFFfafafa),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   "Paid To",
            //   style: GoogleFonts.urbanist(
            //       fontSize: 18, fontWeight: FontWeight.w600),
            // ),
            // DropdownButtonFormField(
            //     decoration: InputDecoration(
            //       floatingLabelBehavior: FloatingLabelBehavior.never,
            //       contentPadding:
            //           const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       filled: true,
            //       fillColor: const Color(0xFFfafafa),
            //     ),
            //     items: const [DropdownMenuItem(child: Text('Ramesh'))],
            //     onChanged: (aa) {}),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Paid To',
            //     labelStyle: const TextStyle(
            //       // color: Colors.black,
            //       fontSize: 16,
            //       fontFamily: 'Epilogue',
            //       fontWeight: FontWeight.w500,
            //       height: 0.06,
            //     ),
            //     floatingLabelBehavior: FloatingLabelBehavior.never,
            //     contentPadding:
            //         const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     filled: true,
            //     fillColor: Color(0xFAFAFA),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Description",
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 100,
              minLines: 3,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                labelStyle: const TextStyle(
                  // color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Epilogue',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: const Color(0xFFfafafa),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFfafafa),
                        elevation: 0,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text('Cancel',
                        style: GoogleFonts.urbanist(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromARGB(255, 226, 181, 31),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      'Save',
                      style: GoogleFonts.urbanist(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
