part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater("XXI Paragon"),
  Theater("XXI DP Mall"),
  Theater("E-Plaza"),
  Theater("XXI Transmart Setiabudi")
];
