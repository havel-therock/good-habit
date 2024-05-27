import 'package:daily/models/habit.dart';
import 'package:daily/models/type_adapters/duation_adapter.dart';
import 'package:flutter/material.dart';
import 'views/frame.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:daily/models/storage/hive_habits.dart';

// to store images in place where user cannot access from outside the app is:
// getApplicationDocumentsDirectory()
// getFDocumentsDirectory() is where user can delete photops from a file browser

// TODO: @Kacper
// add push notification if a habit begins

// TODO: @Kacper
// add counter of completed tasks in to shared preferences just a basic uint32_t

void initHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(HabitAdapter())
    ..registerAdapter(DurationAdapter());
  await Hive.openBox('HabitsList');
}

void main() {
  initHive();
  runApp(const GoodHabitApp());
}

class GoodHabitApp extends StatelessWidget {
  const GoodHabitApp({super.key});

  static Storage habitsStorage = Storage();
  static List<Habit> habitsList = habitsStorage.getHabitsFromStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FrameView(),
      // TODO: @Kacper
      // change this horrible font
      theme: ThemeData(fontFamily: 'InfiniteBeyond'),
      // debugShowCheckedModeBanner: false,
    );
  }
}
