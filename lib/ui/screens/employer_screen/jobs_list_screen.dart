import 'package:flutter/material.dart';
import 'package:worker_app/ui/widgets/workers/add_job.dart';
import 'package:worker_app/ui/widgets/workers/heading_text_widget.dart';

class JobsListScreen extends StatefulWidget {
  const JobsListScreen({super.key});

  @override
  State<JobsListScreen> createState() => _JobsListScreenState();
}

class _JobsListScreenState extends State<JobsListScreen> {
  void showAddJobSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddJobWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 226, 181, 31),
        //   title: const Text(
        //     "Jobs",
        //     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        // ),
        floatingActionButton: FloatingActionButton.extended(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          onPressed: showAddJobSheet,
          label: const Text("Add Job"),
          icon: const Icon(Icons.add),
        ),
        // backgroundColor: Colors.grey.shade50,
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [JobItem()],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Image.asset(
              'assets/images/jobs4.png',
              height: 100,
            ),
          ),
          InkWell(
            onTap: toggleTaskItem,
            child: Card(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
              color: const Color.fromARGB(255, 226, 181, 31),
              surfaceTintColor: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
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
                              text: "Assigned To : ",
                              children: [
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                TextSpan(
                                    text: "Ramesh",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ])),
                    ]),

                    // Row(children: [
                    //   const Icon(Icons.lock_clock),
                    //   const SizedBox(
                    //     width: 10,
                    //   ),
                    //   RichText(
                    //       textAlign: TextAlign.left,
                    //       text: const TextSpan(
                    //           style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w500),
                    //           text: "Tasks : ",
                    //           children: [
                    //             WidgetSpan(
                    //                 child: SizedBox(
                    //               width: 10,
                    //             )),
                    //             TextSpan(
                    //                 text: "4/5",
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.normal)),
                    //           ])),
                    // ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      const Icon(Icons.check_circle),
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
                              text: "Status : ",
                              children: [
                                const WidgetSpan(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                WidgetSpan(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        color:
                                            Color.fromARGB(255, 234, 196, 72)),
                                    child: const Text(
                                      "Active",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 67, 25),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color.fromARGB(255, 234, 196, 72)),
                            child: const Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 5),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {},
                            label: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            )),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {},
                            label: const Text(
                              "Complete",
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: const Icon(
                              Icons.check,
                              color: Colors.black,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
