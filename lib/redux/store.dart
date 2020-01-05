import 'modules/counter.dart';

class AppState {
  final CounterState counter;

  AppState({ this.counter });
}

AppState appStateReducer(AppState state, action) {
  return AppState(
    counter: counterReducer(state.counter, action)
  );
}