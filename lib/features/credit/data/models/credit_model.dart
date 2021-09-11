import '../../domain/entities/credit.dart';

class CreditModel extends Credit {
  CreditModel({required String name, required String profilePath})
      : super(name: name, profilePath: profilePath);

  factory CreditModel.fromJson(Map<String, dynamic> json) {
    return CreditModel(
        name: json['name'], profilePath: json['profile_path'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'profile_path': profilePath};
  }
}
