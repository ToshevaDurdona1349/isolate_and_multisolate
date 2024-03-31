import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({super.key});

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  final StreamController<String> singleController=StreamController();

  @override
  void initState(){
    super.initState();
    addStreamDaata();
  }

  addStreamDaata()async {
    await addDelayedData("Hello");
    await addDelayedData("World");
    await addDelayedData("How");
    await addDelayedData("Are");
    await addDelayedData("You!");
  }
  Future<void> addDelayedData (String data)async{
    await Future.delayed(const Duration (seconds: 1));
    singleController.add(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Singil Builder Page"),
        ),
        body: StreamBuilder<String>(
          stream: singleController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Center(
                child: Text(
                  snapshot.data!,
                  textScaleFactor: 2,
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "No data",
                  textScaleFactor: 2,
                ),
              );
            }
          },
        )
    );
  }
}
