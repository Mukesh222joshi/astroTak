import 'package:astro/bloc/base/bloc_builder.dart';
import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/controller/my_profile_controller.dart';
import 'package:astro/bloc/event/profile_event_controller.dart';
import 'package:astro/models/profile/relative_list_model.dart';
import 'package:astro/ui/add_new_profile.dart';
import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:astro/utils/app_theme.dart';
import 'package:flutter/material.dart';

class FriendsAndFamilyProfile extends StatefulWidget
{
  final MyProfileController _profileController;
  FriendsAndFamilyProfile(this._profileController);
  @override
  FriendsAndFamilyProfileState createState() => FriendsAndFamilyProfileState();
  
}

class FriendsAndFamilyProfileState extends State<FriendsAndFamilyProfile>
{
  bool showNewProfile =false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      stream: widget._profileController.state,
      loadingView: _loadingView,
      defaultView: _bodyOfPage(),
      onSuccess: (context,response){
        print("success in friends");
      },
    );
  }

  Widget _loadingView(BuildContext context,BlocResponse<dynamic> response)
  {
    if(response.event == RelativeListEvent())
    return Center(child: CircularProgressIndicator());
    else return _bodyOfPage();
  }


  Widget _bodyOfPage()
  {
    if(showNewProfile)
    return NewProfile(
      (){
        showNewProfile =false;
        setState(() {});
      },
      widget._profileController
    );
    return Column(
      children: [
        // Balance
        Container(
          margin: EdgeInsets.symmetric(vertical:15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.blue.withOpacity(0.2)
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,color: AppColors.blue),
              SizedBox(width: 5),
              Text(AppStrings.walletBalance+' :'+AppStrings.rupeesSign + '0',style:AppTheme.normal14Blue),
              Container(
                margin: EdgeInsets.only(left:10),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal:8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: AppColors.black)
                ),
                child: Text(AppStrings.addMoney,style:AppTheme.normal14Blue.apply(fontSizeFactor: 0.6)),
              )
            ],
          ),
        ),
        _profilHeader(),
        // Profile list
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget._profileController.relativeList?.allRelatives?.length??0,
            itemBuilder: (context,index){
              return _profileTile(widget._profileController.relativeList?.allRelatives![index]);
            }
          ),
        ),

        //Add New Profile
        GestureDetector(
          onTap: (){
            showNewProfile =true;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.orange
            ),
            child:const Text(AppStrings.addNewProfile,style: AppTheme.normal14White,),
          ),
        )
      ],
    );
  }

  Widget _profilHeader()
  {
    return 
    Container(
      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
      margin: EdgeInsets.only(bottom:6),
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.name),
          Text(AppStrings.DOB),
          Text(AppStrings.TOB),
          Text(AppStrings.relation),
          SizedBox(),
          SizedBox(),
        ],
      ),
    );
  }

  Widget _profileTile(AllRelatives? relative)
  {
    return 
    Container(
      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 6),
      margin: EdgeInsets.only(bottom:6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: AppColors.white,
        border: Border.all(color: AppColors.black.withOpacity(0.1))
      ),
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _data(relative?.firstName??''),
          _data(relative?.dateOfBirth??''),
          SizedBox(width: 5),
          _data(relative?.timeOfBirth??''),
          _data(relative?.relation??''),
          const Icon(Icons.edit,color: AppColors.orange),
          SizedBox(width: 12),
          InkWell(
            onTap:(){
              showAlertDialog(context,relative);
            },
            child: const Icon(Icons.delete,color: AppColors.red)),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context,AllRelatives? relatives) {
  // set up the button
  Widget okButton = Container(
    padding: EdgeInsets.symmetric(horizontal: 30),
    color: AppColors.orange,
    child: TextButton(
      child: Text("Yes",style: TextStyle(color: AppColors.white),),
      onPressed: () { 
        widget._profileController.emitEvent(DeleteRelativeProfileEvent(relatives?.uuid??''));
        Navigator.of(context).pop();
      },
    ),
  );

  Widget noButton = Container(
    padding: EdgeInsets.symmetric(horizontal: 30),
    color: AppColors.orange,
    child: TextButton(
      child: Text("No",style: TextStyle(color: AppColors.white),),
      onPressed: () { 
        Navigator.of(context).pop();
      },
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    actionsPadding: EdgeInsets.symmetric(horizontal: 20),
    content: Text("Do You really want to delete?"),
    actions: [
      okButton,noButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  Widget _data(String text)
  {
    return  Expanded(
      child: Text(text,maxLines: 2,style:AppTheme.normal14Black),
    ); 
  }
  
}