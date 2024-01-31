import 'dart:io';
import 'dart:math';

import 'package:database/image_pickerrr/Add.dart';
import 'package:database/image_pickerrr/edits.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class viewdata extends StatefulWidget {
  const viewdata({super.key});

  @override
  State<viewdata> createState() => _viewdataState();
}

class _viewdataState extends State<viewdata> {
  List <Map>l1=[];
  bool s=false;
  List name=[];
  List t_name=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }
  get_data()
  async {
    String sql="select * from students";
    pick.database!.rawQuery(sql).then((value) {
      l1=value;

      for(int i=0; i<l1.length;i++)
      {
        name.add(l1[i]['name']);
      }
      t_name=name;
      // print(l1);
      setState(() {
      });
    });
    // l1=await pick.database!.rawQuery(sql);

    //   for(int i=0; i<l1.length;i++)
    //     {
    //       name.add(l1[i]['name']);
    //     }
    //   t_name=name;
    //   // print(l1);
    // setState(() {
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (s)?TextField(
          onChanged: (value) {
            name=t_name.where((element) => element.toString().startsWith(value)).toList();
            setState(() {
            });
          },
          autofocus: true,
          cursorColor: Colors.white,
        ):Text("View data"),
        actions: [
          IconButton(onPressed: () {
            s=!s;
            setState(() {
            });
          }, icon:(s)?Icon(Icons.close): Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
        // search condition in before
        // itemCount: l1.length,
        //search condition in after
        itemCount: name.length,
        itemBuilder: (context, index) {
          int originalindex=t_name.indexOf(name[index]);
          print(originalindex);
          print(t_name[index]);
          print(name[index]);

          //view page ma image show krvva mte dir in file create -> leading in use
          String img_path="${pick.dir!.path}/${l1[index]['image']}";
          File f=File(img_path);
        return Card(
          child: ListTile(
            title: Text("${l1[originalindex]['name']}"),
            subtitle: Text("${l1[originalindex]['contact']}"),
            leading: Container(
              child: Image(image: FileImage(File(f.path)),),
            ),
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {
                  String sql="delete from students where id=${l1[originalindex]['id']}";
                  pick.database!.rawDelete(sql);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return viewdata();

                  },));
                }, icon: Icon(Icons.delete_rounded)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return edit_data(l1[index]);
                  },));
                }, icon: Icon(Icons.edit)),
              ],
            ),
          ),
        );
      },)
    );
  }
}

