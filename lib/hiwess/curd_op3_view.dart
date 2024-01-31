import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'curd_op.dart';
import 'curd_op2.dart';

class viewss extends StatefulWidget {

  @override
  State<viewss> createState() => _viewssState();
}

class _viewssState extends State<viewss> {
  Box box=Hive.box('cdmi');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("view data"),),
      body: ListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) {
          datas c=box.getAt(index);
          print(c);
        return Card(
          child: ListTile(title: Text("${c.name}"),
            subtitle: Text("${c.contact}"),
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {
                box.deleteAt(index);
                setState(() {

                });
                }, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return multi(c);
                    },));
                }, icon: Icon(Icons.edit))
              ],
            ),
          ),
        );
      },),
    );
  }
}
