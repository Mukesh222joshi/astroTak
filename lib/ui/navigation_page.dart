import 'package:astro/ui/ask_question.dart';
import 'package:astro/ui/home_page.dart';
import 'package:astro/ui/talk_to_astrologer.dart';
import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_images.dart';
import 'package:astro/utils/app_routes.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedNavIndex = 0;
  late List<Widget> _tabPages;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _tabPages = [
      HomePage(),
      TalkToAstrologerPage(),
      AskQuestion(),
      HomePage(),
      HomePage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:40),
        child: FloatingActionButton(
          backgroundColor: AppColors.orange,
          child: Icon(Icons.format_list_numbered_sharp,color: AppColors.white),
          onPressed: (){
            
          },
        ),
      ),
      appBar: _appBar(),
      bottomNavigationBar: _bottomNav(),
      body: getView(),
    );
  }

  PreferredSizeWidget _appBar()
  {
    return AppBar(
      backgroundColor: AppColors.white,elevation: 0,
      leading: Image.asset(AppImages.hamburger),
      title: Image.asset(AppImages.logo,height: 40,width: 50),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: GestureDetector(
            onTap: ()=>Navigator.of(context).pushNamed(AppRoutes.profile),
            child: Image.asset(AppImages.profile,height: 30,width: 30)),
        )
      ],
    );
  }

  // bottom navigation
  Widget _bottomNav() {
    return BottomNavigationBar(
      backgroundColor: AppColors.white,
      currentIndex: _selectedNavIndex,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle:const TextStyle(fontSize: 14,color: AppColors.white),
      unselectedLabelStyle:const TextStyle(fontSize: 14,color: AppColors.white),
      showSelectedLabels: true,showUnselectedLabels: true,
      onTap: (index) async {
          setState(() {
            _selectedNavIndex = index;
          });
      },
      items: [
        _bottomNavItem(
          AppImages.homeIcon,
          AppStrings.home,
        ),
        _bottomNavItem(
          AppImages.talkIcon,
          AppStrings.talkToAstrologer,
        ),
        _bottomNavItem(
          AppImages.askQuestion,
          AppStrings.askQuestion
        ),
        _bottomNavItem(
          AppImages.reports,
          AppStrings.reports,
        ),
        _bottomNavItem(
          AppImages.talkIcon,
          AppStrings.chatWithAstrologer,
        ),
      ],
    );
  }

  // bottom navigation bar item
  BottomNavigationBarItem _bottomNavItem(
    String icon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        width: 24,
        height: 24,
      ),
      //label: label,
      title: Text(label,overflow: TextOverflow.visible,style: const TextStyle(fontSize: 8,color: AppColors.black,))
    );
  }

  /// returns home screen view on the basis of [_selectedNavIndex] and [BlocState]
  Widget getView() {
    return _tabPages[_selectedNavIndex];
    // return BlocBuilder(
    //   stream: _homeController.state,
    //   loadingView: (context, response) => _loadingView(response),
    //   failedView: (context, response) => _failedView(response),
    //   noInternetView: (context, response) => _noInternetView(response),
    //   successView: (context, response) => _successView(response),
    //   onSuccess: _onSuccess,
    //   onFailed: _onFailed,
    //   onNoInternet: _onFailed,
    // );
  }

  // /// loading view for home
  // Widget _loadingView(BlocResponse response) {
  //   return _successView(response);
  // }

  // /// failed view for home
  // Widget _failedView(BlocResponse response) {
  //   return _successView(response);
  // }

  // /// no-internet view for home
  // Widget _noInternetView(BlocResponse response) {
  //   if (response.event is OpenWSConnection) {
  //     return NoInternetView(
  //       onRetry: () {
  //         _homeController.emitEvent(response.event);
  //       },
  //     );
  //   }
  //   return _successView(response);
  // }

  // /// success view for home
  // Widget _successView(BlocResponse response) {
  //   return _tabPages[_selectedNavIndex];
  // }

  // /// onSuccess callback for home state change
  // void _onSuccess(BuildContext context, BlocResponse response) {
  // }

  // // onFailed callback for home state change
  // void _onFailed(BuildContext context, BlocResponse response) async {
  // }
}
