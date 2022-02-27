import 'package:astro/bloc/base/bloc_base.dart';
import 'package:astro/bloc/base/bloc_event.dart';
import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/base/bloc_states.dart';
import 'package:astro/bloc/event/ask_questions_event.dart';
import 'package:astro/models/questions_model.dart';
import 'package:astro/services/api_services.dart';
import 'package:astro/utils/api_keys.dart';
import 'package:astro/utils/app_constants.dart';
import 'package:rxdart/subjects.dart';

class AskQuestionController implements BlocBase {
  late final ApiServices _apiServices;

  final _stateController = BehaviorSubject<BlocResponse>();
  final _eventController = BehaviorSubject<BlocEvent>();

  AskQuestionController() {
   _apiServices = ApiServices();
    _eventController.stream.listen(mapEventToState);
  }

  Stream<BlocResponse> get state => _stateController.stream;

  @override
  void closeStreams() {
    _stateController.close();
    _eventController.close();
  }

  @override
  void emitEvent(BlocEvent event) {
    _eventController.sink.add(event);
  }

  @override
  Future<void> mapEventToState(BlocEvent event) async {
    if (event is QuestionsListEvent) {
      _questionsList(event);
    }
  }

  Future<void> _questionsList(QuestionsListEvent event) async {
    BlocResponse response = BlocResponse(BlocState.loading, event);
    _stateController.sink.add(response);
    try {
      response = await _apiServices.apiRequest(
        ApiRequest.apiGet,ApiEndPoints.questions,
        event,
      );
      if(response.state == BlocState.success)
      {
        response =BlocResponse(
          BlocState.success, 
          event,
          data: QuestionsListModel.fromJson(response.data)
        );
      }
    } catch (e) {
      response = await BlocResponse(
        BlocState.failed,
        event,
        message: e.toString(),
        exceptionType: e.runtimeType,
      );
    }
    finally
    {
     _stateController.sink.add(response); 
    }
  }           
}
