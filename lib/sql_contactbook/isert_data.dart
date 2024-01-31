// import 'package:database/sql_contactbook/views.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// void main()
// {
//       runApp(MaterialApp(debugShowCheckedModeBanner: false,home: isr(),));
// }
// class isr extends StatefulWidget {
//  static Database? database;
//   const isr({super.key});
//
//   @override
//   State<isr> createState() => _isrState();
// }
//
// class _isrState extends State<isr> {
//   TextEditingController t1=TextEditingController();
//   TextEditingController t2=TextEditingController();
//
//
//  Widget txt_fun(String str ,TextEditingController t)
//   {
//       return TextField(
//         controller: t,
//         decoration: InputDecoration(hintText: str,border: OutlineInputBorder()),
//       );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get_db();
//   }
//
//   get_db()
//   async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'demo.db');
//     isr.database = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//           // When creating the db, create the table
//           await db.execute(
//               'CREATE TABLE contact (id INTEGER PRIMARY KEY, name TEXT, contact TEXT)');
//         });
//     setState(() {
//
//     });
//   }
//   // get_db()
//   // async {
//   //   var databasesPath = await getDatabasesPath();
//   //   String path = join(databasesPath, 'demo.db');
//   //   // open the database
//   //   //version - database update krva mate
//   //   database = await openDatabase(path, version: 1,
//   //       onCreate: (Database db, int version) async {
//   //         // When creating the db, create the table
//   //         await db.execute(
//   //           //db.exucte thi bdha table create thse
//   //           // nim REAL - poin vali value mate real database use thay
//   //           // value ma arithmatic operation use krva hoi to j integer use thay oy=therwise text b use kri skiye
//   //           //   'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'); - copy lin in google
//   //             'CREATE TABLE contact_books (id INTEGER PRIMARY KEY AUTOINCEREMENT, name TEXT, contact TEXT)');
//   //       });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Contact_Book"),),
//       body: Column(children: [
//         txt_fun("Enter Name", t1),
//         txt_fun("Enter Contact", t2),
//         SizedBox(height: 30,),
//         ElevatedButton(onPressed: () {
//           String name=t1.text;
//           String contact=t2.text;
//           // String qry="insert into contact_books values(null,'$name','$contact')";
//           String qry="insert into contact values(null,'$name','$contact')";
//           isr.database!.rawInsert(qry).then((value) {
//             print(value);
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return DEmo();
//             },));
//           });
//           // setState(() {
//           //
//           // });
//         }, child: Text("Submit"))
//       ]),
//     );
//   }
// }
