import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdatabase/cubit/cubit.dart';
import 'package:localdatabase/shared/shared/shared.dart';

//text form field
Widget text({
  required String label,
  IconData? prefix,
  required TextInputType text,
  bool besecire = false,
  IconData? suffix,
  double radius = 20,
  required void Function(String)? submitted,
  Function()? pressedsuffix,
  required TextEditingController getdata,
  String? Function(String?)? validator,
  Function()? onTap,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        validator: validator,
        onFieldSubmitted: submitted,
        controller: getdata,
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
          labelText: label,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(radius)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(radius)),
          focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          prefixIcon: prefix != null
              ? Icon(
                  prefix,
                )
              : null,
          suffixIcon: suffix != null
              ? IconButton(
                  color: Colors.grey,
                  onPressed: pressedsuffix,
                  icon: Icon(
                    suffix,
                    size: 20,
                  ))
              : null,
        ),
        obscureText: besecire,
        keyboardType: text,
      ),
    );

Widget label({
  required Map model,
  required context,
}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${model['time']}"),
              backgroundColor: Colors.pink,
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: const TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "${model['date']}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  appcubit.get(context).update(state: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: () {
                  appcubit
                      .get(context)
                      .update(state: 'archive', id: model['id']);
                },
                icon: Icon(Icons.archive_outlined, color: Colors.grey)),
          ],
        ),
      ),
      onDismissed: (direction) {
        appcubit.get(context).deletefromdatabase(id: model['id']);
      },
    );



Widget condition({
  required List <Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length>0,
      builder: (BuildContext context) => ListView.separated(
          itemBuilder: (context, index) => label(
              model: tasks[index], context: context),
          separatorBuilder: (context, index) => Container(
                height: 10,
                color: Colors.grey[200],
              ),
          itemCount: tasks.length),
      fallback: (BuildContext context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "No Tasks Yet, Please Enter Some Tasks",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );


