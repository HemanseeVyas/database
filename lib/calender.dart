import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main()
{
  runApp(MaterialApp(home: mn(),));
}
class mn extends StatefulWidget {
  const mn({super.key});

  @override
  State<mn> createState() => _mnState();
}

class _mnState extends State<mn> {
  TextEditingController t5=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          controller: t5,
          onTap: () {
            DateTime ? date=DateTime(1900);
            showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019, 1),
                lastDate: DateTime(2021,12),
                builder: (context,picker){
                  return Theme(
                    //TODO: change colors
                    data: ThemeData.dark().copyWith(
                      colorScheme: ColorScheme.dark(
                        primary: Colors.deepPurple,
                        onPrimary: Colors.white,
                        surface: Colors.pink,
                        onSurface: Colors.yellow,
                      ),
                      dialogBackgroundColor:Colors.green[900],
                    ),
                    child: picker!,);
                })
                .then((selectedDate) {
              //TODO: handle selected date
              if(selectedDate!=null){
                t5.text = selectedDate.toString();
              }
            });
          },
        )
      ]),
    );
  }
}
