import 'package:bwaflutix/core/usecases/usecase.dart';
import 'package:bwaflutix/features/user/domain/entities/user.dart';
import 'package:bwaflutix/features/user/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

class GetUser implements Usecase<User, Params> {
  final UserRepository? repository;

  GetUser(this.repository);

  @override
  Future<User?> call(Params params) async {
    return await repository?.getUser(params.id);
  }
}

class Params extends Equatable {
  final String? id;

  Params({this.id});

  @override
  List<Object?> get props => [id];
}
