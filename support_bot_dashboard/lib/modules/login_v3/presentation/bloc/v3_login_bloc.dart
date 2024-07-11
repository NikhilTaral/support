import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support_bot_dashboard/core/network/custom_exception.dart';
import 'package:support_bot_dashboard/injectable_init.dart';
import 'package:support_bot_dashboard/utils/log.dart';
import 'package:support_bot_dashboard/utils/service/auth/auth_service.dart';
import 'dart:html' as js;
part 'v3_login_event.dart';
part 'v3_login_state.dart';

class V3LoginBloc extends Bloc<V3LoginEvent, V3LoginState> {
  final AuthService _authService = serviceLocator<AuthService>();
  V3LoginBloc() : super(V3LoginInitialState()) {
    on<PerformLogInEvent>(_onPerformLogin);
  }

  FutureOr<void> _onPerformLogin(
      PerformLogInEvent event, Emitter<V3LoginState> emit) async {
    try {
      if (state is V3LoginLoadingState) {
        Log.debug("$runtimeType attempted to fetch data while loading");
        return;
      }

      emit(V3LoginLoadingState());
      var isAuthenticated = await _authService.isAuthenticated();

      if (!isAuthenticated) {
        isAuthenticated = await _authService.authenticate();
        if (!isAuthenticated) {
          emit(V3LoginFailureState());
          return;
        }
      }

      js.window.location.reload();
      emit(V3LoginSuccessState());
    } on CustomException {
      emit(
        V3LoginFailureState(),
      );
    } catch (e) {
      Log.debug(e.toString());
      emit(V3LoginFailureState());
    }
  }
}
