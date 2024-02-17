
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/stats.dart';
import '../shared/componant/componant.dart';


class arch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, states>(
      builder: (BuildContext context, state) {
        return condition(tasks: appcubit.get(context).archivedtasks);
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}