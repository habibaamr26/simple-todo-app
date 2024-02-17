import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdatabase/shared/componant/componant.dart';
import 'package:localdatabase/shared/shared/shared.dart';
import 'package:localdatabase/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../cubit/stats.dart';

class taskscreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, states>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
    return condition(tasks: appcubit.get(context).newtasks);
      },

    );
  }
}


//appcubit.get(context).tasks.length