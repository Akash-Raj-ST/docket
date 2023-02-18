import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String dateCreated;

  @HiveField(2)
  final bool status;

  Task({
    required this.title,
    required this.dateCreated,
    required this.status,
  });

  
}
