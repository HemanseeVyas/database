// import 'package:flutter/material.dart';
//
// /// Flutter code sample for [FloatingActionButton].
//
// void main() {
//   runApp(const FloatingActionButtonExampleApp());
// }
//
// class FloatingActionButtonExampleApp extends StatelessWidget {
//   const FloatingActionButtonExampleApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: const FloatingActionButtonExample(),
//     );
//   }
// }
//
// class FloatingActionButtonExample extends StatefulWidget {
//   const FloatingActionButtonExample({super.key});
//
//   @override
//   State<FloatingActionButtonExample> createState() =>
//       _FloatingActionButtonExampleState();
// }
//
// class _FloatingActionButtonExampleState
//     extends State<FloatingActionButtonExample> {
//   // The FAB's foregroundColor, backgroundColor, and shape
//   static const List<(Color?, Color? background, ShapeBorder?)> customizations =
//   <(Color?, Color?, ShapeBorder?)>[
//     (null, null, null), // The FAB uses its default for null parameters.
//     (null, Colors.green, null),
//     (Colors.white, Colors.green, null),
//     (Colors.white, Colors.green, CircleBorder()),
//   ];
//   int index = 0; // Selects the customization.
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FloatingActionButton Sample'),
//       ),
//       body: const Center(child: Text('Press the button below!')),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             index = (index + 1) % customizations.length;
//           });
//         },
//         foregroundColor: customizations[index].$1,
//         backgroundColor: customizations[index].$2,
//         shape: customizations[index].$3,
//         child: const Icon(Icons.navigation),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: heyy(),));
}
class heyy extends StatefulWidget {
  const heyy({super.key});
  static Database ? database;

  @override
  State<heyy> createState() => _heyyState();
}

class _heyyState extends State<heyy> {
  TextEditingController t7=TextEditingController();
  TextEditingController t8=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gets();
  }
  gets()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// Delete the database
    await deleteDatabase(path);

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE datatable (id INTEGER PRIMARY KEY, name TEXT, con TEXT)');
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          controller: t7,
        ),
        TextField(
          controller: t8,
        ),
        ElevatedButton(onPressed: () {
          // gets();
          String name=t7.text;
          String con=t8.text;

          String sql="insert into datatable values(null, '$name', '$con')";
          heyy.database!.rawInsert(sql);
          print(sql);
          setState(() {

          });
        }, child: Text("Add"))
      ]),
    );
  }
}
