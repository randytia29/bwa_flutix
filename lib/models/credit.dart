part of 'models.dart';

class Credit extends Equatable {
  final String? name;
  final String? profilePath;

  Credit({this.name, this.profilePath});

  factory Credit.fromJson(Map<String, dynamic> json) {
    return Credit(name: json['name'], profilePath: json['profile_path']);
  }

  @override
  List<Object?> get props => [name, profilePath];
}
