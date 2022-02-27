import 'dart:async';

import 'package:astro/bloc/base/bloc_builder.dart';
import 'package:astro/bloc/controller/my_profile_controller.dart';
import 'package:astro/bloc/event/profile_event_controller.dart';
import 'package:astro/models/profile/add_relative_model.dart';
import 'package:astro/models/profile/location_model.dart';
import 'package:astro/models/profile/relative_list_model.dart';
import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:astro/utils/app_theme.dart';
import 'package:astro/widgets/common_textfield.dart';
import 'package:flutter/material.dart';

class NewProfile extends StatefulWidget
{
  final MyProfileController _profileController;
  final Function onPressedBackButton;
  NewProfile(this.onPressedBackButton,this._profileController);
  @override
  NewProfileState createState() => NewProfileState();
}

class NewProfileState extends State<NewProfile>
{
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _monthController;
  late TextEditingController _yearController;
  late TextEditingController _hourController;
  late TextEditingController _minuteController;
  late TextEditingController _placeController;
  List<String> _timePeriodList = ["AM", "PM"];
  List<String> gender =['MALE','FEMALE','OTHER'];
  List<String> relation =['Mother','Father','Brother','Sister','Spouse'];
   String? selectedRelation;
  late String selectedGender;
  late String _selectedTimePeriod;
  Timer? timer; 
  LocationList? _locationList;
  late String placeId;


  @override
  void initState() {
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    _monthController = TextEditingController();
    _yearController = TextEditingController();
    _hourController = TextEditingController();
    _minuteController = TextEditingController();
    _placeController = TextEditingController();
    _selectedTimePeriod = _timePeriodList[0];
    selectedRelation = relation[0];
    selectedGender = gender[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _bodyOfPage();
  }

  Widget _bodyOfPage()
  {
    return Column(
      children: [
        Row(
          children:[
            IconButton(
              onPressed: (){
                widget.onPressedBackButton();
              }, 
              icon: Icon(Icons.arrow_back_ios),
            ),
            SizedBox(width: 10),
            Text(AppStrings.addNewProfileText,style: AppTheme.normal14Black),
          ]
        ),
        SizedBox(height: 10),
        ///Name TextField
        _nameTextField(),
        ///Date Of Birth
        _dobTextField(),
        /// Time of birth
        _timeOfBirthTextField(),
        /// Place of birth
        _placeOfBirthTextField(),
        /// Gender , Relation
        _genderAndRelation(),
        //Save Button
        _saveButton()
      ],
    );
  }

  Widget _nameTextField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputTitle(AppStrings.name),
          CustomTextFieldNew(
            controller: _nameController),
        ],
      ),
    );
  }

  Widget _dobTextField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputTitle(AppStrings.dateOfBirth),
          //Day
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Expanded(
                  child: CustomTextFieldNew(
                    labelText: "DD",
                    maxLength: 2,
                    controller: _dateController),
                ),
          const SizedBox(width: 10),
          //Month
          Expanded(
            child:CustomTextFieldNew(
                labelText: "MM",
                maxLength: 2,
                controller: _monthController),
          ),
          const SizedBox(width: 10),
          //Year
          Expanded(
            child:CustomTextFieldNew(
              labelText:"YYYY",
                  maxLength: 4,
                  controller: _yearController),
          ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _timeOfBirthTextField()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputTitle(AppStrings.timeOfBirth),
          //Hour
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Expanded(
                  child: CustomTextFieldNew(
                    labelText: "HH",
                    maxLength: 2,
                    controller: _hourController),
                ),
          const SizedBox(width: 10),
          //Minute
          Expanded(
            child:CustomTextFieldNew(
              labelText: "MM",
                  maxLength: 2,
                  controller: _minuteController),
          ),
          const SizedBox(width: 10),
          // AM/PM
          Expanded(
            child:Row(
              children: [
                //AM
                Expanded(
            child:_timePeriod(_timePeriodList[0])),
                Expanded(
            child:_timePeriod(_timePeriodList[1])),
              ],
            ),
          ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _timePeriod(String period)
  {
    return GestureDetector(
      onTap: (){
        if(period!=_selectedTimePeriod)
        setState(() {
          _selectedTimePeriod=period;
        });
      },
      child: Container(
        height: 43,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black.withOpacity(0.1)),
                      color: _selectedTimePeriod == period?AppColors.blue:AppColors.white,
                      borderRadius: BorderRadius.circular(3)
                    ),
                    alignment: Alignment.center,
                    child: Text(period,style: _selectedTimePeriod == period? AppTheme.normal14White:AppTheme.normal14Black),
      ),
    );
  }

  Widget _placeOfBirthTextField()
  {
    return BlocBuilder(
      stream: widget._profileController.locationState,
      defaultView: _placeOfBirthField(),
      onSuccess: (context,response){
        if(response.event is AddRelativeEvent)
        {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Profile Added"),
          ));
          widget.onPressedBackButton();
        }
        else
        _locationList = response.data;
        setState(() {});
      },
    );
  }

  

  Widget _placeOfBirthField()
  {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom:1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _inputTitle(AppStrings.placeOfBirth),
                CustomTextFieldNew(
                  onChanged: (value){
                    if (_placeController.text.isEmpty) {
                    } else {
                      if(timer != null){
                        timer?.cancel();
                        timer = null;    
                      }
                      timer = Timer(Duration(seconds: 2), (){
                        widget._profileController.emitEvent(SearchLocationEvent(_placeController.text.trim()));
                      });
                    }
                  },
                  controller: _placeController),
              ],
            ),
        ),
        if(_locationList?.locations!=null && _placeController.text.trim().isNotEmpty)
        ListView.builder(
          shrinkWrap: true,
          itemCount: _locationList?.locations.length??0,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                _placeController.text = _locationList?.locations[index].placeName??'';
                _locationList = null;
                placeId =  _locationList?.locations[index].placeId??'';
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  border:Border.all(),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(_locationList?.locations[index].placeName??'')),
            );
          }
        )
      ],
    );
  }

  Widget _genderAndRelation()
  {
    return Row(
      children: [
        Expanded(child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            _inputTitle(AppStrings.gender),
            _selectGender()
          ]
        )),
        const SizedBox(width: 15),
        Expanded(child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            _inputTitle(AppStrings.relation),
            _selectRelation()
          ])),
      ],
    );
  }

  Widget _selectGender() {
    return Container(
      height: 45,
      alignment:Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black.withOpacity(0.2))
      ),
      padding: const EdgeInsets.only(left: 5,right:5),
      child: DropdownButton<String>(
        isExpanded: true,
        isDense: true,
        underline: const SizedBox(),
        value: selectedGender,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 1,
        style: const TextStyle(color: AppColors.black),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue!;
          });
        },
        items: gender.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _selectRelation() {
    return Container(
      height: 45,
      alignment:Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black.withOpacity(0.2))
      ),
      padding: const EdgeInsets.only(left: 5,right:5),
      child: DropdownButton<String>(
        isExpanded: true,
        isDense: true,
        underline: const SizedBox(),
        value: selectedRelation,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 1,
        style: const TextStyle(color: AppColors.black),
        onChanged: (String? newValue) {
          setState(() {
            selectedRelation = newValue!;
          });
        },
        items: relation.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _inputTitle(String title)
  {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Text(
        title  
      ),
    );
  }
  
  Widget _saveButton()
  {
    return GestureDetector(
      onTap: (){
        List<String> name = _nameController.text.split(" ");
        if(name.length ==1)
        name[1] = '';
        AddRelativeModel model = AddRelativeModel(
          name[0], 
          name[1], 
          relation.indexWhere((element) => element==selectedRelation), 
          selectedGender, 
          BirthPlace(
            placeId: placeId,
            placeName: _placeController.text.trim(),
          ),
          BirthDetails(
            dobDay:int.parse(_dateController.text),
            dobMonth:int.parse(_monthController.text),
            dobYear:int.parse(_yearController.text),
            tobHour: int.parse(_hourController.text),
            tobMin: int.parse(_minuteController.text),
            meridiem: _selectedTimePeriod
          )
        );
        widget._profileController.emitEvent(AddRelativeEvent(
          model
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(5)
        ),
        child: const Text(AppStrings.saveChanges),
      ),
    );
  }
}