import 'package:flutter/material.dart';
import 'package:movie_video/data/movie.dart';
import 'package:movie_video/presentation/main/comment/comment_page.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/font_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';
import 'package:readmore/readmore.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  List<MovieModel> popularItems = List.of(popularImages);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppWidth.w100(context),
                  height: AppHeight.h50(context),
                  foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                      ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                          image: AssetImage(
                              popularItems[0].imageAsset.toString()),
                      fit: BoxFit.cover
                      ),
                  )
                  
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.dune,
                                style: TextStyle(
                                  color: ColorManager.white,fontSize: AppSize.s30, fontWeight: FontWeight.w600
                                ),
                              ),
                              const SizedBox(height: AppSize.s10,),
                              const Text("2021, Denis Villenueve" , style: TextStyle(
                                color: Colors.white38,
                                fontWeight: FontWeight.w600
                              ),)
                            ],
                          ),
                          Row(
                            children: [
                              Text("8.2",
                                style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppSize.s15
                                ),),
                              const SizedBox(width: AppSize.s10,),
                              Icon(Icons.star, color: ColorManager.yellow,size: AppSize.s15,)

                            ],
                          )
                        ],
                      ),
                      Row(
                       children: [
                         _getBuildTag("Epic"),
                         const SizedBox(width: 10,),
                         _getBuildTag("Fantasy"),
                         const SizedBox(width: 10,),
                         _getBuildTag("Drama"),
                         const SizedBox(width: 10,)
                     ],
                     ),
                      const SizedBox(height: AppSize.s10,),
                       Padding(
                          padding: EdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p10),
                          child: ReadMoreText(
                            AppString.onBoardingSubTitle1,
                            trimLines: 3,
                            trimMode: TrimMode.Line,
                            moreStyle: TextStyle(color: ColorManager.grey),
                            lessStyle: TextStyle(color: ColorManager.grey),
                            style: TextStyle(
                              color: Colors.white70,
                              height: AppSize.s1_5,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                      ),
                      _getCastAndCrewWidget(popularItems[0].cast!),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p10
                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppString.trailer, style: TextStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s20,
                                fontWeight: FontWeightManager.regular),),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: AppMargin.m20),
                                  height: AppSize.s180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppSize.s18),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/data/trailer.jpeg"
                                      ),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                Container(
                                  padding:  EdgeInsets.all(AppPadding.p8),
                                  decoration:  BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.white
                                  ),
                                  child: Icon(
                                    Icons.play_arrow, color: ColorManager.grey1,
                                    size: AppSize.s20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSize.s30,),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p10, vertical: AppPadding.p10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppString.comments,
                                  style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeightManager.regular,
                                    fontSize: FontSize.s20
                                  ),),
                                Text(AppString.seeAll,
                                  style: TextStyle(
                                      color: ColorManager.grey,
                                      fontWeight: FontWeightManager.regular,
                                      fontSize: FontSize.s18
                                  ),)
                              ],
                            ),
                            _getBuildCommentCard(),
                            SizedBox(height: AppHeight.h15(context),)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: AppSize.s60,
              right: AppSize.s20,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70
                ),
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: ColorManager.grey,size: AppSize.s20,),
                ),
              )
          ),
          Positioned(
              bottom: AppSize.s30,
              left: AppSize.s30,
              right: AppSize.s30,
              child: SizedBox(
                height: AppSize.s40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text(AppString.watching),
                ),
              ))
        ],
      ),
    );
  }

  Widget _getBuildCommentCard(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m20),
      height: AppSize.s160,
      child: ListView.builder(
          itemCount: popularItems[0].comments!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: ColorManager.primary,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p16, bottom: AppPadding.p10),
                        child: Container(
                          height: AppHeight.h85(context),
                          child: CommentPage(),
                        ),
                      );
                    },
                );
              },
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20),
                  color: ColorManager.grey
                ),
                margin: const EdgeInsets.only(right: AppMargin.m15),
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
                                Text(popularItems[0].comments![index]['name'],
                                  style: TextStyle(color: ColorManager.white, fontWeight: FontWeightManager.bold),
                                ),
                                const SizedBox(height: AppSize.s5,),
                                Text(popularItems[0].comments![index]['date'],
                                  style: TextStyle(color: ColorManager.grey1),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(popularItems[0].comments![index]['rating'],
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
                        popularItems[0].comments![index]['comment'],
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        style:  TextStyle(color: ColorManager.white),
                      ),
                    )

                  ],
                ),
              ),
            );
          },),
    );
  }

  Widget _getCastAndCrewWidget(List casts){
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppString.cast, style: TextStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.regular),),
              const SizedBox(height: AppSize.s20,),
              SizedBox(
                height: AppSize.s160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: casts.length,
                  itemBuilder: (context, index) {
                      return _getCastCard(casts[index]);
                    },
                ),
              )
            ],
          ),
      );
  }

  Widget _getCastCard(final Map cast){
    return Container(
      margin: const EdgeInsets.only(right: AppMargin.m16),
      width: AppSize.s70,
      child: Column(
        children: [
          Container(
            height: AppSize.s100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s16),
              image: DecorationImage(
                image: AssetImage(cast['image']),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: AppSize.s10,),
          Text(
            cast['name'],
            maxLines: 2,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeightManager.regular
            ),
          )
        ],
      ),
    );
  }

  Widget _getBuildTag(String title){
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m20),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p20),
      decoration: BoxDecoration(
        color: ColorManager.grey,
        borderRadius: BorderRadius.circular(AppSize.s18)
      ),
      child: Text(
        title,
        style:const TextStyle(
          color: Colors.white30,
          fontSize: AppSize.s16
        ),
      ),
    );
  }
}
