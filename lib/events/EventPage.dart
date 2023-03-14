import 'dart:ffi';

import 'package:docket/events/UpdateEventPage.dart';
import 'package:docket/events/bloc/event_bloc.dart';
import 'package:docket/services/event.dart';
import 'package:docket/services/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:docket/utils/heading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/showSnack.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventState();
}

class _EventState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        if(state is EventAdded){
          showSnackBar(context, "Event Added");
        }

        if(state is EventDeleted){
          showSnackBar(context, "Event Deleted");
        }

        if(state is EventUpdated){
          showSnackBar(context, "Event Updated");
        }
      },
      builder: (context, state) {
        return BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoadedState) {
              return Container(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading('Event'),
                    Expanded(
                        child: Scrollbar(
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      thumbVisibility: true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 8),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: state.Events.map((event) {
                            return EventItem(event: event);
                          }).toList(),
                        ),
                      ),
                    )),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Loading..."));
            }
          },
        );
      },
    );
  }
}

class EventItem extends StatelessWidget {
  var event;
  var days_left = "";

  EventItem({required this.event, super.key});

  double getFontSize(int len){
    double size;

    if(len<=25) size = 22;
    else if(len<=50) size = 20;
    else if(len<=75) size = 18;
    else size = 16;

    return size;
  }

  @override
  Widget build(BuildContext context) {
    var days_left =
        DateTime.parse(event.deadlineDate).difference(DateTime.now()).inDays;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue[700],
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //date and options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.deadlineDate,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<EventBloc>(context)
                              .add(DeleteEventEvent(key: event.key));
                          print("delete button pressed");
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),

                //title
                GestureDetector(

                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: UpdateEventPage(event: event));
                      }
                    );

                    print("Event Tapped");
                  },

                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 2, right: 8, bottom: 2),
                      child: Center(
                        child: Text(
                          event.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getFontSize(event.title.length),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //time and days left
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.deadlineTime,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 2, right: 8, bottom: 2),
                          child: days_remaining(days_left),
                        ))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

Text days_remaining(days_left) {
  var tx,ty;

  if(days_left==1 || days_left==-1) ty="day";
  else ty="days";

  if (days_left < 0) {
    tx = "${-1 * days_left} ${ty} past";
  } else {
    tx = "${days_left} ${ty} left";
  }

  return Text(
    tx,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: days_left < 0 ? Colors.red : Colors.black,
    ),
  );
}
