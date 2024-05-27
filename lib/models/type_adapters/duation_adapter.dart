import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final typeId = 0; // Put an ID you didn't use yet.

  @override
  Duration read(BinaryReader reader) {
    return Duration(minutes: reader.readInt());
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inMinutes);
  }
}
