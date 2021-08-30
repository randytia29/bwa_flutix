part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client? client}) async {
    Uri url = Uri.https(baseUrl, '/3/discover/movie', {
      'api_key': apiKey,
      'language': 'en-US',
      'sort_by': 'popularity.desc',
      'include_adult': 'false',
      'include_video': 'false',
      'page': '$page'
    });

    client ??= http.Client();
    var response = await client.get(url);
    if (response.statusCode != 200) {
      return [];
    }
    var data = json.decode(response.body);
    List result = data['results'];
    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<Movie> getDetails(int? movieID, {http.Client? client}) async {
    Uri url = Uri.https(
        baseUrl, '/3/movie/$movieID', {'api_key': apiKey, 'language': 'en-US'});

    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);

    return Movie.fromJson(data);
  }

  static Future<List<Credit>> getCredits(int? movieID,
      {http.Client? client}) async {
    Uri url =
        Uri.https(baseUrl, '/3/movie/$movieID/credits', {'api_key': apiKey});

    client ??= http.Client();
    var response = await client.get(url);
    var data = json.decode(response.body);
    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: e['profile_path']))
        .take(8)
        .toList();
  }
}
