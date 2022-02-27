import 'package:astro/bloc/base/bloc_builder.dart';
import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/controller/ask_question_controller.dart';
import 'package:astro/bloc/event/ask_questions_event.dart';
import 'package:astro/models/questions_model.dart';
import 'package:astro/utils/app_colors.dart';
import 'package:astro/utils/app_strings.dart';
import 'package:astro/utils/app_theme.dart';
import 'package:flutter/material.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key}) : super(key: key);
  @override
  AskQuestionState createState() => AskQuestionState();
}

class AskQuestionState extends State<AskQuestion> {
  late List<String> options = [''];
  late String dropdownValue='';
  late AskQuestionController _controller;
  late QuestionsListModel questionsListModel;
  QuestionByCategory? questions;

  @override
  void initState() {
    _controller = AskQuestionController();
    _controller.emitEvent(QuestionsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      stream: _controller.state,
      loadingView: _loadingView,
      successView: _bodyOfPage,
      onSuccess: (context,response){
        setState(() {
          options = response.data.questionType;
          dropdownValue = options[0];
          questionsListModel = response.data;
          questions = questionsListModel.qestionByCategory.firstWhere((element) => element.name == dropdownValue);
        });
      },
    );
  }

  Widget _loadingView(BuildContext context,BlocResponse<dynamic> response)
  {
    return Center(child: CircularProgressIndicator());
  }

  Widget _bodyOfPage(BuildContext context,BlocResponse<dynamic> response)
  {
    return Column(
      children: [
        _header(),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 12),
          child:ListView(
            children: [
              _headline(AppStrings.askAQuestion),
              const Text(
                AppStrings.askQuestionMessage,
                style: AppTheme.normal12Black,
              ),
              _headline(AppStrings.chooseCategory),
              _selectType(),
              _textField(),
              _headline(AppStrings.ideasWhatToAsk),
              _ideasWhatToAsk(),
              const Divider(thickness: 2,),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(AppStrings.seekingAccurate),
              ),
              _notes()
            ],
          ),
        )),
        _footer(),
      ],
    );
  }
  

  Widget _selectType() {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right:5,bottom:20),
      child: DropdownButton<String>(
        isExpanded: true,
        isDense: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),                     
        elevation: 8,
        style: const TextStyle(color: AppColors.black),
        underline: Container(
          height: 0.2,
          color: Colors.black,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            questions = questionsListModel.qestionByCategory.firstWhere((element) => element.name == dropdownValue);
          });
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _textField()
  {
    return const TextField(
      decoration: InputDecoration(
        hintText: AppStrings.typeAText,
        border: OutlineInputBorder(
          borderSide : BorderSide(color: AppColors.black),
        )
      ),
      maxLength: 150,maxLines: 4,
    );
  }

  Widget _ideasWhatToAsk()
  {
    if(questions==null)
    SizedBox();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context,index){
        return const Divider(thickness: 2,);
      },
      itemCount: questions?.suggestions?.length??0,
      itemBuilder: (context,index){
        return Row(
          children: [
            Icon(Icons.developer_mode,color: AppColors.orange,),
            SizedBox(width:8),
            Flexible(child: Text("${questions?.suggestions?[index]??''}")),
          ],
        );
      }
    ); 
  }

  Widget _notes()
  {
    return  Container(
      padding: const EdgeInsets.all(8),
      decoration:BoxDecoration(
        color: AppColors.yellow.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          _note(AppStrings.note1),
          _note(AppStrings.note2),
          _note(AppStrings.note3),
          _note(AppStrings.note4),
        ],
      ),
    );
  }

  Widget _note(String text)
  {
    return Text(text,style: AppTheme.medium14White.copyWith(color:AppColors.orange),);
  }

  Widget _headline(String heading) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 8),
      child: Text(
        heading,
        style: AppTheme.medium14Black,
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      color: AppColors.blue,
      child: Row(
        children: [
          const Text(
            AppStrings.walletBalance,
            style: AppTheme.medium14White,
          ),
          const Text(
            ': ' + AppStrings.rupeesSign + ' 0',
            style: AppTheme.medium14White,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(2)),
            child:
                const Text(AppStrings.addMoney, style: AppTheme.normal14Blue),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.blue,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        children: [
          const Text(AppStrings.rupeesSign + '150 ' + '(1 Question on Love)',
              style: AppTheme.normal14White),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(2)),
            child: const Text(AppStrings.askNow, style: AppTheme.normal14Blue),
          ),
        ],
      ),
    );
  }
}
