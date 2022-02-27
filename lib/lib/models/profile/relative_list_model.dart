import 'package:intl/intl.dart';

class RelativeListModel {
  int? pageNo;
  int? numberOfElements;
  int? pageSize;
  int? totalElements;
  int? totalPages;
  List<AllRelatives>? allRelatives;

  RelativeListModel(
      {this.pageNo,
      this.numberOfElements,
      this.pageSize,
      this.totalElements,
      this.totalPages,
      this.allRelatives});

  RelativeListModel.fromJson(Map<String, dynamic> json) {
    pageNo = json['pageNo'];
    numberOfElements = json['numberOfElements'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    if (json['allRelatives'] != null) {
      allRelatives = <AllRelatives>[];
      json['allRelatives'].forEach((v) {
        allRelatives!.add(new AllRelatives.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNo'] = this.pageNo;
    data['numberOfElements'] = this.numberOfElements;
    data['pageSize'] = this.pageSize;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    if (this.allRelatives != null) {
      data['allRelatives'] = this.allRelatives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllRelatives {
  String? uuid;
  String? relation;
  int? relationId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;
  String? gender;
  String? dateAndTimeOfBirth;
  BirthDetails? birthDetails;
  BirthPlace? birthPlace;
  String? dateOfBirth;
  String? timeOfBirth;

  AllRelatives(
      {this.uuid,
      this.relation,
      this.relationId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.fullName,
      this.gender,
      this.dateAndTimeOfBirth,
      this.birthDetails,
      this.birthPlace,this.dateOfBirth,this.timeOfBirth});

  AllRelatives.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    relation = json['relation'];
    relationId = json['relationId'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    gender = json['gender'];
    dateAndTimeOfBirth = json['dateAndTimeOfBirth'];
    birthDetails = json['birthDetails'] != null
        ? new BirthDetails.fromJson(json['birthDetails'])
        : null;
    birthPlace = json['birthPlace'] != null
        ? new BirthPlace.fromJson(json['birthPlace'])
        : null;

    dateOfBirth = DateFormat("dd-MM-yyyy").format(DateTime.parse(json['dateAndTimeOfBirth']));
    timeOfBirth = DateFormat("hh:mm").format(DateTime.parse(json['dateAndTimeOfBirth']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['relation'] = this.relation;
    data['relationId'] = this.relationId;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['dateAndTimeOfBirth'] = this.dateAndTimeOfBirth;
    if (this.birthDetails != null) {
      data['birthDetails'] = this.birthDetails!.toJson();
    }
    if (this.birthPlace != null) {
      data['birthPlace'] = this.birthPlace!.toJson();
    }
    return data;
  }
}

class BirthDetails {
  int? dobYear;
  int? dobMonth;
  int? dobDay;
  int? tobHour;
  int? tobMin;
  String? meridiem;

  BirthDetails(
      {this.dobYear,
      this.dobMonth,
      this.dobDay,
      this.tobHour,
      this.tobMin,
      this.meridiem});

  BirthDetails.fromJson(Map<String, dynamic> json) {
    dobYear = json['dobYear'];
    dobMonth = json['dobMonth'];
    dobDay = json['dobDay'];
    tobHour = json['tobHour'];
    tobMin = json['tobMin'];
    meridiem = json['meridiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dobYear'] = this.dobYear;
    data['dobMonth'] = this.dobMonth;
    data['dobDay'] = this.dobDay;
    data['tobHour'] = this.tobHour;
    data['tobMin'] = this.tobMin;
    data['meridiem'] = this.meridiem;
    return data;
  }
}

class BirthPlace {
  String? placeName;
  String? placeId;

  BirthPlace({this.placeName, this.placeId});

  BirthPlace.fromJson(Map<String, dynamic> json) {
    placeName = json['placeName'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeName'] = this.placeName;
    data['placeId'] = this.placeId;
    return data;
  }
}