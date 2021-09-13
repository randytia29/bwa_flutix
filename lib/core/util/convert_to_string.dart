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
