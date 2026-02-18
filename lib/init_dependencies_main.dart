part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  await Hive.initFlutter();
  final box = await Hive.openBox('blogs');
  sl.registerLazySingleton(() => box);
  sl.registerLazySingleton(() => supabase.client);

  // Core Dependencies
  sl.registerLazySingleton(() => AppUserCubit());
  sl.registerFactory(() => InternetConnection());
  sl.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(sl()));

  // Auth Dependencies
  _initAuth();
  // Blog Dependencies
  _initBlog();
}

void _initAuth() {
  sl
    // Auth Remote Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    // Auth Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()))
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

void _initBlog() {
  sl
    // Blog Remote Data Source
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(sl()),
    )
    // Blog Local Data Source
    ..registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(sl()))
    // Blog Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: sl(),
        blogLocalDataSource: sl(),
        connectionChecker: sl(),
      ),
    )
    // Upload Blog Usecase
    ..registerFactory(() => UploadBlogUsecase(sl()))
    // Get All Blogs Usecase
    ..registerFactory(() => GetAllBlogsUsecase(sl()))
    // Blog Bloc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlogUsecase: sl(), getAllBlogsUsecase: sl()),
    );
}
