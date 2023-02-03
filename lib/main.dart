import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:docket/tasks/TaskPage.dart';
import './events/EventPage.dart';
import 'package:docket/services/event.dart';
import 'package:docket/services/task.dart';

void main() async{
  await Hive.initFlutter();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(

      providers: [
        RepositoryProvider(create: (context)=>EventService()),
        RepositoryProvider(create: (context)=>TaskService()),
      ],

      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              EventPage(),
              TaskPage(),
            ],
          ),
        ),
      ),
    );
  }
}