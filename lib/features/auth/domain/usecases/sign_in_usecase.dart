import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInUsecase implements UseCase<User, SignInHeaders> {
  final AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignInHeaders params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInHeaders {
  final String email;
  final String password;

  SignInHeaders({required this.email, required this.password});
}
