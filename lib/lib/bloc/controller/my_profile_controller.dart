
import 'package:astro/bloc/base/bloc_base.dart';
import 'package:astro/bloc/base/bloc_event.dart';
import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/base/bloc_states.dart';
import 'package:astro/bloc/event/profile_event_controller.dart';
import 'package:astro/models/profile/location_model.dart';
import 'package:astro/models/profile/relative_list_model.dart';
import 'package:astro/services/api_services.dart';
import 'package:astro/utils/api_keys.dart';
import 'package:astro/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MyProfileController implements BlocBase {
  late final ApiServices _apiServices;

  final _stateController = BehaviorSubject<BlocResponse>();
  final _locationStateController = BehaviorSubject<BlocResponse>();
  final _eventController = BehaviorSubject<BlocEvent>();
  RelativeListModel? _relativeListModel;

  MyProfileController() {
   _apiServices = ApiServices();
    _eventController.stream.listen(mapEventToState);
  }

  Stream<BlocResponse> get state => _stateController.stream;
  Stream<BlocResponse> get locationState => _locationStateController.stream;
  RelativeListModel? get relativeList => _relativeListModel??RelativeListModel();

  @override
  void closeStreams() {
    _stateController.close();
    _locationStateController.close();
    _eventController.close();
  }

  @override
  void emitEvent(BlocEvent event) {
    _eventController.sink.add(event);
  }

  @override
  Future<void> mapEventToState(BlocEvent event) async {
    if (event is RelativeListEvent) {
      _relativeList(event);
    }
    else if (event is AddRelativeEvent) {
      _addRelativeEent(event);
    }
    else if (event is SearchLocationEvent) {
      _searchLocationEent(event);
    }
    else if (event is DeleteRelativeProfileEvent) {
      _deleteRelativeProfileEent(event);
    }
  }

  Future<void> _relativeList(RelativeListEvent event) async {
    BlocResponse response = BlocResponse(BlocState.loading, event);
    _stateController.sink.add(response);
    try {
      response = await _apiServices.apiRequest(
        ApiRequest.apiGet,ApiEndPoints.relativeList,
        event,
        headers: {
          ApiKeys.authorization:ApiKeys.accessToken
        }
      );
      if(response.state == BlocState.success)
      {
        response =BlocResponse(
          BlocState.success, 
          event,
          data: RelativeListModel.fromJson(response.data['data'])
        );
        _relativeListModel = response.data;
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

  Future<void> _addRelativeEent(AddRelativeEvent event) async {
    BlocResponse response = BlocResponse(BlocState.loading, event);
    _locationStateController.sink.add(response);
    try {
      response = await _apiServices.apiRequest(
        ApiRequest.apiPost,ApiEndPoints.addRelative,
        event,
        headers: {
          ApiKeys.authorization:ApiKeys.accessToken,ApiKeys.contentType:ApiKeys.applicationJSON
        },
        body:{
          ApiKeys.birthDetails:{
            ApiKeys.dobDay:event.model.birthDetails?.dobDay,
            ApiKeys.dobMonth:event.model.birthDetails?.dobMonth,
            ApiKeys.dobYear:event.model.birthDetails?.dobYear,
            ApiKeys.tobHour:event.model.birthDetails?.tobHour,
            ApiKeys.tobMin:event.model.birthDetails?.tobMin,
            ApiKeys.meridiem:event.model.birthDetails?.meridiem,
          },
          ApiKeys.birthPlace:{
            ApiKeys.placeId:event.model.birthPlace?.placeId??'',
            ApiKeys.placeName:event.model.birthPlace?.placeName??''
          },
          ApiKeys.firstName:event.model.firstName,
          ApiKeys.lastName:event.model.lastName,
          ApiKeys.relationId:event.model.relationId,
          ApiKeys.gender:event.model.gender
        }
      );
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
     _locationStateController.sink.add(response); 
    }
  }

  Future<void> _searchLocationEent(SearchLocationEvent event) async {
    BlocResponse response = BlocResponse(BlocState.loading, event);
    _locationStateController.sink.add(response);
    try {
      response = await _apiServices.apiRequest(
        ApiRequest.apiGet,ApiEndPoints.location,
        event,
        body:{
          ApiKeys.inputPlace:event.text
        },
        queryParams: {
          ApiKeys.inputPlace:event.text
        }
      );
      if(response.state == BlocState.success)
      {
        response =BlocResponse(
          BlocState.success, 
          event,
          data: LocationList.fromJson(response.data['data'])
        );
        print("data ${response.data}");
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
     _locationStateController.sink.add(response); 
    }
  }  

  Future<void> _deleteRelativeProfileEent(DeleteRelativeProfileEvent event) async {
    BlocResponse response = BlocResponse(BlocState.loading, event);
    _locationStateController.sink.add(response);
    String endPoint = ApiEndPoints.deleteRelatieProfile + event.uuid;
    try {
      response = await _apiServices.apiRequest(
        ApiRequest.apiPost,endPoint,
        event,
        headers: {
          ApiKeys.authorization:ApiKeys.accessToken,ApiKeys.contentType:ApiKeys.applicationJSON
        },
      );
      if(response.state == BlocState.success)
      {
        print("profile deleted successdfully");
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
