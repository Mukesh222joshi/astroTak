import 'package:astro/models/profile/relative_list_model.dart';
import 'package:astro/utils/api_keys.dart';

class AddRelativeModel
{
  String? firstName;
  String? lastName;
  int? relationId;
  String? gender;
  BirthPlace? birthPlace;
  BirthDetails? birthDetails;

  AddRelativeModel(this.firstName,this.lastName,this.relationId,this.gender,this.birthPlace,this.birthDetails);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[ApiKeys.firstName] = this.firstName;
    data[ApiKeys.lastName] = this.lastName;
    data[ApiKeys.relationId] = this.relationId;
    data[ApiKeys.gender] = this.gender;
    data[ApiKeys.birthPlace] = this.birthPlace;
    data[ApiKeys.birthDetails] = this.birthDetails;
    return data;
  }
}