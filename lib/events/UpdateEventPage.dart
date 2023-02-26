import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/AddButton.dart';
import '../components/CustomTextField.dart';
import '../models/event.dart';
import 'bloc/event_bloc.dart';

class UpdateEventPage extends StatefulWidget {
  final Event event;

  const UpdateEventPage({required this.event,super.key});

  @override
  State<UpdateEventPage> createState() => _UpdateEventPageState();
}

class _UpdateEventPageState extends State<UpdateEventPage> {
  final _eventContoller = TextEditingController();

  late String event_name;
  late String date;
  late String time;
  late String alert;
  late bool alertStatus;

  void initState(){
    this.event_name = widget.event.title;
    this.date = widget.event.deadlineDate;
    this.time = widget.event.deadlineTime;
    this.alert = widget.event.alert;
    this.alertStatus = widget.event.alertStatus;

    _eventContoller.text = this.event_name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is EventAdded){
          print("event added successfully");
        }
      },
      builder: (context, state) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CustomTextField(
                    controller: _eventContoller,
                    label: "Event"
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: DateTimePicker(
                              type: DateTimePickerType.date,
                              initialDate: DateTime.parse(date),
                              initialValue: date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              onChanged: (value) => {
                                setState(() {
                                  date = value;
                                })
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Date"),
                              ),          
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                            child: Container(
                              child: DateTimePicker(
                                type: DateTimePickerType.time,
                                initialValue: time,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.lock_clock),
                                onChanged: (value) => {
                                  setState(() {
                                    time = value;
                                  })
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Time"),
                                  ),  
                              ),
                                          
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(

                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              initialDate: DateTime.parse(alert),
                              initialValue: alert,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.lock_clock),
                              onChanged: (value) => {
                                setState(() {
                                  alert = value;
                                })
                              },
                      
                              decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Alert"),
                              ), 
                            ),
                          ),
                        ),
                      ),


                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left:20,top:8,right:20,bottom:8),
                            child: Transform.scale(
                              scale: 1.5,
                              child: Switch(
                                value: alertStatus, 
                                onChanged: (value){
                                  setState(() {
                                    alertStatus = value;
                                  });
                                }
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              CustomAddButton(
                onPressed: () {
                  if (_eventContoller.text.length > 0) {
                    BlocProvider.of<EventBloc>(context).add(UpdateEventEvent(
                          key: widget.event.key,
                          event: Event(
                            title: _eventContoller.text,
                            dateCreated: new DateTime.now().toString(),
                            deadlineDate: date,
                            deadlineTime: time,
                            alert: alert,
                            alertStatus: alertStatus
                          )
                      )
                    );
        
                        Navigator.of(context).pop();
        
                  } else {
                    //snack for empty warning
                  }
                },
                label: "Update Event",
              )
            ],
          ),
        );
      },
    );
  }
}
