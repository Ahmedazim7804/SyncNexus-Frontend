import 'package:flutter/material.dart';
import 'package:worker_app/ui/widgets/workers/heading_text_widget.dart';

class JobsListScreen extends StatefulWidget {
  const JobsListScreen({super.key});

  @override
  State<JobsListScreen> createState() => _JobsListScreenState();
}

class _JobsListScreenState extends State<JobsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 181, 31),
          title: const Text(
            "Jobs",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 234, 196, 72),
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

  ShapeBorder cardShape = const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
      setState(() {
        cardShape = const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)));
      });

      controller.reverse();
    } else {
      controller.forward();

      setState(() {
        cardShape = const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)));
      });
    }
    isExpanded = !isExpanded;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () => toggleTaskItem(),
            child: Card(
              shape: cardShape,
              margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
              color: const Color.fromARGB(255, 226, 181, 31),
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
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Fix The Roof",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      const Icon(Icons.punch_clock),
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
                              text: "Deadline : ",
                              children: [
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                TextSpan(
                                    text: "19/02/2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ])),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      const Icon(Icons.lock_clock),
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
                              text: "Tasks : ",
                              children: [
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                TextSpan(
                                    text: "4/5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                              ])),
                    ]),
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
                          text: const TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              text: "Status : ",
                              children: [
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 10,
                                )),
                                TextSpan(
                                    text: "Active",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal))
                              ])),
                      const Spacer(),
                      IconButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: const CircleBorder()),
                          onPressed: () {},
                          icon: const Icon(Icons.remove)),
                      IconButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: const CircleBorder()),
                          onPressed: () {},
                          icon: const Icon(Icons.check)),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          SizeTransition(
              sizeFactor: heightFactorAnimation, child: const TaskItem()),
          SizeTransition(
              sizeFactor: heightFactorAnimation,
              child: const TaskItem(
                last: true,
              )),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, this.last = false});

  final bool last;

  @override
  Widget build(BuildContext context) {
    late final ShapeBorder cardShape;

    if (last) {
      cardShape = const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ));
    } else {
      cardShape = const ContinuousRectangleBorder();
    }

    return Card(
        margin: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4),
        shape: cardShape,
        color: const Color.fromARGB(255, 226, 181, 31),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            dense: true,
            leading: const Icon(Icons.info),
            title: const Text("Pick up the material"),
            subtitle: RichText(
              text: const TextSpan(
                  text: "Deadline: ",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  children: [
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
