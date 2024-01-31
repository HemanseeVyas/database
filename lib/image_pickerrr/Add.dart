import 'dart:io';
import 'dart:math';

import 'package:database/image_pickerrr/views.dart';
import 'package:email_validator/email_validator.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: pick(),));
}
class pick extends StatefulWidget {
  const pick({super.key});
  // static - bija page ma ae j database ane dir file use krva mate
  // alg alg page ma repeat bnvvi pade nahi
  static Database?database;
  static Directory ?dir;

  @override
  State<pick> createState() => _pickState();
}

class _pickState extends State<pick> {
  // image picker in flutter search
    final ImagePicker picker = ImagePicker(); // object in img_picker
   XFile? image; // image object

  //textfield ghni bdhi levi no pde aetle & coading bdha ma no krvu pde 1 function in use
  // Widget text(String str,TextEditingController t){
  //   return TextField(
  //     controller: t,
  //     decoration: InputDecoration(hintText: str,border: OutlineInputBorder()),
  //   );
  // }
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();

  bool error_name=false;
  bool error_contact=false;
  bool error_email=false;
  bool error_pass=false;

  String gender="";
  // int h=1;
  String city="Surat";
  bool t=false;
  String img_name="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    data();
  }
  get()
  async {
    //1 ui create
    //2 image picker valu
    //3 image lavva mate - 1> permission handler ,2> external path , 3>directory create
    //external path ma storage vali file mukvi ->app-src-main-androidmainfes1->application ni uper
    // and then curd operation
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);

    }

    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/hemanshi";

    pick. dir=Directory(path);
    if(!await pick.dir!.exists())
    {
     pick. dir!.create();
    }

  }
  data()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');


// open the database
    pick. database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, contact TEXT, email TEXT,password TEXT,gender TEXT,city TEXT,image TEXT)');
        });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Image_Picker"),),
      body: Column(children: [
        TextField(controller: t1, decoration: InputDecoration(errorText: (error_name)?'Enter Name':null,
            hintText: "Name",border: OutlineInputBorder()),),
        TextField(controller: t2, decoration: InputDecoration(errorText: (error_contact)?'Enter Valid number':null,
            hintText: "Contact",border: OutlineInputBorder()),),
        TextField(controller: t3, decoration: InputDecoration(errorText: (error_email)?'Enter valid email':null,
            hintText: "Email",border: OutlineInputBorder()),),
        TextField(controller: t4, decoration: InputDecoration(errorText: (error_pass)?'Enter valid password':null,
            hintText: "Password",border: OutlineInputBorder()),),
       // text("Name", t1),
       // text("Contact", t2),
       // text("Email", t3),
       // text("Password", t4),
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
            child: (t)?(image!=null)?Image.file(File(image!.path)):null:null,
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
        ElevatedButton(onPressed: ()  async {
            String name=t1.text;
            String contact=t2.text;
            String email=t3.text;
            String password=t4.text;

            // contact mate
            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp regExp = new RegExp(patttern);

            if(name=="")
              {
                error_name=true;
              }
            else
              {
                error_name=false;
              }
            //contact validation in flutter
            if(contact=="" || !regExp.hasMatch(contact))
              {
                error_contact=true;
              }
            else
              {
                    error_contact=false;
              }
            // trim=space muki hoi e consider no kre ane error jenrate no kare space na lidhe
            // error validation in flutter
            if(email.trim()=="" || !EmailValidator.validate(email.trim()))
              {
                error_email=true;
              }
            else
              {
                    error_email=false;
              }
            if(password=="")
              {
                  error_pass=true;
              }
            else
              {
                    error_pass=false;
              }
            setState(() {

            });

            if(!error_name && !error_contact && !error_email && !error_pass)
              {
                int r=Random().nextInt(100);
                img_name="${r}.png";
                File f=File("${pick.dir!.path}/${img_name}");
                f.writeAsBytes( await image!.readAsBytes()); // folder ma image store karva mate

                String sql="insert into students values(null,'$name','$contact','$email','$password','$gender','$city','$img_name')";
                pick.database!.rawInsert(sql);
                print(sql);

                setState(() {
                });

              }

            // int r=Random().nextInt(100);
            // img_name="${r}.png";
            // File f=File("${pick.dir!.path}/${img_name}");
            // f.writeAsBytes( await image!.readAsBytes()); // folder ma image store karva mate
            //
            //
            // String sql="insert into students values(null,'$name','$contact','$email','$password','$gender','$city','$img_name')";
            // pick.database!.rawInsert(sql);
            // print(sql);
            //
            //   setState(() {
            //   });

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
        }, child: Text("View")),
      ]),
    );
  }
}
