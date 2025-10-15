import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'homework.g.dart';

@HiveType(typeId: 0)
class Homework extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String subject;

  @HiveField(2)
  String title;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isCompleted;

  Homework({
    String? id,
    required this.subject,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();
}
