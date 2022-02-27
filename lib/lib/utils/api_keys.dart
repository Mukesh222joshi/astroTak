class ApiKeys
{
  static String baseUrl = "https://staging-api.astrotak.com/api/";
  static const String contentType = 'Content-Type';
  static const String applicationJSON = 'application/json';
  static const String authorization = 'Authorization';

  static const String birthDetails = "birthDetails";
  static const String dobDay = "dobDay";
  static const String dobMonth = "dobMonth";
  static const String dobYear = "dobYear";
  static const String tobHour = "tobHour";
  static const String tobMin = "tobMin";
  static const String meridiem = "meridiem";
  static const String birthPlace = "birthPlace";
  static const String placeName = "placeName";
  static const String placeId = "placeId";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String relationId = "relationId";
  static const String gender = "gender";
  static const String inputPlace = "inputPlace";
  static const String accessToken = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4ODA5NzY1MTkxIiwiUm9sZXMiOltdLCJleHAiOjE2NzY0NjE0NzEsImlhdCI6MTY0NDkyNTQ3MX0.EVAhZLNeuKd7e7BstsGW5lYEtggbSfLD_aKqGFLpidgL7UHZTBues0MUQR8sqMD1267V4Y_VheBHpxwKWKA3lQ";
}

class ApiEndPoints {
  static const String questions = '/question/category/all';
  static const String relativeList = '/relative/all';
  static const String addRelative = '/relative';
  static const String location = '/location/place';
  static const String deleteRelatieProfile = '/relative/delete/';
}