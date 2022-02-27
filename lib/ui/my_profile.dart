import 'package:astro/bloc/controller/my_profile_controller.dart';
import 'package:astro/ui/add_new_profile.dart';
import 'package:astro/ui/friends_and_family_profile.dart';
import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:astro/utils/app_theme.dart';
import 'package:flutter/material.dart';

class MyProile extends StatefulWidget
{
  final MyProfileController profileController;
  MyProile(this.profileController);
  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProile>  with TickerProviderStateMixin 
{
  late TabController tabController;
  int _currentTabIndex =0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
           TabBar(
              onTap: _onTapChanged,
              controller: tabController,
              labelColor: AppColors.orange,
              unselectedLabelColor: AppColors.black,
              indicatorWeight: 0.1,
              tabs: [
                _title(0,AppStrings.basicProfile),
                _title(1,AppStrings.friendsAndFamilyProfile),
              ],
            ),
             Expanded(
               child: DefaultTabController(
                length: 2,
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Center(child: Text("Basic Profile")),
                    //NewProfile()
                    FriendsAndFamilyProfile(widget.profileController)
                  ],
                )
                         ),
             )
        ],
      ),
    );
  }

  Widget _title(int index ,String title)
  {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _currentTabIndex==index?AppColors.orange:AppColors.white,
      ),
      child: Center(
        child: Text(title,style: _currentTabIndex==index?AppTheme.normal14White:AppTheme.normal14Black,)
      ),
    );
  }
  
  void _onTapChanged(int val) {
    if (_currentTabIndex != val) {
      tabController.index = val;
      setState(() => _currentTabIndex = val);
    }
  }
}