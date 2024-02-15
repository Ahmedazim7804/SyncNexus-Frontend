import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worker_app/bloc/cubit/job_cubit.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskWidgetEmployer extends StatelessWidget {
  const TaskWidgetEmployer({super.key, required this.task});

  final WorkerTask task;

  void removeTask() {}

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: Colors.grey.shade200,
        surfaceTintColor: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.black,
            ),
            title: Text(
              task.task,
              style: GoogleFonts.urbanist(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: RichText(
              text: TextSpan(
                  text: "Deadline: ",
                  style: GoogleFonts.urbanist(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: const [
                    TextSpan(
                      text: "23 Jan, 1PM",
                    )
                  ]),
            ),
            trailing: IconButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, shape: const CircleBorder()),
                onPressed: () {},
                icon: const Icon(Icons.remove)),
          )
        ]));
  }
}
