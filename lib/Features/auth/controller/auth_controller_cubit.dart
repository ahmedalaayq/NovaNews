import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/datasource/local/preference_manager.dart';
import '../../../core/datasource/local/storage_key.dart';
import 'auth_state.dart';

class AuthControllerCubit extends Cubit<AuthState> {
  AuthControllerCubit() : super(AuthInitial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final savedEmail =
      PreferenceManager.getData<String>(StorageKey.savedEmail);

      final savedPassword =
      PreferenceManager.getData<String>(StorageKey.savedPassword);

      if (savedEmail == null ||
          savedPassword == null ||
          email != savedEmail ||
          password != savedPassword) {
        emit(AuthFailure(errorMessage: 'Email or password is incorrect'));
        return;
      }

      await PreferenceManager.setData<bool>(
        StorageKey.isLoggedIn,
        true,
      );

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final existingEmail =
      PreferenceManager.getData<String>(StorageKey.savedEmail);

      if (existingEmail != null && existingEmail == email) {
        emit(AuthFailure(errorMessage: 'Email already exists'));
        return;
      }

      await PreferenceManager.setData<String>(
        StorageKey.savedEmail,
        email,
      );

      await PreferenceManager.setData<String>(
        StorageKey.savedPassword,
        password,
      );

      await PreferenceManager.setData<String>(
        StorageKey.username,
        username,
      );

      await PreferenceManager.setData<bool>(
        StorageKey.isLoggedIn,
        true,
      );

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}