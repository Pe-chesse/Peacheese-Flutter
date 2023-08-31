String timeAgo(DateTime baseDateTime, {int daysAgo = 0, int minutesAgo = 0}) {

  DateTime currentDateTime = DateTime.now();

  DateTime targetDateTime = baseDateTime.subtract(Duration(days: daysAgo, minutes: minutesAgo));

  Duration difference = currentDateTime.difference(targetDateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays}일 전';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}시간 전';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}분 전';
  } else {
    return '방금';
  }
}