import 'package:flutter/material.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/data/movie.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movie_video/presentation/main/comment/comment_viewmodel.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

import '../../../domain/model/model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<MovieModel> _popularItems = List.of(popularImages);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentTextEditingController = TextEditingController();
  final CommentViewModel _viewModel = instance<CommentViewModel>();
  _bind(){
    _commentTextEditingController.addListener(
            () => _viewModel.setCommentContent(_commentTextEditingController.text));
    _viewModel.setMovieIdPath("66ffa352b21e0d2bd6420a8a");
    _viewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: AppBottom.bottom(context),
          left: AppPadding.p20,
          right: AppPadding.p20
        ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: AppSize.s50,
                width: AppSize.s50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  image: DecorationImage(
                      image:AssetImage(ImageAssets.userImage),
                      fit: BoxFit.cover
                  ),
                ),

              ),
              _getBackToScreenButton()
            ],
          ),
           Expanded(child: StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getScreenWidget(
                    context, _getContentWidget(), (){

                }) ?? Container();
              },
            )),

          _getCommentInput()
        ],
      ),
    );
  }

  Widget _getContentWidget(){
    return StreamBuilder<CommentsViewObject>(
        stream: _viewModel.outputCommentsData,
        builder: (context, snapshot) {
          return _getBuildCommentCard(snapshot.data?.comments);
        },
    );
  }

  Widget _getBuildCommentCard(List<Comment>? comments){
    if(comments != null) {
      return Container(
        height: AppSize.s160,
        child: ListView.builder(
          itemCount: comments.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20),
                  color: ColorManager.grey
              ),
              margin: const EdgeInsets.only(top: AppMargin.m15),
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p10, horizontal: AppPadding.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: AppSize.s50,
                            width: AppSize.s50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(popularImages[0]
                                        .comments![0]['imageUrl']
                                        .toString(),)
                                )

                            ),
                          ),
                          const SizedBox(width: AppSize.s10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comments[index].username,
                                style: TextStyle(color: ColorManager.white,
                                    fontWeight: FontWeightManager.bold),
                              ),
                              const SizedBox(height: AppSize.s5,),
                              Text(comments[index].created,
                                style: TextStyle(color: ColorManager.grey1),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_popularItems[0].comments![0]['rating'],
                            style: TextStyle(color: ColorManager.white,
                                fontWeight: FontWeightManager.bold),
                          ),
                          const SizedBox(width: 4,),
                          Icon(Icons.star, size: AppSize.s12,
                            color: ColorManager.yellow,)
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p10),
                    child: Text(
                      comments[index].content,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: ColorManager.white),
                    ),
                  )

                ],
              ),
            );
          },),
      );
    }else{
      return Container();
    }
  }

  Widget _getCommentInput(){
    return Row(
      children: [
        Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.emoji_emotions,)
                  ),
                  Form(
                    key: _formKey,
                    child: Expanded(child: TextFormField(
                      controller: _commentTextEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(color: ColorManager.black),
                      decoration: InputDecoration(
                        hintText: AppString.typeSomething,
                        hintStyle: TextStyle(color: ColorManager.black),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none
                      ),
                    )),
                  )
                ],
              ),
            )
        ),
        MaterialButton(
          onPressed: (){
            _viewModel.comment();
            _commentTextEditingController.clear();
          },
          minWidth: 0,
          color: Colors.lightGreen,
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
          child: Icon(Icons.send, color: Colors.white, size: 28,),
          shape: CircleBorder(),
        )
      ],
    );
  }

  Widget _getBackToScreenButton(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s15),
        border: Border.all(color: ColorManager.grey,width: AppSize.s1_5)
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: ColorManager.buttonColor,
          size: AppSize.s20,
        ),
      onPressed: (){
          Navigator.of(context).pop();
      },
      ),
    );
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}