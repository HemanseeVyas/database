import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'curd_op2.dart';
import 'curd_op3_view.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  Hive.registerAdapter(datasAdapter());
  var box=await Hive.openBox('cdmi');
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: multi(),));
}
class multi extends StatefulWidget {
  datas ?c;
  multi([this.c]);

  @override
  State<multi> createState() => _multiState();
}

class _multiState extends State<multi> {
  //s=1
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();

  Box box = Hive.box("cdmi");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.c!=null)
      {
        t1.text=widget.c!.name;
        t2.text=widget.c!.contact;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (widget.c!=null)?Text("Update data") : Text("View data"),),
      body: Column(children: [
        TextField(
          controller: t1,//s=1
        ),
        TextField(
          controller: t2,//s=1
        ),
        SizedBox(width: 20,),
        ElevatedButton(onPressed: () {
            String name = t1.text;
            String contact = t2.text;

            // print(d);
            if(widget.c!=null)
              {
                widget.c!.name=name;
                widget.c!.contact=contact;
                widget.c!.save();
              }else
              {
                datas d = datas(name, contact);
                box.add(d);
              }
            t1.text="";
            t2.text="";
        }, child: Text("Add")),
        SizedBox(width: 20,),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return viewss();
          },));
        }, child: Text("View")),
      ]),
    );
  }
}
