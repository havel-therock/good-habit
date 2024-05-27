import 'package:daily/main.dart';
import 'package:daily/models/habit.dart';
import 'package:daily/views/habit_editor.dart';
import 'package:flutter/material.dart';

// TODO: @Kacper
// Make it prettier

// TODO: @Kacper
// Make it so it is responsonsive to a change.
// So that edited habits has an updated titel in the list instantly
// Read about Statefull List Items vs Statefull ListView

// TODO: @Kacper
// add orderdering of the list based on the time. Sonner events shows on a top.
class HabitView extends StatelessWidget {
  const HabitView({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(children: [
          const Icon(Icons.school),
          const Spacer(),
          Text(habit.title),
          const Spacer(),
          Text("${habit.startDate.hour}:${habit.startDate.minute}"),
        ]),
      ),
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(habit.title),
          content: const Text('Do you want to remove the habit?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                GoodHabitApp.habitsList.remove(habit);
                GoodHabitApp.habitsStorage.saveHabitsToStorage();
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),

      // TODO: @Kacper [tmp-solution-in-place]
      // fix navigation some how to not create a new Habit Editor widget
      // Maybe use Provider to change active_page variable for FrameView()
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
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
                body: const HabitEditor()),
            settings: RouteSettings(
              arguments: habit,
            ),
          ),
        );
      },
    );
  }
}

class HabitsView extends StatelessWidget {
  const HabitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
              children: GoodHabitApp.habitsList
                  .map((x) => HabitView(habit: x))
                  .toList()),
        ),
        TextButton(
          child: const Text("Clear All Habits"),
          onPressed: () {
            GoodHabitApp.habitsStorage.clearAllHabits();
          },
        ),
      ],
    );
  }
}
