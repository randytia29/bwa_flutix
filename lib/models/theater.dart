import 'package:equatable/equatable.dart';

class Theater extends Equatable {
  final String? name;

  const Theater(this.name);

  @override
  List<Object?> get props => [name];
}

List<Theater> dummyTheaters = const [
  Theater("XXI Paragon"),
  Theater("XXI DP Mall"),
  Theater("E-Plaza"),
  Theater("XXI Transmart Setiabudi")
];
