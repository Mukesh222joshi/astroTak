import 'package:astro/bloc/base/bloc_builder.dart';
import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/controller/my_profile_controller.dart';
import 'package:astro/bloc/event/profile_event_controller.dart';
import 'package:astro/ui/my_profile.dart';
import 'package:astro/ui/order_history.dart';
import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_images.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:astro/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController tabController;
  int _currentTabIndex = 0;
  late MyProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = MyProfileController();
    _profileController.emitEvent(RelativeListEvent());
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      stream: _profileController.state,
      defaultView: _bodyOfPage(),
      onSuccess: (context,response){
        print("success in ui");
        if(response.event is DeleteRelativeProfileEvent)
        {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Profile Deleted"),
          ));
          _profileController.emitEvent(RelativeListEvent());
        }
        // else if(response.event is AddRelativeEvent)
        // {
        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text("Profile Added"),
        //   ));
        //   _profileController.emitEvent(RelativeListEvent());
        // }
        else
        setState(() {});
      },
    );
  }

  Widget _bodyOfPage() {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.orange),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Image.asset(AppImages.logo, height: 40, width: 50),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.orange)),
              child:
                  const Text(AppStrings.logout, style: AppTheme.normal12Orange),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(35),
            child: TabBar(
              onTap: _onTapChanged,
              controller: tabController,
              labelColor: AppColors.orange,
              unselectedLabelColor: AppColors.black,
              indicatorColor: AppColors.orange,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
              tabs: [
                Container(
                  height: 30,
                  child: Center(
                      child: Text(
                    AppStrings.myProfile,
                  )),
                ),
                Container(
                  height: 30,
                  child: Center(
                      child: Text(
                    AppStrings.orderHistory,
                  )),
                ),
              ],
            ),
          ),
        ),
        body: DefaultTabController(
            length: 2,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [MyProile(_profileController), OrderHistory()],
            )));
  }

  void _onTapChanged(int val) {
    if (_currentTabIndex != val) {
      tabController.index = val;
      setState(() => _currentTabIndex = val);
    }
  }
}
