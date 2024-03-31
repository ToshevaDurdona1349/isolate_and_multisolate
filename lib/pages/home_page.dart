import 'dart:isolate';

import 'package:flutter/material.dart';
// iysoled murakkab tasklarni ham tez bajarib beradi
// multiseled
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.blue,
    title: Text("Isolate"),
  ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/gifs/ball.gif"),
            MaterialButton(
                color: Colors.blue,
                onPressed: () async{
                  var total = await  complexTask1();
                  print("Result 1:$total");
                },
                child:Text("Task 1"),

            ),
            SizedBox(height: 10,),

            MaterialButton(
                color: Colors.blue,
                onPressed: ()async{
                  final reseivePort =ReceivePort();
                  await Isolate.spawn(complexTask2,reseivePort.sendPort);
                  reseivePort.listen((total){
                    print("Result 2: $total");
                  });
                },
                child:Text("Task 2"),
            ),
          ],
        ),
      ),
    );

  }
  Future<double> complexTask1()async{
    var total =0.0;
    for(var i=0;i<1000000000; i++){
      total+=i;
    }
    return  total;
  }
}
// tuaydan tashqarida bo'lishi kerak
complexTask2 (SendPort sendPort){
  var total =0.0;
  for(var i=0;i<1000000000; i++){
    total+=i;
  }
  sendPort.send(total);
}
