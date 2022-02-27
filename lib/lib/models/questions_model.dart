class QuestionsListModel
{
  List<QuestionByCategory> qestionByCategory=[];
  List<String> questionType = [];
  QuestionsListModel(this.qestionByCategory,this.questionType);

  QuestionsListModel.fromJson(Map<String, dynamic> json)
  {
    for(int index=0;index<json['data'].length;index++)
    {
      qestionByCategory.add(QuestionByCategory.fromJson(json['data'][index]));
      questionType.add(json['data'][index]['name']);
    }
  }
}

class QuestionByCategory {
  int? id;
  String? name;
  String? description;
  double? price;
  List<String>? suggestions;

  QuestionByCategory({this.id, this.name, this.description, this.price, this.suggestions});

  QuestionByCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??'';
    description = json['description']??'';
    price = json['price']??0.0;
    suggestions = json['suggestions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['suggestions'] = this.suggestions;
    return data;
  }
}