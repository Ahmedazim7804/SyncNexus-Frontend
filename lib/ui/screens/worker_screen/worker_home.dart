import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worker_app/bloc/cubit/job_cubit.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/ui/widgets/workers/heading_text_widget.dart';
import 'package:worker_app/ui/widgets/workers/job_card.dart';
import 'package:worker_app/ui/widgets/workers/task_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? initialLocation;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    Permission.locationWhenInUse.request().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        double lat = position.latitude;
        double long = position.longitude;
        _controller.future.then((value) => value.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(lat, long), zoom: 14.4746))));
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(40),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            )),
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history))
        ],
      ),
      extendBodyBehindAppBar: true,
      bottomSheet: const MyBottomSheet(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialLocation ?? _kGooglePlex,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
              ),
            )
            // Image.asset('assets/images/map.png')

            // First Draft
            // Stack(
            //   children: [
            //     Container(
            //       width: MediaQuery.sizeOf(context).width,
            //       height: 125,
            //       color: const Color.fromARGB(255, 226, 181, 31),
            //     ),
            //     const Positioned(
            //         child: Text(
            //       "Current Employer",
            //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //     ))
            //   ],
            // ),

            // Second Draft
            // Center(
            //   child: Column(
            //     children: [JobCardWidget()],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  void initState() {
    BlocProvider.of<JobCubit>(context).getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: const Color.fromARGB(255, 226, 181, 31),
      builder: (context) {
        return Container(
          height: 500,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: BlocConsumer<JobCubit, JobState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is JobLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                Job job = context.read<JobCubit>().job;
                JobStatus jobStatus = context.read<JobCubit>().jobStatus;
                List<WorkerTask> tasks = job.tasks;

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadingText(text: 'Employer'),
                      ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        leading: CircleAvatar(
                          radius: 35,
                          child: Image.asset('assets/images/default_user.png'),
                        ),
                        title: const Text("Manoj Kumar"),
                        subtitle: const Text("9312582027"),
                      ),
                      const HeadingText(text: 'Job'),
                      JobCardWidget(
                        job: job,
                        jobStatus: jobStatus,
                      ),
                      const HeadingText(text: 'Tasks'),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            String task = tasks[index].task;
                            String deadline = tasks[index].deadline;

                            return TaskWidget(
                                task:
                                    WorkerTask(task: task, deadline: deadline));
                          })
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
