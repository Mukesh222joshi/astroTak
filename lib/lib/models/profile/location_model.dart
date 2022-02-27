class LocationList
{
  List<LocationModel> locations=[];
  LocationList(this.locations);

  LocationList.fromJson(dynamic json)
  {
    for(int index=0;index<json.length;index++)
    {
      locations.add(LocationModel.fromJson(json[index]));
    }
  }
}

class LocationModel {
  String? placeName;
  String? placeId;

  LocationModel({this.placeName, this.placeId});

  LocationModel.fromJson(Map<String, dynamic> json) {
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