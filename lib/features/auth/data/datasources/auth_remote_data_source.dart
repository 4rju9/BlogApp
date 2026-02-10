import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/model/user_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserDto> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserDto> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserDto?> getUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserDto> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw ServerException("Can't find user associated with: $email!");
      } else {
        return UserDto.fromJson(user.toJson());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserDto> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      final user = response.user;
      if (user == null) {
        throw ServerException("User $name not found!");
      } else {
        return UserDto.fromJson(user.toJson());
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserDto?> getUser() async {
    try {
      if (currentUserSession == null) return null;
      final user = await supabaseClient
          .from("profiles")
          .select()
          .eq("id", currentUserSession!.user.id);
      return UserDto.fromJson(
        user.first,
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
