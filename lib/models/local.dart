import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdatabase/module/archive_screen.dart';
import 'package:localdatabase/module/done_screen.dart';
import 'package:localdatabase/shared/componant/componant.dart';
import 'package:localdatabase/shared/shared/shared.dart';
import 'package:localdatabase/module/task_screen.dart';
import 'package:localdatabase/module/task_screen.dart';
import 'package:localdatabase/cubit/cubit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:localdatabase/cubit/cubit.dart';
import '../cubit/stats.dart';

class local extends StatelessWidget {




  TextEditingController task = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  var scaffold = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>appcubit()..creatDataBase(),
      child: BlocConsumer<appcubit,states>(
      builder: (BuildContext context, state) {return Scaffold(
        key: scaffold,
        appBar: AppBar(
          title: appcubit.get(context).app[appcubit.get(context).toselected],
        ),
        body: appcubit.get(context).Screens[appcubit.get(context).toselected],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex:appcubit.get(context).toselected ,
          onTap: (value)
          {

            appcubit.get(context).changebootom(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline), label: "done"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "archive"),
          ],
        ),



        floatingActionButton: FloatingActionButton(
          child: Icon( appcubit.get(context).icon),
          onPressed: () {
            if (appcubit.get(context).bottomsheet) { //                                          //if it is open
              if (formkey.currentState!.validate()) {                    //make validate before close it
                appcubit.get(context).insertIntoDataBase(                                      //and insert data
                  title: task.text,
                  time: time.text,
                  date: date.text, context: context,
                );
              }
            } else {
              scaffold.currentState?.showBottomSheet((context) =>
                  Form(
                    key: formkey,
                    child: Container(
                      color: Colors.grey[150],
                      child: Column(mainAxisSize: MainAxisSize.min, children: [


                        text(
                          label: "Task Title",
                          text: TextInputType.text,
                          submitted: (l) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "task title can’t be empty";
                            }
                            return null;
                          },
                          getdata: task,                                     //controller
                          prefix: Icons.title,
                        ),
                        const SizedBox(
                          height: 10,
                        ),


                        text(
                          label: "Task Date",
                          text: TextInputType.datetime,
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025))
                                .then((value) {
                              date.text =
                                  DateFormat.yMMMd().format(value as DateTime);
                              print(value.toString());
                            });
                          },
                          submitted: (l) {},
                          getdata: date,
                          prefix: Icons.calendar_today,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "task date can’t be empty";
                            }
                            return null;
                          },
                        ),


                        const SizedBox(
                          height: 10,
                        ),


                        text(
                          onTap: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now())
                                .then((value) {
                              time.text = value!.format(context).toString()
                              ;
                            });
                          },
                          label: "Task Time",
                          text: TextInputType.datetime,
                          submitted: (l) {},
                          getdata: time,
                          prefix: Icons.watch_later_outlined,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "task time can’t be empty";
                            }
                            return null;
                          },
                        ),
                      ]),
                    ),
                  )).closed.then((value) {
                appcubit.get(context).bottomsheetcontroler(x: false, v: Icons.edit);
                task.clear();
                date.clear();
                time.clear();
              });
              appcubit.get(context).bottomsheetcontroler(x: true, v:Icons.add);
            }
          },
        ),
      );  }, listener: (BuildContext context, Object? state) {  },)
    );
  }



}