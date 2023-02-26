// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 2)
class Event extends HiveObject{
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String dateCreated;

  @HiveField(2)
  final String deadlineDate;

  @HiveField(3)
  final String deadlineTime;

  @HiveField(4)
  final String alert;

  @HiveField(5)
  final bool alertStatus;

  Event({
    required this.title,
    required this.dateCreated,
    required this.deadlineDate,
    required this.deadlineTime,
    required this.alert,
    required this.alertStatus,
  });


}
