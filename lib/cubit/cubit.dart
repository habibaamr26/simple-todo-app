import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdatabase/cubit/stats.dart';
import 'package:sqflite/sqflite.dart';

import '../module/archive_screen.dart';
import '../module/done_screen.dart';
import '../module/task_screen.dart';

class appcubit extends Cubit<states> {
  appcubit():super(initialstata());

  static appcubit get(context)=> BlocProvider.of(context);

  List<Widget> Screens = [
    taskscreen(),
    done(),
    arch(),
  ];
  
  List <Widget> app=[
    Text("Tasks Screen"),
   Text( "Done Screen"),
    Text("Archive Screen"),
  ];
  int toselected = 0;
  bool bottomsheet = false;

  IconData icon = Icons.edit;

  Database? database;

  void bottomsheetcontroler({required bool x,required IconData v }){
   bottomsheet=x;
   icon=v;
   emit(bottomsheetstat());
  }



  void changebootom(int index){

    toselected=index;
    emit(bottomnav());
}

List <Map> newtasks=[];
  List <Map> donetasks=[];
  List <Map> archivedtasks=[];





  void creatDataBase()  {
     openDatabase("TODO.db", version: 1,
        onCreate: (database, version) async {
          print("database is created");
          await database
              .execute(
              'CREATE TABLE task(id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,statues TEXT)')
              .then((value) => debugPrint("table is created "));
        },
         onOpen: (database) {
         getdata(database);
        }).then((value) {
       database=value;
       emit(creatstate());
     });
  }




 insertIntoDataBase(
      {@required title, @required date, @required time,required context})
 async {
   await database?.transaction((txn)  async {
      await txn
          .rawInsert(
          'INSERT INTO task(title,date,time,statues) VALUES("$title","$date","$time","now")')
          .then((value) {
            emit(insertstate());
            Navigator.pop(context);
            getdata(database);
          });

    });
  }



  void getdata(database)
   async {
     newtasks=[];
    donetasks=[];
    archivedtasks=[];
      await database.rawQuery('SELECT * FROM task').then((value){
       value.forEach((element) {
         if(element["statues"]=='now') {
           newtasks.add(element);
         } else if(element["statues"]=='done') {
           donetasks.add(element);
         } else {
           archivedtasks.add(element);
         }
       });
       emit(getstate());
     });
   }



// to update database
  void update({
    required String state,
   required int id,
})
  async {
     database!.rawUpdate('UPDATE task SET statues=? WHERE id = ?',
        ["$state",id ]).
     then((value)
     { getdata(database);
       emit(updatestate());
     });

  }



  void deletefromdatabase({required int id})
  {
    database!.rawDelete('DELETE FROM task WHERE id=?',[id]).then((value){
      getdata(database);
      emit(dalatestate());
    });
  }
}













/*.then((value){
      value.foreach((element){
        if(element["statues"]=='now') {
          tasks.add(element);
        } else if(element["statues"]=='done') {
          donetasks.add(element);
        } else {
          archivedtasks.add(element);
        }
      });
      value=tasks;
      print(tasks);
      emit(getstate());
    });*/








