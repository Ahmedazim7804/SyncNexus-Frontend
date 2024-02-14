import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker_app/bloc/cubit/employer_data_cubit.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/ui/screens/employer_screen/widgets/employees_list.dart';
import 'package:worker_app/widgets/overlay_widget.dart';

class AddEmployeeWidget extends StatefulWidget {
  const AddEmployeeWidget({super.key});

  void searchEmployeeOnFirebase() {
    final firebase = FirebaseAuth.instance;
  }

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
  final TextEditingController phoneController = TextEditingController();
  final OverlayPortalController overlayPortalController =
      OverlayPortalController();

  List<Employee> searchedEmployee = [];
  void searchEmployeeOnBackend() async {
    Map<dynamic, dynamic> searchResult =
        await searchByPhone(phoneController.text);

    setState(() {
      searchedEmployee.add(Employee(
          name: searchResult['name'],
          phone: searchResult['phone_no'],
          email: searchResult['email'],
          id: searchResult['id']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: overlayPortalController,
      overlayChildBuilder: overlayChildBuilder,
      child: Container(
        // height: double.infinity,
        // height: 100,
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        prefixText: "+91 ",
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
                  ),
                  IconButton(
                      onPressed: searchEmployeeOnBackend,
                      icon: const Icon(Icons.check),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          shape: const CircleBorder()))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: searchedEmployee.length,
                itemBuilder: (context, index) => SearchedEmployeeItem(
                  employee: searchedEmployee[index],
                  overlayController: overlayPortalController,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class SearchedEmployeeItem extends StatefulWidget {
  const SearchedEmployeeItem(
      {super.key, required this.employee, required this.overlayController});

  final Employee employee;
  final OverlayPortalController overlayController;

  @override
  State<SearchedEmployeeItem> createState() => _SearchedEmployeeItemState();
}

class _SearchedEmployeeItemState extends State<SearchedEmployeeItem> {
  void bindEmployeeToEmployer() async {
    widget.overlayController.show();
    await context.read<EmployerDataCubit>().bindEmployee(widget.employee);
    widget.overlayController.hide();
    Navigator.pop(context);
  }

  void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          title: Text(
            "Are You Sure?",
            style:
                GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "You are going to employ a employee, please confirm the action",
            style: GoogleFonts.urbanist(fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                )),
            ElevatedButton(
              onPressed: () {
                bindEmployeeToEmployer();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 234, 196, 72),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 226, 181, 31),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: ListTile(
          // dense: true,
          leading: CircleAvatar(
            backgroundImage:
                Image.asset('assets/images/default_user.png').image,
          ),
          title: Text(
            widget.employee.name,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Wrap(children: [
            const Icon(
              Icons.phone,
              color: Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.employee.phone,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            )
          ]),
          trailing: IconButton(
              icon: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, shape: const CircleBorder()),
              onPressed: () => showConfirmDialog(context)),
        ));
  }
}
