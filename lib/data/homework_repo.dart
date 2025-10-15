import 'package:hive/hive.dart';
import '../models/homework.dart';

class HomeworkStorage {
  static const boxName = 'homeworkBox';

  Future<void> init() async {
    await Hive.openBox<Homework>(boxName);
  }

  List<Homework> getAll() => Hive.box<Homework>(boxName).values.toList();

  Future<void> add(Homework hw) async =>
      Hive.box<Homework>(boxName).put(hw.id, hw);

  Future<void> toggle(String id) async {
    final box = Hive.box<Homework>(boxName);
    final hw = box.get(id);
    if (hw != null) {
      hw.isCompleted = !hw.isCompleted;
      await hw.save();
    }
  }
}
