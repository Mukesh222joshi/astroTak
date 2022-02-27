import 'package:astro/bloc/base/bloc_event.dart';

abstract class BlocBase {
  void emitEvent(BlocEvent event);
  void mapEventToState(BlocEvent event);
  void closeStreams();
}