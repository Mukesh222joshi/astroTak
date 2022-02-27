
import 'package:astro/bloc/base/bloc_event.dart';
import 'package:astro/bloc/base/bloc_states.dart';

class BlocResponse<T> {
  final BlocState ?state;
  final BlocEvent ?event;
  final T ?data;
  final String ?message;
  final int ?statusCode;
  final Type ?exceptionType;

  BlocState ?prevState;
  BlocEvent ?prevEvent;

  BlocResponse(this.state, this.event,
      {this.data, this.message, this.statusCode, this.exceptionType});
}