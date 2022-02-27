import 'package:astro/bloc/base/bloc_event.dart';

class AskQuestionsEvents implements BlocEvent {}

class QuestionsListEvent implements AskQuestionsEvents {
  const QuestionsListEvent();
}