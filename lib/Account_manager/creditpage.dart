import 'package:database/Account_manager/set_pass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class credits extends StatefulWidget {
  Map l2;
  credits(this.l2);

  @override
  State<credits> createState() => _creditsState();
}

class _creditsState extends State<credits> {
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
  TextEditingController t5=TextEditingController();

  List l2=[];
  String gender="";
  bool gen_col=false;


  //intl: date in package

  // DateTime now = DateTime.now();
  String formatter = DateFormat.yMMMMd('en_US').format( DateTime.now());
  String format1 = DateFormat.yMd().format(DateTime.now());
  // String formate1 = DateFormat.yMd('es').format( DateTime.now());




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    add_dataa();
  }
  add_dataa()
  async {
    String sql="select * from vyas where hv=${widget.l2['id']}";
    l2= await aps.database!.rawQuery(sql);

    aps.sum1=0;
    aps.sum2=0;

    for(int i=0;i<l2.length;i++) {
      // print(l[i]);
      // print("${l[i]['credit']}");
      aps.sum1 += int.parse(l2[i]['credit']);
      aps.sum2 += int.parse(l2[i]['debit']);

      // return aps.sum1;
    }
    // aps.sum[widget.l2['id']]=aps.sum1;
    // print(aps.sum[widget.l2['id']]);
    // print(account.sum_c);
    aps.bal=aps.sum1-aps.sum2;
    // gen_col==int.parse(aps.sum1 as String);

    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.l2['name']}"),
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  color: Colors.deepPurple,
                    child: Text("Add Transaction",style: TextStyle(color: Colors.white),)),
                actions: [
                  Column(children: [
                  TextFormField(
                    controller: t3,
                      // child: Text("Transaction Date",style: TextStyle(fontSize: 10),)
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: 'Transaction Date',labelStyle: TextStyle(color: Colors.grey.shade600),
                      hintText: 'name',
                    ),
                    onTap: () async {

                      DateTime? date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate:DateTime.now(),
                          firstDate:DateTime(1900),
                          lastDate: DateTime(2100));

                      // dateCtl.text = date!.toIso8601String();
                      // dateCtl.text = date!.toString();
                      t3.text = DateFormat.yMMMMd('en_US').format(date!);
                      print(t3.text);
                    },
                  ),
                    // TextField(controller: t3,),
                    StatefulBuilder(builder: (context, setState) {
                      return Row(children: [
                        Text("Transaction type : "),
                        Expanded(
                          child: Radio(value: "Credit", groupValue: gender, onChanged: (value) {
                            gender=value!;
                            setState(() {

                            });
                          },),
                        ),
                        Text("Credit(+)"),
                        Expanded(
                          child: Radio(value: "Debit", groupValue: gender, onChanged: (value) {
                            gender=value!;
                            setState(() {
                            });
                          },),
                        ),
                        Text("Debit(-)"),
                      ],);
                    },),
                    TextField(controller: t4,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "Amount",
                      ),
                    ),
                    TextField(controller: t5,
                      decoration: InputDecoration(
                        labelText: "Particular",
                        hintText: "Particular",
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(children: [
                      Expanded(child: InkWell(onTap: () {
                        Navigator.pop(context);
                      },
                        child: Container(
                          height: 40,
                          width: 60,
                          // color: Colors.deepPurple,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple),borderRadius: BorderRadius.circular(20)),
                          child: Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.deepPurple),),
                        ),
                      )),
                      SizedBox(width: 10,),
                      Expanded(child: InkWell(onTap: () {
                        String date=t3.text;
                        String particular=t5.text;
                        String credit,debit;


                        if(gender=="Credit")
                          {
                             credit=t4.text;
                          }else
                          {
                            credit="0";
                          }
                        if(gender=="Debit")
                          {
                            debit=t4.text;
                          }
                        else
                          {
                            debit="0";
                          }



                          // gen_col=t4.text;

                        String sql="insert into vyas values(null,${widget.l2['id']},'$date','$particular','$credit','$debit')";
                        aps.database!.rawInsert(sql);
                        print(sql);
                        Navigator.pop(context);
                        setState(() {

                        });

                      },
                        child: Container(
                          height: 40,
                          width: 60,
                          // color: Colors.deepPurple,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.deepPurple),
                          child: Text("Add",style: TextStyle(fontSize: 20,color: Colors.white),),
                        ),
                      )),
                    ],)
                  ],)
                ],
              );
            },);
          }, icon: Icon(Icons.edit_calendar_sharp)),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.search))
        ],
      ),

      body: Column(children: [
       Container(
         height: 30,
         width: double.infinity,
         color: Colors.black12,
         child:  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             Text("Date",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             Text("Particular",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             Text("Credit(L)",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             Text("Debit(L)",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
           ],),
       ),
        Expanded(
          child: FutureBuilder(future: add_dataa(),builder: (context, snapshot) {
            return ListView.builder(itemCount: l2.length,
              itemBuilder: (context, index) {
                return Card(
                    child:Container(
                      child:  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           Text("${l2[index]['date']}",style: TextStyle(color: (l2[index]['credit']!="0")?Colors.green:Colors.red)),
                            Text("${l2[index]['particular']}",style: TextStyle(color: (l2[index]['credit']!="0")?Colors.green:Colors.red)),
                            Text("${l2[index]['credit']}",style: TextStyle(color: (l2[index]['credit']!="0")?Colors.green:Colors.red)),
                            Text("${l2[index]['debit']}",style: TextStyle(color: (l2[index]['credit']!="0")?Colors.green:Colors.red)),
                          ]),
                      // color: (gen_col==true)?Colors.green:Colors.red,
                    )
                );
              },);
          },)
        ),
        Container(
          height: 100,
          width: double.infinity,
          // color: Colors.grey,
          child: Row(children: [
            Expanded(child: Container(
              alignment: Alignment.center,
              child: Text("Credit\n\nL ${aps.sum1}"),
            )),
            Expanded(child: Container(
              alignment: Alignment.center,
              child: Text("Debit\n\nL ${aps.sum2}"),
            )),
            Expanded(child: Container(
              alignment: Alignment.center,
              child: Text("Balance\n\nL ${aps.bal}",style: TextStyle(color: Colors.white),),
              color: Colors.deepPurple,
            )),
          ]),
        )
      ],)
    );
  }
}
