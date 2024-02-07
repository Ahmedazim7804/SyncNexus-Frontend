import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:worker_app/bloc/cubit/job_cubit.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/ui/screens/employer_screen/jobs_list_screen.dart';
import 'package:worker_app/ui/widgets/workers/task_widget_employee.dart';
import 'package:worker_app/ui/widgets/workers/task_widget_employer.dart';

class EmployeeTaskListScreen extends StatefulWidget {
  const EmployeeTaskListScreen({super.key});

  @override
  State<EmployeeTaskListScreen> createState() => _EmployeeTaskListScreenState();
}

class _EmployeeTaskListScreenState extends State<EmployeeTaskListScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? initialLocation;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late final Job job = context.read<JobCubit>().job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          title: const Text(
            "Tasks",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 5,
            backgroundColor: const Color.fromARGB(255, 226, 181, 31),
            onPressed: () {},
            child: const Icon(Icons.add)),
        backgroundColor: const Color.fromARGB(255, 234, 196, 72),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 2.5,
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialLocation ?? _kGooglePlex,
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: job.tasks.length,
              itemBuilder: (context, index) =>
                  TaskWidgetEmployer(task: job.tasks[index]),
            ),
          ],
        ));
  }
}
