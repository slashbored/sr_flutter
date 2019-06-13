import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvent { stay, increment}

class CounterBloc extends Bloc<CounterEvent, int> {

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.stay:
        yield currentState;
        break;
      case CounterEvent.increment:
        yield currentState + 2;
        break;
      default:
        throw Exception('unhandled event: $event');
    }
  }
}