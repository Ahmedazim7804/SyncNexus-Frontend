import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:worker_app/bloc/cubit/employee/data_cubit.dart';
import 'package:worker_app/bloc/cubit/employee/location_cubit.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/models/employer_model.dart';

import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/models/lat_long_model.dart';

import 'package:worker_app/ui/screens/employee_screen/widgets/workers/heading_text_widget.dart';
import 'package:worker_app/ui/screens/employee_screen/widgets/workers/job_card.dart';

import 'package:worker_app/ui/screens/employee_screen/widgets/workers/task_widget_employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker_app/ui/screens/employee_screen/widgets/workers/task_widget_employer.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition? initialLocation;
  final CameraPosition defaultMapLocation = const CameraPosition(
    target: LatLng(15.5937, 80.9629),
    zoom: 4,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setPositionOnMap({required double lat, required double long}) {
    _controller.future.then((value) => value.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, long), zoom: 14.4746))));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white.withAlpha(40),
      //   leading: IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.menu,
      //       )),
      //   title: const Text("Dashboard"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.history))
      //   ],
      // ),
      extendBodyBehindAppBar: true,
      bottomSheet: MyBottomSheet(),
      body: Center(
        child: Column(
          children: [
            // SizedBox(
            //   height: MediaQuery.sizeOf(context).height / 2.5,
            //   width: MediaQuery.sizeOf(context).width,
            //   child: BlocListener<EmployeeLocationCubit, EmployeeLocationState>(
            //       listener: (context, state) {
            //         if (state is LocationAvailable) {
            //           LatLong latLong =
            //               context.read<EmployeeLocationCubit>().position;
            //           setPositionOnMap(lat: latLong.lat, long: latLong.long);
            //         }
            //       },
            //       child: GoogleMap(
            //         onCameraMove: (position) {
            //           position.zoom;
            //         },
            //         mapType: MapType.normal,
            //         buildingsEnabled: true,
            //         myLocationEnabled: true,
            //         myLocationButtonEnabled: true,
            //         trafficEnabled: true,
            //         initialCameraPosition:
            //             initialLocation ?? defaultMapLocation,
            //         onMapCreated: (controller) {
            //           _controller.complete(controller);
            //         },
            //       )),
            // )
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 500,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: BlocBuilder<EmployeeDataCubit, EmployeeDataState>(
            builder: (context, state) {
              if (state is EmployeeDataLoaded) {
                Employee employee = context.read<EmployeeDataCubit>().employee;
                Employer employer = context.read<EmployeeDataCubit>().employer;

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
                        title: Text(employer.name),
                        subtitle: Text(employer.phone),
                      ),
                      const HeadingText(text: 'Job'),
                      const HeadingText(text: 'Tasks'),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: employee.tasks.length,
                          itemBuilder: (context, index) {
                            String task = employee.tasks[index].task;
                            String deadline = employee.tasks[index].deadline;

                            return TaskWidgetEmployer(
                                task:
                                    WorkerTask(task: task, deadline: deadline));
                          })
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}
