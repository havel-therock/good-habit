import 'package:daily/main.dart';
import 'package:daily/models/habit.dart';
import 'package:flutter/material.dart';

class CurrentHabit extends StatefulWidget {
  const CurrentHabit({super.key});

  @override
  State<StatefulWidget> createState() => _CurrentHabitState();
}


// TODO: @Kacper
// add scrollable description part
// because now if the description is to long (vertical it will just run off the screen and you cannot see it)

class _CurrentHabitState extends State<CurrentHabit> {
  late Habit currentHabit;
  bool showDescription = false;

  // BottomNavigationBar always rebuilds widgets so it will be called again if you change the tab
  // that is why the _gewtCurrentHabit works here
  @override
  initState() {
    currentHabit = _getCurrentHabit();
    super.initState();
  }

    // TODO: @Kacper
    // Add Animations!
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(125),
        borderRadius: BorderRadius.circular(15),
        // BorderRadius.only(
        // topLeft: Radius.circular(15.0),
        // bottomRight: Radius.circular(15.0),),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            showDescription = !showDescription;
          });
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  currentHabit.title,
                  textAlign: TextAlign.center,
                ),
              ),
              if (showDescription && currentHabit.description != "") ...[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      currentHabit.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Habit _getCurrentHabit() {
    DateTime now = DateTime.now();
    for (Habit habit in GoodHabitApp.habitsList) {
      if (habit.startDate.compareTo(now) < 0 &&
          now.compareTo(habit.startDate.add(habit.duration)) < 0) {
        return habit;
      }
    }
    return Habit(title: 'No Active Habit');
  }
  // on_swipe_right() -> show previous habit
  // on_swipe_left() -> show next habit
  // on_tap() -> show description
  // on_press_and_hold() -> pop up a selection menu for current type of chore/habit
  // eg. type of chore = self_developement then pop up menu will have for example three choices (playing guitar, programming, exercise)
}
