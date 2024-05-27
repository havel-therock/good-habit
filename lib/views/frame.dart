import 'package:daily/main.dart';
import 'package:daily/views/current_habit.dart';
import 'package:daily/views/habit_editor.dart';
import 'package:daily/views/habits_view.dart';
import 'package:flutter/material.dart';

// change name 'Frame' to 'Navigation' ?

class FrameView extends StatefulWidget {
  const FrameView({super.key});

  @override
  State<FrameView> createState() => _FrameViewState();
}

class _FrameViewState extends State<FrameView> {
  // add new habit, current habit, manage habits (create a plan for a day for a week
  // third pane seven tiles coresponding to

  List<Widget> pages = [
    const HabitEditor(),
    const CurrentHabit(),
    const HabitsView(), // weekView/dayView ?
  ];

  int activePage = 0; // = 1; // in production should be set to one so you always defaults to a current habit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Good Habit',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
              )),
          elevation: 10.0,
          shadowColor: Colors.black,
          centerTitle: true,
        ),
        body: pages.elementAt(activePage),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Edit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.games_rounded),
              label: 'Active',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hub),
              label: 'Habits',
            ),
          ],
          currentIndex: activePage,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            setState(() {
              activePage = index;
            });
          },
        ));
  }
}
