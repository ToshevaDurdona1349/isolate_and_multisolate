import 'dart:async';

import 'package:flutter/material.dart';
// aysolad bunda bir vaqtining o'zida bir nechta joyda
// malumotlarni chaqirish mumkin
class BroadcastStreamPage extends StatefulWidget {
  const BroadcastStreamPage({super.key});

  @override
  State<BroadcastStreamPage> createState() => _BroadcastStreamPageState();
}

class _BroadcastStreamPageState extends State<BroadcastStreamPage> {
  final StreamController<String> broadcastController = StreamController.broadcast();
  String firstStream = "No data";
  String secondStream = "No data";

  @override
  void initState() {
    super.initState();
    addStreamData();
  }

  addStreamData() async{
    // Adding a listener to the stream
    broadcastController.stream.listen((data) {
      setState(() {
        firstStream = data;
      });
    });

    broadcastController.stream.listen((data) {
      setState(() {
        secondStream = data;
      });
    });

    /// Add events to the StreamController with a 1-second delay.
    await addDelayedData('Hello');
    await addDelayedData('World');
    await addDelayedData('How');
    await addDelayedData('Are');
    await addDelayedData('You!!');
  }

  Future<void> addDelayedData(String data) async{
    await Future.delayed(const Duration(seconds: 1));
    broadcastController.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Broadcast Stream Page"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              firstStream,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              secondStream,
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}