// import 'package:flutter/material.dart';
// import 'isert_data.dart';
// class DEmo extends StatefulWidget {
//   const DEmo({super.key});
//
//   @override
//   State<DEmo> createState() => _DEmoState();
// }
//
// class _DEmoState extends State<DEmo> {
//   List l=[];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get_data();
//   }
//   get_data()
//   async {
//     String sql="select * from contact";
//  l=await  isr.database!.rawQuery(sql);
//  setState(() {
//
//  });
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
//         return ListTile(title: Text("${l[index]['name']}"),);
//       },),
//     );
//   }
// }
