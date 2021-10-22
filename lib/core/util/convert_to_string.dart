String seatsInString(List<String> seats) {
  String s = '';
  for (var seat in seats) {
    s += seat + ((seat != seats.last) ? ', ' : '');
  }
  return s;
}

String genresAndLanguage(List<String> genres, String language) {
  String s = '';
  for (var genre in genres) {
    s += genre + (genre != genres.last ? ', ' : '');
  }
  return '$s - $language';
}

String shortDayName(DateTime dateTime) {
  switch (dateTime.weekday) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    default:
      return 'Sun';
  }
}

String dateAndTime(DateTime dateTime) {
  return '${shortDayName(dateTime)} ${dateTime.day}, ${dateTime.hour}:00';
}

String dayName(DateTime dateTime) {
  switch (dateTime.weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    default:
      return 'Sunday';
  }
}

String monthName(DateTime dateTime) {
  switch (dateTime.month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    default:
      return 'December';
  }
}
