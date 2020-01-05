class CounterState {
  final int counter;

  CounterState({this.counter});
}

enum CounterActions {
  Increment,
  Reset
}

CounterState counterReducer(CounterState state, action) {
  switch (action) {
    case CounterActions.Increment:
      return CounterState(counter: state.counter + 1);
    case CounterActions.Reset:
      return CounterState(counter: 0);
  }

  return state;
}
