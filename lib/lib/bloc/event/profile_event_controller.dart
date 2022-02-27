import 'package:astro/bloc/base/bloc_event.dart';
import 'package:astro/models/profile/add_relative_model.dart';

class ProfileEvents implements BlocEvent {}

class RelativeListEvent implements ProfileEvents {
  const RelativeListEvent();
}

class AddRelativeEvent implements ProfileEvents {
  final AddRelativeModel model;
  const AddRelativeEvent(this.model);
}

class SearchLocationEvent implements ProfileEvents {
  final String text;
  const SearchLocationEvent(this.text);
}

class DeleteRelativeProfileEvent implements ProfileEvents {
  final String uuid;
  const DeleteRelativeProfileEvent(this.uuid);
}