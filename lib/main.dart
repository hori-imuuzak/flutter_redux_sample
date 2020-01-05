import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_sample/redux/store.dart';
import 'package:flutter_redux_sample/redux/modules/counter.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appStateReducer,
      initialState: AppState(
        counter: CounterState(counter: 0)
      ));

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(store: store, title: 'Redux Sample'),
    );
  }
}

class CounterScreen extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  CounterScreen({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: <Widget>[
              StoreConnector<AppState, VoidCallback>(
                  converter: (store) =>
                      () => store.dispatch(CounterActions.Reset),
                  builder: (context, callback) {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: 'Reset',
                      onPressed: callback,
                    );
                  })
            ],
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StoreConnector<AppState, int>(
                  converter: (store) => store.state.counter.counter,
                  builder: (context, count) {
                    return Text("${count}");
                  })
            ],
          )),
          floatingActionButton: StoreConnector<AppState, VoidCallback>(
              converter: (store) =>
                  () => store.dispatch(CounterActions.Increment),
              builder: (context, callback) {
                return FloatingActionButton(
                    onPressed: callback,
                    tooltip: 'Increment',
                    child: Icon(Icons.add));
              }),
        ));
  }
}
