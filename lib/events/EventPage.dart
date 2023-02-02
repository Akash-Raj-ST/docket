import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:docket/utils/heading.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventState();
}

class _EventState extends State<EventPage> {
  List all_events = [
      {"date":"2023-03-23","time":"11:05","title":"Workshop on Deep Learning"},
      {"date":"2023-02-07","time":"13:05","title":"Workshop on Flutter UI"},
      {"date":"2023-01-15","time":"16:05","title":"Workshop on Security"},
      {"date":"2022-01-15","time":"16:05","title":"Workshop on Security"},

    ];


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Event'),
          
          Expanded(
            child:Scrollbar(
              scrollbarOrientation: ScrollbarOrientation.bottom,
              thumbVisibility: true,
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: all_events.map((event){
                     return EventItem(event:event);
                  }).toList(),
                ),
              ) ,
            )
            
          ),
        ],
      ),
    );
  }
}

class EventItem extends StatelessWidget {

  var event;
  var days_left = "";

  EventItem({required this.event, super.key});

  @override
  Widget build(BuildContext context) {

    var days_left = DateTime.parse(event['date']).difference(DateTime.now()).inDays;

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
                  Text(event['date'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      print("pressed");
                    }, 
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                  )
                ],
              ),
      
              //title
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 2,right: 8,bottom: 2),
                child: Center(
                  child: Text(event['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      
              //time and days left
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(event["time"],
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
                      padding: const EdgeInsets.only(left: 8,top: 2,right: 8,bottom: 2),
                      child: days_remaining(days_left),
                    )
                  )  
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}

Text days_remaining(days_left){

  var tx;

  if(days_left<0){
    tx = "${-1*days_left} days past";
  }else{
    tx = "${days_left} days left";
  }

  return Text(
      tx,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: days_left<0?Colors.red:Colors.black,
      ),
  );
}


