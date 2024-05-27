import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 1)
class Habit {
  Habit(
      {this.title = "",
      this.description = "",
      this.duration = const Duration(minutes: 30),
      this.period = const Duration(days: 7),
      DateTime? startDate})
      : startDate = startDate ?? DateTime.now();

//  Map<String, dynamic> toMap() {
//    return {
//      'title': title,
//      'description': description,
//      'startDate': startDate,
//      'duration': duration.toString(),
//      'period': period.toString()
//    };
//  }
//
//  factory Habit.fromMap(Map<String, dynamic> map) {
//    return Habit(
//        title: map['title'],
//        description: map['description'],
//        startDate: map['startDate'],
//        duration: Duration(minutes:int.parse(map['duration'])),
//        period: Duration(days: int.parse(map['period'])),
//        );
//  }

  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  // maybe change to tags (list of enums that describe the category)
  // HabitCategory? category;

  @HiveField(2)
  DateTime startDate;

    // Durtation is not recognized
    // Need to register an adapter for that or store it as a primitive type
  @HiveField(3)
  Duration duration;
  @HiveField(4)
  Duration period;

  // TODO: @Kacper
  // everyMonth?
  // everyYear? is it make sense even to do something once a year?
  // explicit next date!

  DateTime getNextStartingDate() {
    return startDate.add(period);
  }
}

enum HabitCategory { fun, chore, selfDevelopment }
