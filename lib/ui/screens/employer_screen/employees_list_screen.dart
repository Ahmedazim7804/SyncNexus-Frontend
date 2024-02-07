import 'package:flutter/material.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:go_router/go_router.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({super.key});

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 196, 72),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          title: const Text(
            "Employees",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            EmployeeItem(
              employee: Employee(name: "sss", phone: "sss"),
            )
          ],
        ));
  }
}

class EmployeeItem extends StatefulWidget {
  const EmployeeItem({super.key, required this.employee});

  final Employee employee;

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.employee.hashCode),
      onDismissed: (direction) {},
      background: Container(
        color: Colors.red,
      ),
      child: InkWell(
        onTap: () => context.push('/screens/employer/employee'),
        child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 181, 31),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          Image.asset('assets/images/default_user.png').image,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    RichText(
                      text: const TextSpan(
                          text: "Manoj Kumar\n",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Since 19/01/2023",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87))
                          ]),
                    ),
                    const Spacer(),
                    IconButton(
                        icon: const Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const CircleBorder()),
                        onPressed: () {}),
                  ],
                ),
                const ListTile(
                  // dense: true,
                  leading: Icon(Icons.phone),
                  title: Text('9315082028'),
                )
              ],
            )),
      ),
    );
  }
}
