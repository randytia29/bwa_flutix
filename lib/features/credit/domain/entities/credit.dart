import 'package:equatable/equatable.dart';

class Credit extends Equatable {
  final String name;
  final String profilePath;

  const Credit({required this.name, required this.profilePath});

  @override
  List<Object?> get props => [name, profilePath];
}
