import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  sl.registerLazySingleton(() => supabase.client);

  // Core Dependencies
  sl.registerLazySingleton(() => AppUserCubit());

  // Auth Dependencies
  _initAuth();
}

void _initAuth() {
  sl
    // Remote Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    // Auth Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()))
    // Sign Up Usecase
    ..registerFactory(() => SignUpUsecase(sl()))
    // Sign In Usecase
    ..registerFactory(() => SignInUsecase(sl()))
    // Current User Usecase
    ..registerFactory(() => CurrentUserUsecase(sl()))
    // Auth Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        signUpUsecase: sl(),
        signInUsecase: sl(),
        currentUserUsecase: sl(),
        appUserCubit: sl(),
      ),
    );
}
