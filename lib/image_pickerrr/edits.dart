import 'dart:io';
import 'dart:math';

import 'package:database/image_pickerrr/Add.dart';
import 'package:database/image_pickerrr/views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class edit_data extends StatefulWidget {
  Map l1;
  edit_data(this.l1);

  @override
  State<edit_data> createState() => _edit_dataState();
}

class _edit_dataState extends State<edit_data> {
  final ImagePicker picker = ImagePicker(); // object in img_picker
  XFile? image; // image object

  Widget text(String str,TextEditingController t){
    return TextField(
      controller: t,
      decoration: InputDecoration(hintText: str,border: OutlineInputBorder()),
    );
  }
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  String gender="";
  String city="Surat";
  bool t=false;
  String img_name="";
  String new_img="";
  File ?file;
  // List<Map>l1=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.l1!=null)
     {
        t1.text=widget.l1['name'];
        t2.text=widget.l1['contact'];
        t3.text=widget.l1['email'];
        t4.text=widget.l1['password'];
        gender=widget.l1['gender'];
        city=widget.l1['city'];
        new_img=widget.l1['image'];

        String new_path="${pick.dir!.path}/${widget.l1['image']}";
        file=File(new_path);
        setState(() {

        });
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Edit_Data"),),
      body:  Column(children: [
        text("Name", t1),
        text("Contact", t2),
        text("Email", t3),
        text("Password", t4),
        SizedBox(width: 10,),
        Row(
          children: [
            Radio(value: "Male", groupValue: gender, onChanged: (value) {
              gender=value!;
              setState(() {
              });
            },),
            Text("Male"),
            Radio(value: "Female", groupValue: gender, onChanged: (value) {
              gender=value!;
              setState(() {
              });
            },),
            Text("Female"),
          ],
        ),
        SizedBox(width: 10,),
        DropdownButton(value: city,items: [
          DropdownMenuItem(child: Text("Surat"),value: "Surat",),
          DropdownMenuItem(child: Text("Ahemdabad"),value: "Ahemdabad",),
          DropdownMenuItem(child: Text("Amroli"),value: "Amroli",),
          DropdownMenuItem(child: Text("Dubai"),value: "Dubai",),
          DropdownMenuItem(child: Text("Rajkot"),value: "Rajkot",),
        ],
          onChanged: (value) {
            city=value!.toString();
            setState(() {
            });
          },),
        SizedBox(width: 10,),
        Row(children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.teal,
            alignment: Alignment.center,
            child: (t)?Image.file(File(image!.path)):(file!=null)?Image.file(file!):null,
          ),
          SizedBox(width: 10,),
          ElevatedButton(onPressed: () {
            showDialog(context:context, builder: (context) {
              return AlertDialog(
                title: Text("Chosse the image"),
                actions: [
                  Row(children: [
                    TextButton(onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.camera);
                      t=true;
                      Navigator.pop(context);
                      setState(() {

                      });
                    }, child: Text("Cemera")),
                    TextButton(onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      t=true;
                      Navigator.pop(context);
                      setState(() {

                      });
                    }, child: Text("Gallary")),
                  ],)
                ],
              );
            },);
          }, child: Text("Choose"))
        ],),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async {
          String name=t1.text;
          String contact=t2.text;
          String email=t3.text;
          String password=t4.text;

          if(image!=null)
          {
            File file1=File("${pick.dir!.path}/${new_img}");
            file1.delete();
            new_img="${Random().nextInt(100)}.png";
            File f=File("${pick.dir!.path}/${new_img}");
            f.writeAsBytes( await image!.readAsBytes());
          }

          String sql="update students set name='$name', contact='$contact', email='$email',"
          "password='$password',gender='$gender',city='$city',image='$new_img' where id='${widget.l1['id']}'";
            pick.database!.rawUpdate(sql);
          setState(() {
          });
        }, child: Text("Add")),
        ElevatedButton(onPressed: () {
          // t1.text="";
          // t2.text="";
          // t3.text="";
          // t4.text="";
          // gender="";
          // city="Surat";
          // img_name="";
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return viewdata();
          },));
          setState(() {
          });
        }, child: Text("View"))
      ]),
    );
  }
}


