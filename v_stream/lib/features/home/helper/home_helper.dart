import 'package:timeago/timeago.dart' as timeago;

String getTimeAgoText(DateTime dateTime) {
  return timeago.format(dateTime, locale: 'en_short');
}

String formatDate(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
}


