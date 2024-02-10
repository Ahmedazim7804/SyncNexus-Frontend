import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OthersDetailScreen extends StatefulWidget {
  const OthersDetailScreen({super.key});

  @override
  State<OthersDetailScreen> createState() => _OthersDetailScreenState();
}

class _OthersDetailScreenState extends State<OthersDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcfcfc),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Getting started!✌️",
              style:
                  GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "Look like you are new to us! Create an account for a complete experience.",
                textAlign: TextAlign.center,
                style: GoogleFonts.mulish(
                    color: const Color(0xFF8e8ea9),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  // suffixIcon: Icon(Icons.),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Epilogue',
                    fontWeight: FontWeight.w500,
                    height: 0.06,
                  ),
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
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
