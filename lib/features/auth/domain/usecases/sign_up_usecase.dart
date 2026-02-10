import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUsecase implements UseCase<User, SignUpHeaders> {
  final AuthRepository authRepository;
  const SignUpUsecase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SignUpHeaders params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpHeaders {
  final String name;
  final String email;
  final String password;

  SignUpHeaders({
    required this.name,
    required this.email,
    required this.password,
  });
}
