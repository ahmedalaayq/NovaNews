import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmit<S> on Cubit<S> {
  void safeEmit(S state) {
    if (!isClosed) {
      emit(state);
    }
  }
}