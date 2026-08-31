import 'package:intl/intl.dart';


String toShortDate(int dateTime)=>DateFormat('dd MMM y')
    .format(DateTime.fromMillisecondsSinceEpoch(dateTime));
String toLongDate(int dateTime)=>DateFormat('dd MMMM y, hh:mm a')
    .format(DateTime.fromMillisecondsSinceEpoch(dateTime));