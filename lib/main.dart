import 'package:docket/services/notification.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
              providers: [
                RepositoryProvider(create: (context) => EventService()),
                RepositoryProvider(create: (context) => TaskService()),
              ],

              child: MultiBlocProvider(
                providers: [
                  BlocProvider<TaskBloc>(
                    create: (BuildContext context) => TaskBloc(RepositoryProvider.of<TaskService>(context))..add(TaskServiceEvent()),
                  ),
                  BlocProvider<EventBloc>(
                    create: (BuildContext context) => EventBloc(RepositoryProvider.of<EventService>(context))..add(EventServiceEvent()),
                  ),
                ],

                child: MaterialApp(
                  home: MyApp(),
                ),
              )
          );
  }
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

        floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers:[
                              BlocProvider.value(value: BlocProvider.of<TaskBloc>(context)),
                              BlocProvider.value(value: BlocProvider.of<EventBloc>(context)),
                            ],
                            child: AddPage()
                            )
                          )
                    );

                  },
                  child: Icon(Icons.add),
                )
      );
  }
}

