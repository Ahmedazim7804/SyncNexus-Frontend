import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/bloc/cubit/employer/data_cubit.dart';
import 'package:worker_app/bloc/cubit/employer/payments_cubit.dart';
import 'package:worker_app/models/employer_model.dart';
import 'package:worker_app/models/payment_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/provider/user_endpoints.dart';
import 'package:worker_app/ui/screens/employee_screen/widgets/workers/heading_text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worker_app/ui/screens/employer_screen/widgets/payment_details_sheet.dart';

class EmployerPaymentScreen extends StatefulWidget {
  const EmployerPaymentScreen({super.key});

  @override
  State<EmployerPaymentScreen> createState() => _EmployerPaymentScreenState();
}

class _EmployerPaymentScreenState extends State<EmployerPaymentScreen> {
  late final EmployerPaymentsCubit employerPaymentsCubit;

  void showPaymentSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddPaymentWidget());
  }

  @override
  void initState() {
    employerPaymentsCubit = EmployerPaymentsCubit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => employerPaymentsCubit,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          onPressed: showPaymentSheet,
          label: const Text("Add Payment"),
          icon: const Icon(Icons.add),
        ),
        body: BlocBuilder<EmployerPaymentsCubit, EmployerPaymentsState>(
          builder: (context, state) {
            if (state is EmployerPaymentsLoaded) {
              List<Payment> payments =
                  context.read<EmployerPaymentsCubit>().payments;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/payment.png',
                        width: 320,
                        height: 250,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: payments.length,
                      itemBuilder: (context, index) =>
                          PaymentCard(payment: payments[index]),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key, required this.payment});

  final Payment payment;

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

  void showDetailedPaymentDetails() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: PaymentDetailsSheet(payment: widget.payment)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showDetailedPaymentDetails, //toggleExpand,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        // color: Colors.white,
        surfaceTintColor: Colors.transparent,
        color: Colors.grey.shade200,
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
                          widget.payment.paidTo.name,
                          style: GoogleFonts.urbanist(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.payment.createdAt,
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
                          '${widget.payment.amount.toDouble()}',
                          style: GoogleFonts.urbanist(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // SizeTransition(
              //   sizeFactor: heightFactorAnimation,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const HeadingText(text: "Notes"),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 24, vertical: 8),
              //         child: Text(widget.payment.remarks),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class AddPaymentWidget extends StatefulWidget {
  const AddPaymentWidget({super.key});

  @override
  State<AddPaymentWidget> createState() => _AddPaymentWidgetState();
}

class _AddPaymentWidgetState extends State<AddPaymentWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  late final employeesList = context.read<EmployerDataCubit>().employeesList;

  bool showTitleErrorText = false;
  bool showAmountErrorText = false;

  String? paidToUid;

  bool get inputIsValid {
    if (titleController.text.length < 5) {
      setState(() {
        showTitleErrorText = true;
      });
      return false;
    }

    final amount = int.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        showAmountErrorText = true;
      });
      return false;
    }

    if (paidToUid == null) {
      return false;
    }

    return true;
  }

  void addPayment() {
    if (inputIsValid) {
      String title = titleController.text;
      String amount = amountController.text;
      String notes = notesController.text;

      addPayments(paidToUid!, notes, 'INR', int.parse(amount));
    }
  }

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
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (showTitleErrorText) {
                    setState(() {
                      showTitleErrorText = false;
                    });
                  }
                }
              },
              controller: titleController,
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
                errorText:
                    showTitleErrorText ? "Please enter valid title" : null,
                filled: true,
                fillColor: const Color(0xFFfafafa),
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
              controller: amountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final amount = int.tryParse(value);
                if (amount != null && amount > 0) {
                  if (showAmountErrorText) {
                    setState(() {
                      showAmountErrorText = false;
                    });
                  }
                }
              },
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
                errorText:
                    showAmountErrorText ? "Please enter valid amount." : null,
                filled: true,
                fillColor: const Color(0xFFfafafa),
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
                  fillColor: const Color(0xFFfafafa),
                ),
                items: employeesList
                    .map((employee) => DropdownMenuItem<String>(
                          value: employee.id,
                          child: Text(employee.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    paidToUid = value;
                  }
                }),
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
              "Notes",
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: notesController,
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
                    onPressed: addPayment,
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
