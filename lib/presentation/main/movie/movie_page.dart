import 'package:flutter/material.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/data/movie.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movie_video/presentation/details_movie/details_movie.dart';
import 'package:movie_video/presentation/main/movie/movie_viewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<MovieModel> foryouItems = List.of(forYouImages);
  List<MovieModel> popularItems = List.of(popularImages);
  List<MovieModel> genresItems = List.of(genresList);
  List<MovieModel> legendaryItems = List.of(legendaryImages);
  PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
  PaginatedMoviesViewModel _viewModel = instance<PaginatedMoviesViewModel>();
  int currentPage =0;

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind(){
    _viewModel.start();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: StreamBuilder<FlowState>(
                  stream: _viewModel.outputState,
                  builder: (context, snapshot) {
                    return snapshot.data?.getScreenWidget(
                        context, _getContentWidget(), (){
                          _viewModel.start();
                    }) ?? Container();
                  },
                ),
              )),
          Positioned(child: Container())
        ],
      ),
    );
  }

  Widget _getContentWidget(){
    return StreamBuilder<PaginatedMoviesViewObject>(
        stream: _viewModel.outputPaginatedMoviesData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.hi,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Stack(
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
                        Positioned(
                            top: AppPadding.p2,
                            right: AppPadding.p2,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.buttonColor,
                              ),
                              height: AppSize.s10,
                              width: AppSize.s10,
                            ))
                      ],
                    ),

                  ],
                ),
              ),
              const SizedBox(height: AppSize.s20,),
              Padding(padding:const EdgeInsets.symmetric(horizontal: AppPadding.p30),
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  decoration: BoxDecoration(
                      color: ColorManager.grey,
                      borderRadius: BorderRadius.circular(AppSize.s20)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: ColorManager.white,),
                      const SizedBox(width:AppSize.s20),
                      Text(AppString.search, style: TextStyle(fontSize: AppSize.s18, color: ColorManager.white),)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20,),
              Padding(padding: EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p5),
                child: Text(AppString.forYou, style: Theme.of(context).textTheme.bodyText1,),
              ),
              _getForYouCardsLayout(foryouItems),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    decoration: BoxDecoration(
                        color: ColorManager.black1,
                        borderRadius: BorderRadius.circular(AppSize.s20)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _getBuildPageIndicatorWidget(),),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.popular,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          AppString.seeAll,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorManager.grey1
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              _getMoviePopulars(snapshot.data?.paginatedMove),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.genres,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          AppString.seeAll,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorManager.grey1
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              _getGenresBuilder(genresItems),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.legendary,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          AppString.seeAll,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorManager.grey1
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              _getMoviePopulars(snapshot.data?.paginatedMove),

            ],
          );
        },
    );
  }

  Widget _getForYouCardsLayout(List<MovieModel> models){
    return SizedBox(
      height: AppHeight.h47(context),
      child: PageView.builder(
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          itemCount: models.length,
          itemBuilder: (context, index) {
            return _getCustomCardThumbnail(
              models[index].imageAsset.toString()
            );
          },
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }

  Widget _getCustomCardThumbnail(String image){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.grey1.withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 3)
          )
        ],
        borderRadius: BorderRadius.circular(AppSize.s20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)
      ),
      margin: const EdgeInsets.only(
          left: AppMargin.m15, right: AppMargin.m15,
          top: AppMargin.m20, bottom: AppMargin.m30),
    );
  }

  Widget _getMoviePopulars(List<Movies>? movies){
    if(movies != null){
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p10),
        height: AppHeight.h27(context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _getCustomCardNormal(
                movies[index]
            );
          },
        ),
      );
    }else{
      return Container();
    }
  }

  Widget _getCustomCardNormal(Movies movies){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MovieDetail(),));
      },
      child: Stack(
        children: [
          Container(
            height: AppSize.s200,
            width: AppSize.s140,
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s18),
              image: DecorationImage(
                image: AssetImage(movies.posterUrl),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
              left: AppSize.s15,
              right: AppSize.s15,
              bottom: AppSize.s0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies.title,
                            maxLines: 1,
                            style: TextStyle(
                              color: ColorManager.white,
                              fontSize: AppSize.s16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: AppSize.s5,),
                          Text(
                            movies.createdDate,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white54,
                                fontSize: AppSize.s14,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          const SizedBox(height: AppSize.s5,),
                        ],
                      )
                  ),
                  const SizedBox(width: AppSize.s20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "8.5",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: AppSize.s14,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                    const SizedBox(width: AppSize.s5,),
                      Icon(Icons.star, size: AppSize.s15,color: ColorManager.yellow,),
                      const SizedBox(height: AppSize.s5,),

                    ],
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  Widget _getGenresBuilder(List<MovieModel> genresList){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m30),
      height: AppHeight.h20(context),
      child: ListView.builder(
          itemCount: genresList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder:(context, index) {
            return Stack(
              children: [
                Container(
                  width: AppSize.s200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    image: DecorationImage(
                        image: AssetImage(
                          genresList[index].imageAsset.toString()
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                  margin: const EdgeInsets.only(
                    left: AppMargin.m10, right: AppMargin.m10,  top: AppMargin.m8, bottom: AppMargin.m30
                  ),
                ),
                Positioned(
                    bottom: AppSize.s0,
                    left: AppSize.s20,
                    child: Text(
                      genresList[index].movieName.toString(),
                      style: TextStyle(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    )
                )
              ],
            );
          },
      ),
    );
  }

  List<Widget> _getBuildPageIndicatorWidget(){
    List<Widget> list = [];
    for(int i =0; i < foryouItems.length; i++){
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
  Widget _indicator(bool isActive){
    return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m5),
        height: AppSize.s8,
        width: AppSize.s8,
        decoration: BoxDecoration(
          color: isActive ? ColorManager.white : ColorManager.grey1,
          borderRadius: BorderRadius.circular(AppSize.s20)
        ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }
}