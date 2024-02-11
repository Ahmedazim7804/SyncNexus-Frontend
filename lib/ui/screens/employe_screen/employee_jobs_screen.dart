import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/bloc/cubit/employee_location_cubit.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
import 'package:worker_app/ui/screens/employer_screen/widgets/add_job.dart';
import 'package:worker_app/ui/screens/employe_screen/widgets/workers/heading_text_widget.dart';

class EmployeeJobsScreen extends StatefulWidget {
  const EmployeeJobsScreen({super.key});

  @override
  State<EmployeeJobsScreen> createState() => _EmployeeJobsScreenState();
}

class _EmployeeJobsScreenState extends State<EmployeeJobsScreen> {
  Future<List<Job>> getNearbyJobs() async {
    LatLong latLong = context.read<EmployeeLocationCubit>().position;

    List<Job> jobs = [];

    final rawJobs = await getJobs(latLong.lat, latLong.long);

    for (final rawJob in rawJobs) {
      jobs.add(Job(
        title: rawJob['title'],
        desc: rawJob['description'],
        employerId: rawJob['employer_id'],
        amount: rawJob['amount'],
      ));
    }

    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Image.asset(
            'assets/images/jobs2.png',
            height: 100,
          ),
        ),
        const HeadingText(text: "Available Jobs", size: 32),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: getNearbyJobs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const JobItem();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      ],
    ));
  }
}

class JobItem extends StatefulWidget {
  const JobItem({super.key});

  @override
  State<JobItem> createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> with SingleTickerProviderStateMixin {
  late final Animation<double> heightFactorAnimation;
  late final AnimationController controller;
  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
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

  void toggleTaskItem() {
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
      onTap: toggleTaskItem,
      child: Card(
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
        color: const Color.fromARGB(255, 226, 181, 31),
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.info_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Fix The Roof",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                const Icon(Icons.person),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        text: "Employer : ",
                        children: [
                          WidgetSpan(
                              child: SizedBox(
                            width: 10,
                          )),
                          TextSpan(
                              text: "Ramesh",
                              style: TextStyle(fontWeight: FontWeight.normal)),
                        ])),
              ]),
              SizeTransition(
                sizeFactor: heightFactorAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromARGB(255, 234, 196, 72)),
                      child: const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                      child: Text(
                        "You have to collect some material and fix the roof. You have to bring tools they will not be provided",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {},
                    label: const Text(
                      "Intersted",
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
