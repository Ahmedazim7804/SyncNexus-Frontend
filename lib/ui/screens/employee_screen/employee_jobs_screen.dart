import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/bloc/cubit/employee/location_cubit.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
import 'package:worker_app/ui/screens/employer_screen/widgets/add_job.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker_app/models/lat_long_model.dart';
import 'package:worker_app/ui/screens/employee_screen/widgets/workers/heading_text_widget.dart';

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
          amount: rawJob['amount'].toString(),
          jobId: rawJob['id']));
    }

    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Available Jobs",
            style:
                GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            color: const Color.fromARGB(255, 234, 196, 72),
          ),
        ),
        body: BlocBuilder<EmployeeLocationCubit, EmployeeLocationState>(
          builder: (context, state) {
            if (state is LocationDisabled) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/map.png',
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Please Enable Location",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(fontSize: 32),
                    )
                  ],
                ),
              );
            } else {
              return FutureBuilder(
                future: getNearbyJobs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Job> jobs = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: jobs.length,
                        itemBuilder: (context, index) => JobItem(
                          job: jobs[index],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
          },
        ));
  }
}

class JobItem extends StatefulWidget {
  const JobItem({super.key, required this.job});

  final Job job;

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
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: const Color.fromARGB(255, 226, 181, 31),
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outlined,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.job.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(Icons.person),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        text: "Employer : ",
                        children: [
                          const WidgetSpan(
                              child: SizedBox(
                            width: 10,
                          )),
                          TextSpan(
                              text: widget.job.employerId,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                        ])),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(Icons.person),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        text: "Amount : ",
                        children: [
                          const WidgetSpan(
                              child: SizedBox(
                            width: 10,
                          )),
                          TextSpan(
                              text: widget.job.amount.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
