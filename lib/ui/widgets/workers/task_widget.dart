import 'package:flutter/material.dart';
import 'package:worker_app/bloc/cubit/job_cubit.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});

  final WorkerTask task;

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      context.read<JobCubit>().finishedATask(task);
    }

    final bool jobActive = context.read<JobCubit>().isJobActive;

    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        color: const Color.fromARGB(255, 234, 196, 72),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(task.task),
            subtitle: RichText(
              text: const TextSpan(
                  text: "Deadline: ",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "23 Jan, 1PM",
                    )
                  ]),
            ),
            trailing: IconButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: jobActive ? Colors.green : Colors.grey,
                    shape: const CircleBorder()),
                onPressed: onPressed,
                icon: const Icon(Icons.check)),
          )
        ]));
  }
}
