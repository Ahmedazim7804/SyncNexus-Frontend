import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker_app/bloc/cubit/job_cubit.dart';
import 'package:worker_app/models/job_model.dart';

class JobCardWidget extends StatelessWidget {
  const JobCardWidget({super.key, required this.job, required this.jobStatus});

  final Job job;
  final JobStatus jobStatus;

  @override
  Widget build(BuildContext context) {
    void toggleJob() {
      BlocProvider.of<JobCubit>(context).toggleJob();
    }

    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        if (state is JobLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          Job job = context.read<JobCubit>().job;
          JobStatus jobStatus = context.read<JobCubit>().jobStatus;

          return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: const Color.fromARGB(255, 234, 196, 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.info),
                    title: Text(job.title),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    text: "Status : ",
                                    children: [
                                  const WidgetSpan(
                                      child: SizedBox(
                                    width: 10,
                                  )),
                                  TextSpan(
                                      text: jobStatus.value,
                                      style: TextStyle(
                                          color: jobStatus == JobStatus.active
                                              ? Colors.green
                                              : Colors.red))
                                ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    text: "Tasks : ",
                                    children: [
                                  WidgetSpan(
                                      child: SizedBox(
                                    width: 10,
                                  )),
                                  TextSpan(
                                      text: "4/5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal))
                                ])),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 226, 181, 31),
                              shape: const CircleBorder()),
                          onPressed: toggleJob,
                          icon: Icon(jobStatus.value == "Active"
                              ? Icons.pause
                              : Icons.play_circle)),
                      IconButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: const CircleBorder()),
                          onPressed: () {},
                          icon: const Icon(Icons.cancel)),
                      IconButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: const CircleBorder()),
                          onPressed: () {},
                          icon: const Icon(Icons.check)),
                    ],
                  )
                ],
              ));
        }
      },
    );
  }
}
