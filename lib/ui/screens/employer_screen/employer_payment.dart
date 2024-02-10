import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker_app/ui/widgets/workers/heading_text_widget.dart';

class EmployerPaymentScreen extends StatefulWidget {
  const EmployerPaymentScreen({super.key});

  @override
  State<EmployerPaymentScreen> createState() => _EmployerPaymentScreenState();
}

class _EmployerPaymentScreenState extends State<EmployerPaymentScreen> {
  void showPaymentSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddPaymentWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color.fromARGB(255, 226, 181, 31),
        onPressed: showPaymentSheet,
        label: const Text("Add Payment"),
        icon: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                'assets/images/payment.png',
                width: 320,
                height: 275,
              ),
            ),
            const PaymentCard(),
            const PaymentCard(),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard>
    with SingleTickerProviderStateMixin {
  late final Animation<double> heightFactorAnimation;
  late final AnimationController controller;
  bool isExpanded = false;
  ShapeBorder cardShape = const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    heightFactorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void toggleExpand() {
    if (isExpanded) {
      controller.reverse();
    } else {
      controller.forward();
    }
    isExpanded = !isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleExpand,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        // color: const Color.fromARGB(255, 234, 196, 72),
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/default_user.png'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ramesh Kumar",
                          style: GoogleFonts.urbanist(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Dec 25, 2024 07:15",
                          style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w500),
                        )
                        // Text(
                        //   "For transportation asdashdkj asdjash jkashdasdjk djsahdjk ashdkj sahkdjk haskj dhskajdhsakj dnash ahsjkd nhasjkd nhasjkd nhndhjdnhsajdhn kasd nhk",
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: GoogleFonts.urbanist(
                        //     color: Colors.grey.shade700,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      spacing: -3,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.currency_rupee,
                          size: 20,
                        ),
                        Text(
                          '128.00',
                          style: GoogleFonts.urbanist(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizeTransition(
                sizeFactor: heightFactorAnimation,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingText(text: "Notes"),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                          "For transportation asdashdkj asdjash jkashdasdjk djsahdjk ashdkj sahkdjk haskj dhskajdhsakj dnash ahsjkd nhasjkd nhasjkd nhndhjdnhsajdhn kasd nhk"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddPaymentWidget extends StatelessWidget {
  const AddPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color.fromRGBO(234, 196, 72, 1),
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
              child: Text("Add New Expense",
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
                fillColor: const Color.fromARGB(255, 226, 181, 31),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Amount (INR)",
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
                fillColor: const Color.fromARGB(255, 226, 181, 31),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Paid To",
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(
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
                  fillColor: const Color.fromARGB(255, 226, 181, 31),
                ),
                items: const [DropdownMenuItem(child: Text('Ramesh'))],
                onChanged: (aa) {}),
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
            //     fillColor: const Color.fromARGB(255, 226, 181, 31),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Notes",
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: 'Notes',
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
                fillColor: const Color.fromARGB(255, 226, 181, 31),
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
                        backgroundColor: Colors.transparent,
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
