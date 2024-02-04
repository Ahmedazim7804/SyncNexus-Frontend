import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int otpIndextAt = 0;
  final List<String?> inputOtpList = ['', '', '', '', '', ''];

  void inputOtp(String input) {
    if (otpIndextAt > 5) {
      final String otp = inputOtpList.join();
    }
    setState(() {
      inputOtpList[otpIndextAt] = input;
    });

    otpIndextAt += 1;
  }

  void removeOtpDigit() {
    if (otpIndextAt != 0) {
      otpIndextAt -= 1;
      setState(() {
        inputOtpList[otpIndextAt] = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/otp.png',
                  height: 200,
                  width: 200,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: ElevatedButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor:
                            const Color.fromARGB(255, 226, 181, 31)),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.black,
                    )),
              )
            ],
          ),
          const Text("We have sent you an OTP on your number"),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 40,
                width: 40,
                child: Text(
                  inputOtpList[0] ?? '',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 40,
                width: 40,
                child: Text(
                  inputOtpList[1] ?? '',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 40,
                width: 40,
                child: Text(
                  inputOtpList[2] ?? '',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 40,
                width: 40,
                child: Text(
                  inputOtpList[3] ?? '',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 40,
                width: 40,
                child: Text(
                  inputOtpList[4] ?? '',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 40,
                width: 40,
                child: Text(
                  inputOtpList[5] ?? '',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 42,
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Didn't Receive the OTP?"),
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: Text(
                  "Resend",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding:
                const EdgeInsets.only(bottom: 16, right: 16, left: 16, top: 0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1.25,
              crossAxisSpacing: 40,
              mainAxisSpacing: 20,
              children: [
                OtpButton(
                  text: '1',
                  onTap: () => inputOtp('1'),
                ),
                OtpButton(
                  text: '2',
                  onTap: () => inputOtp('2'),
                ),
                OtpButton(
                  text: '3',
                  onTap: () => inputOtp('3'),
                ),
                OtpButton(
                  text: '4',
                  onTap: () => inputOtp('4'),
                ),
                OtpButton(
                  text: '5',
                  onTap: () => inputOtp('5'),
                ),
                OtpButton(
                  text: '6',
                  onTap: () => inputOtp('6'),
                ),
                OtpButton(
                  text: '7',
                  onTap: () => inputOtp('7'),
                ),
                OtpButton(
                  text: '8',
                  onTap: () => inputOtp('8'),
                ),
                OtpButton(
                  text: '9',
                  onTap: () => inputOtp('9'),
                ),

                // const SizedBox.shrink(),
                IconButton(
                  onPressed: removeOtpDigit,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 32,
                  ),
                  style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromARGB(255, 226, 181, 31)),
                ),
                OtpButton(
                  text: '0',
                  onTap: () => inputOtp('0'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OtpButton extends StatelessWidget {
  const OtpButton({super.key, required this.text, required this.onTap});

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color.fromARGB(255, 226, 181, 31)),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}
