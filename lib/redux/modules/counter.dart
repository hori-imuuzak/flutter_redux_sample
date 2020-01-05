import 'package:redux/redux.dart';

class CounterState {
  final int counter;

  CounterState({this.counter});
}

class IncrementAction {

}

CounterState counterReducer(CounterState state, IncrementAction action) {
  return CounterState(counter: state.counter + 1);
}

final counterReducers = combineReducers<CounterState>([
  TypedReducer<CounterState, IncrementAction>(counterReducer)
]);