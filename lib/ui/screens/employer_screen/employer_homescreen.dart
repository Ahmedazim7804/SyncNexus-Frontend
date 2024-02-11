import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/bloc/cubit/employer_data_cubit.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/models/employer_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/provider/uid_provider.dart';
import 'package:worker_app/widgets/overlay_widget.dart';
import 'package:worker_app/ui/screens/employer_screen/widgets/add_employee_widget.dart';
import 'package:worker_app/ui/screens/employer_screen/widgets/add_task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker_app/bloc/cubit/employer_data_cubit.dart';

class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  List jobList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void addEmployeeSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddEmployeeWidget());
  }

  void addTaskSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddTaskWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 196, 72),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 226, 181, 31),
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        openButtonBuilder: RotateFloatingActionButtonBuilder(
            backgroundColor: const Color.fromARGB(255, 226, 181, 31),
            child: const Icon(
              Icons.add,
            )),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
            backgroundColor: const Color.fromARGB(255, 226, 181, 31),
            child: const Icon(
              Icons.add,
            )),
        type: ExpandableFabType.up,
        distance: 65,
        children: [
          FloatingActionButton.extended(
            heroTag: 'btn2',
            backgroundColor: const Color.fromARGB(255, 226, 181, 31),
            onPressed: addTaskSheet,
            label: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.lock_clock),
                Text(" Task"),
              ],
            ),
          ),
          FloatingActionButton.extended(
            heroTag: 'btn3',
            backgroundColor: const Color.fromARGB(255, 226, 181, 31),
            onPressed: addEmployeeSheet,
            label: const Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [Icon(Icons.person), Text(' Employee')],
            ),
          ),
        ],
      ),
      body: BlocConsumer<EmployerDataCubit, EmployerDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EmployerDataLoaded) {
            Employer employer = context.read<EmployerDataCubit>().employer;
            List<Employee> employeesList =
                context.read<EmployerDataCubit>().employeesList;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: MediaQuery.sizeOf(context).width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 226, 181, 31),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: ListTile(
                      dense: true,
                      isThreeLine: true,
                      title: const Text("Hi,"),
                      subtitle: Text(
                        employer.name,
                        style:
                            const TextStyle(fontSize: 26, color: Colors.black),
                      ),
                      trailing: Stack(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: Image.asset(
                              'assets/images/default_user.png',
                            ).image,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 234, 196, 72),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 165,
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 226, 181, 31),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          const Text(
                            "Total\nEmployees",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            employeesList.length.toString(),
                            style: const TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 165,
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 226, 181, 31),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Column(
                        children: [
                          Text(
                            "Total\nJobs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                                fontSize: 64, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  // padding: const EdgeInsets.symmetric(vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 226, 181, 31),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: ListTile(
                    onTap: () => context.push('/screens/employer/employees'),
                    leading: const Icon(Icons.person),
                    title: const Text("Employees"),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  // padding: const EdgeInsets.symmetric(vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 226, 181, 31),
                  ),
                  child: ListTile(
                    onTap: () => context.push('/screens/employer/jobs'),
                    leading: const Icon(Icons.work),
                    title: const Text("Jobs"),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  // padding: const EdgeInsets.symmetric(vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 226, 181, 31),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: ListTile(
                    onTap: () => context.push('/screens/employer/profile'),
                    leading: const Icon(Icons.person),
                    title: const Text("Your Profile"),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
