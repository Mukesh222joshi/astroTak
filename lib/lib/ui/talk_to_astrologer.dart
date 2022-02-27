import 'package:astro/utils/app_images.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:flutter/material.dart';

class TalkToAstrologerPage extends StatefulWidget {
  @override
  _TalkToAstrologerPageState createState() => _TalkToAstrologerPageState();
}

class _TalkToAstrologerPageState extends State<TalkToAstrologerPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _filterSortOption(),
          SizedBox(height: 8),
          _listOfAstrologer()
        ],
      ),
    );
  }

  Widget _filterSortOption()
  {
    return Row(
      children: [
        Text(AppStrings.talkToAnAstrologer),
        Spacer(),
        //Search option
        _option(AppImages.search,(){

        }),
        _option(AppImages.filter,(){

        }),
        _option(AppImages.sort,(){

        }),
      ],
    );
  }

  Widget _option(String image,Function onTap)
  {
    return Padding(
      padding: const EdgeInsets.only(right:8.0),
      //child: Image.asset(image,height: 20,width: 20),
    );
  }

  Widget _listOfAstrologer()
  {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context,index){
          return SizedBox();
        }, 
        separatorBuilder: (context,index){
          return _astrologerTile();
        }, 
        itemCount: 5
      ),
    );
  }

  Widget _astrologerTile()
  {
    return SizedBox();
  }
}