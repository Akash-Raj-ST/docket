import 'package:docket/tasks/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:docket/tasks/TaskPage.dart';
import './events/EventPage.dart';
import 'package:docket/services/event.dart';
import 'package:docket/services/task.dart';
import 'package:docket/Add/add.dart';

import 'events/bloc/event_bloc.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => EventService()),
        RepositoryProvider(create: (context) => TaskService()),
      ],
      child: MaterialApp(
        home: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Docket!")),
        body: Column(
          children: [
            EventPage(),
            TaskPage(),
          ],
        ),
        //floatingActionButton: AddButton(context)
      );
  }
}

