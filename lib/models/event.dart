import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 2)
class Event {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String dateCreated;

  @HiveField(2)
  final String deadline;

  @HiveField(3)
  final String alert;

  @HiveField(4)
  final bool status;

  Event({
    required this.title,
    required this.dateCreated,
    required this.deadline,
    required this.alert,
    required this.status,
  });


}
