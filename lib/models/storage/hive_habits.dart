import 'package:daily/main.dart';
import 'package:daily/models/habit.dart';
import 'package:hive/hive.dart';

class Storage {
  final _habitsBox = Hive.box('HabitsList');

  void saveHabitsToStorage() {
    _habitsBox.put('habits', GoodHabitApp.habitsList);
  }

  List<Habit> getHabitsFromStorage() {
    return _habitsBox.get('habits')?.cast<Habit>() ?? [];
  }

  void clearAllHabits() {
   GoodHabitApp.habitsList.clear();
    _habitsBox.clear();
  }

  // saveHive

  // saveHabit

  // loadHive

  // loadHabit ?

  // removeHabit ?

  // removeHive ?
}
