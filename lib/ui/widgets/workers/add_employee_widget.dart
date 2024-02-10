import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/ui/screens/employer_screen/employees_list_screen.dart';

class AddEmployeeWidget extends StatelessWidget {
  const AddEmployeeWidget({super.key});

  void searchEmployeeOnFirebase() {
    final firebase = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    List<Employee> searchedEmployee = [
      Employee(name: "Ramesh", phone: "9315082027")
    ];

    return Container(
      // height: double.infinity,
      // height: 100,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(234, 196, 72, 1),
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
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                    onPressed: searchEmployeeOnFirebase,
                    icon: const Icon(Icons.check),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: const CircleBorder()))
              ],
            ),
            SearchedEmployeeItem(employee: searchedEmployee[0])
          ],
        ),
      )),
    );
  }
}

class SearchedEmployeeItem extends StatelessWidget {
  const SearchedEmployeeItem({super.key, required this.employee});

  final Employee employee;

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
          title: const Text(
            "Manoj Kumar",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: const Wrap(children: [
            Icon(
              Icons.phone,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '9315082027',
              style: TextStyle(color: Colors.black, fontSize: 17),
            )
          ]),
          trailing: IconButton(
              icon: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, shape: const CircleBorder()),
              onPressed: () {}),
        ));
  }
}
