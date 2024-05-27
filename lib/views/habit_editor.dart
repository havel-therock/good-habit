import 'package:daily/main.dart';
import 'package:daily/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HabitEditor extends StatefulWidget {
  const HabitEditor({super.key});

  @override
  State<StatefulWidget> createState() => _HabitEditorState();
}

class _HabitEditorState extends State<HabitEditor> {
  // always load new Habit with empty "" all fields and then if you get to the editor
  // from edition of currently existing habit then you just need to load the new value
  // set from
  Habit editedHabit = Habit(title: "");
  bool addNewHabit = true;
  // getHabitForEdition(); load exisiting one or create empty one

  late TextEditingController titleController =
      TextEditingController(text: editedHabit.title);
  late TextEditingController descriptionController =
      TextEditingController(text: editedHabit.description);

  TimeOfDay? newTime = TimeOfDay.fromDateTime(DateTime.now());
  DateFormat dateFormat = DateFormat("HH:mm");
  DateTime now = DateTime.now();
// Converting String to DateTime object
// DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");

  double _currentSliderValue = 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      addNewHabit = true;
    } else {
      addNewHabit = false;
      editedHabit = ModalRoute.of(context)!.settings.arguments as Habit;
    }

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                  controller: descriptionController,
                  minLines: 5,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Description'))),
          const Spacer(),
          OutlinedButton(
            onPressed: () async {
              newTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                    hour: DateTime.now().hour, minute: DateTime.now().minute),
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (newTime != null) {
                setState(() {});
              } else {
                newTime = TimeOfDay.fromDateTime(DateTime.now());
              }
            },
            child: const Text('Starting Time'),
          ),
          Center(
            child: Text(
              dateFormat.format(DateTime(now.year, now.month, now.day,
                  newTime!.hour, newTime!.minute)),
            ),
          ),
          Slider(
            value: _currentSliderValue,
            max: 120,
            divisions: 120,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          Row(children: [
            const Spacer(),
            const Text('End Time:'),
            const Spacer(),
            Text(dateFormat.format(DateTime(now.year, now.month, now.day,
                    newTime!.hour, newTime!.minute)
                .add(Duration(minutes: _currentSliderValue.toInt())))),
            const Spacer(),
          ]),
          const Spacer(),
        ],
      ),
      // TODO: @Kacper
      // extract logic
      // expand logic
      // eq. cannot have two habits in the same time
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editedHabit.title = titleController.text;
          editedHabit.description = descriptionController.text;
          editedHabit.startDate = DateTime(
              now.year, now.month, now.day, newTime!.hour, newTime!.minute);
          editedHabit.duration = Duration(minutes: _currentSliderValue.toInt());

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Saved!')));
          if (addNewHabit) {
            GoodHabitApp.habitsList.add(editedHabit);
          } else {
            GoodHabitApp.habitsStorage.saveHabitsToStorage();
            Navigator.pop(context);
          }
          GoodHabitApp.habitsStorage.saveHabitsToStorage();

          addNewHabit = true;

          editedHabit = Habit(title: "");
          titleController.text = editedHabit.title;
          descriptionController.text = editedHabit.description;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
