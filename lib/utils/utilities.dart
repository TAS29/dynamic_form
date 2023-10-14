import 'package:intl/intl.dart';

String currentTime() {
    DateFormat dateFormat = DateFormat('hh:mm a');
    DateTime now = DateTime.now();
    String time = dateFormat.format(now);
    return time;
  }