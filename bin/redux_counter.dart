import 'package:redux_counter/redux_counter.dart' as redux_counter;
import 'package:redux/redux.dart';

class CounterState {
  final int counter; 
  const CounterState({
    required this.counter,
  });

factory CounterState.initial(){
   return CounterState(counter: 0);
}


@override
 String toString() => 'CounterState(Counter: $counter)';
 

  CounterState copyWith({int? counter}) => CounterState(counter:  counter ?? this.counter,);
}

class Increment {
  final int payload;
  Increment({
    required this.payload,
  });

  @override
String toString() => 'Increment(Payload: $payload)';
  
}

class Decrement {
  final int payload;
 const Decrement({
    required this.payload,
  });
    @override
String toString() => 'Decrement(Payload: $payload)';
}

CounterState counterReducer(CounterState state, dynamic action){
  if(action is Increment){
    return CounterState(counter: state.counter + action.payload);
  }else if (action is Decrement){
    return state.copyWith(counter: state.counter - action.payload);
  }
  return state;
}




void main() async {
  //Ponasa se kao repozitorij  
  final store = Store<CounterState>(
    counterReducer, 
    initialState: CounterState.initial(),
    syncStream: true,
  );
  
final subscription = store.onChange.listen((CounterState state){
  print('Counter state: $state');
});

  store.dispatch(Increment(payload: 3));
  store.dispatch(Increment(payload: 4));
  await Future.delayed(const Duration(seconds: 1)); 
  store.dispatch(Decrement(payload: 2));

  subscription.cancel();
}