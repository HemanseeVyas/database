import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized(); // s=8 run time a error avse ane output can't desplayes while s=8 in follow
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory(); //s=3 2-direcrty in use
  Hive.init(appDocumentsDir.path);//s=2 () ma error ave tyre s=3 in use
  var box=await Hive.openBox('cdmi'); // s=4
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: simple(),));
}
class simple extends StatefulWidget {
  const simple({super.key});

  @override
  State<simple> createState() => _simpleState();
}

class _simpleState extends State<simple> {
  int a=0; //s=1
  Box box=Hive.box('cdmi'); // s=5

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a=box.get('cdmi') ?? 0; // s=6
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hiwe"),),
      body:Column(children: [
        Center(
          child: Text("A = ${a}",style: TextStyle(fontSize: 30),),
        ),
        SizedBox(width: 20,),
        ElevatedButton(onPressed: () {
          a++; //s=2
          //s=3 hive in fluuter -> quick start -> hive.init()=runaap ni uper then
          // path provider in fluuert package install
          box.put('cdmi', a); // s=7
          setState(() {
          });
        }, child: Text("Next"))
      ],)
    );
  }
}
