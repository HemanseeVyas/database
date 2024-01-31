import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'creditpage.dart';

class aps extends StatefulWidget {
  const aps({super.key});
  static Database?database;
  static int sum1=0;
  static int sum2=0;
  static int sum=0;
  static int bal=0;


  @override
  State<aps> createState() => _apsState();
}

class _apsState extends State<aps> {
  TextEditingController t1=TextEditingController();
  List l2=[];
  List l1=[];
  List di=[];
  List d=[];
  bool h=false;



  List sum=[];
  List c=[];
  List total=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()
  async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo2.db');


// open the database
    aps.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE accounts (id INTEGER PRIMARY KEY, name TEXT)');
          await db.execute(
              'CREATE TABLE vyas (id INTEGER PRIMARY KEY, hv INTEGER,date TEXT, particular TEXT, credit TEXT, debit TEXT)');
        });

    String sql="select * from accounts";
    l2= await aps.database!.rawQuery(sql);
    sum=List.filled(l2.length, 0);
    di=List.filled(l2.length, 0);
    total=List.filled(l2.length, 0);
    for(int i=0; i<=l2.length; i++)
      {

           String credit="select SUM(credit) from vyas where hv=${l2[i]['id']}";
           c= await aps.database!.rawQuery(credit);
           print(c);
           sum[i]=c[0]['SUM(credit)'];
           String dabit="select SUM(debit) from vyas where hv=${l2[i]['id']}";
           d= await aps.database!.rawQuery(dabit);
           di[i]=d[0]['SUM(debit)'];
           total[i]=c[0]['SUM(credit)']-d[0]['SUM(debit)'];
           print("sum=$sum");
      }
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: () {
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
          }, icon: Icon(Icons.settings))
        ],
      ),
      body: FutureBuilder(future: get(),
        builder: (context, snapshot) {
        return Column(children: [
          Expanded(flex: 8,child:
          Container(
            alignment: Alignment.center,
            // height: 50,
            // width: 50,
            color: Colors.white,
            child:
            // (h)?
            ListView.builder(itemCount: l2.length,
              itemBuilder: (context, index) {
              return InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return credits(l2[index]);
                },));
              },
                child: Card(
                  child: ListTile(
                    title: Column(children: [
                      Row(children: [
                        Text("${l2[index]['name']}"),
                        SizedBox(width: 180,),
                        Expanded(
                          child: IconButton(onPressed: () {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("Update Account"),
                                actions: [
                                  Column(children: [
                                    TextField(controller: t1,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                            });
                                          },
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 10),
                                              height: 50,
                                              width: 100,
                                              color: Colors.teal,
                                              child: Text("cancel"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: InkWell(onTap: () {
                                            Navigator.pop(context);
                                            String name=t1.text;

                                            String sql="update accounts set name='$name' where id=${l2[index]['id']}";
                                            aps.database!.rawUpdate(sql);
                                            print(sql);

                                            setState(() {
                                            });
                                          },
                                            child: Container(

                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 10),
                                              height: 50,
                                              width: 100,
                                              color: Colors.teal,
                                              child: Text("Update"),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],)
                                ],
                              );
                            },);
                          }, icon: Icon(Icons.edit_note_sharp)),
                        ),
                        Expanded(
                          child: IconButton(onPressed: () {
                              String sql="delete from accounts where id=${l2[index]['id']}";
                              aps.database!.rawDelete(sql);

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return aps();
                              },));
                          }, icon: Icon(Icons.delete_forever_outlined)),
                        ),
                      ],),
                      SizedBox(height: 10,),
                      Row(children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            width: 160,
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: Text("Credit\n\n L(${(sum[index]!=null)?sum[index]:0})"),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 60,
                            width: 160,
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: Text("Debit\n\n L(${(di[index]!=null)?di[index]:0})"),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 60,
                            width: 300,
                            color: Colors.deepPurple,
                            alignment: Alignment.center,
                            child: Text("Balance\n\n L${(total[index]!=null)?total[index]:0}"),
                          ),
                        )
                      ]),
                    ],)
                  ),
                ),
              );
            },)
                // :Text("Add Your Account Name"),
          ),
          ),
          Expanded(child:
          InkWell(onTap: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Add New Account"),
                actions: [
                  Column(children: [
                    TextField(controller: t1,),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(onTap: () {
                            Navigator.pop(context);
                            setState(() {
                            });
                          },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              width: 100,
                              color: Colors.teal,
                              child: Text("cancel"),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: InkWell(onTap: () {
                           Navigator.pop(context);
                            String name=t1.text;

                            String sql="insert into accounts values(null,'$name')";
                            aps.database!.rawInsert(sql);
                            // h=true;


                            print(sql);
                            setState(() {
                            });
                          },
                            child: Container(

                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              width: 100,
                              color: Colors.teal,
                              child: Text("save"),
                            ),
                          ),
                        )
                      ],
                    )
                  ],)
                ],
              );
            },);
          },
            child: Container(
              margin: EdgeInsets.fromLTRB(280, 10, 10, 10),
              alignment: Alignment.center,
              height: 50,
              width: 50,
              color: Colors.deepOrange,
              child: Text("[+]",style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),),
        ],);
      },)
    );
  }
}
