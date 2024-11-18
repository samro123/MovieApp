import 'package:flutter/material.dart';
import 'package:movie_video/data/movie.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<MovieModel> _popularItems = List.of(popularImages);
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
          Expanded(child: _getBuildCommentCard()),

          _getCommentInput()
        ],
      ),
    );
  }

  Widget _getBuildCommentCard(){
    return Container(
      height: AppSize.s160,
      child: ListView.builder(
        itemCount: _popularItems[0].comments!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s20),
                color: ColorManager.grey
            ),
            margin: const EdgeInsets.only(top: AppMargin.m15),
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p20),
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
                                  image: AssetImage(popularImages[0].comments![index]['imageUrl'].toString(),)
                              )

                          ),
                        ),
                        const SizedBox(width: AppSize.s10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_popularItems[0].comments![index]['name'],
                              style: TextStyle(color: ColorManager.white, fontWeight: FontWeightManager.bold),
                            ),
                            const SizedBox(height: AppSize.s5,),
                            Text(_popularItems[0].comments![index]['date'],
                              style: TextStyle(color: ColorManager.grey1),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_popularItems[0].comments![index]['rating'],
                          style: TextStyle(color: ColorManager.white, fontWeight: FontWeightManager.bold),
                        ),
                        const SizedBox(width: 4,),
                        Icon(Icons.star,size: AppSize.s12,color: ColorManager.yellow,)
                      ],
                    )
                  ],
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: Text(
                    _popularItems[0].comments![index]['comment'],
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.clip,
                    style:  TextStyle(color: ColorManager.white),
                  ),
                )

              ],
            ),
          );
        },),
    );
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
                  Expanded(child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: AppString.typeSomething,
                      hintStyle: TextStyle(color: ColorManager.black),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none
                    ),
                  ))
                ],
              ),
            )
        ),
        MaterialButton(
          onPressed: (){},
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
}