import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movie_video/presentation/login/login_viewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/route_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/style_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppPreferences _appPreferences = instance<AppPreferences>();

  _bind(){
    _usernameController.addListener(()=> _viewModel.setUserName(_usernameController.text));
    _passwordController.addListener(()=> _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.
        listen((token) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _appPreferences.setIsUserLoggedIn();
            _appPreferences.setToken('Bearer '+token);
            resetAllModules();
            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          });
    });
    _viewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot){
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){
            _viewModel.login();
          }) ?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget(){
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(padding:EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Text(AppString.signIn,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: AppSize.s32,color: ColorManager.white
                  ),
                ),
                  const SizedBox(width: AppSize.s1_5,)
                ],
              ),
              ),

              SizedBox(height: AppSize.s23,),
              Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: AppString.username,
                          labelText: AppString.username,
                          errorText: (snapshot.data ?? true) ? null : AppString.usernameError
                        ),
                      );
                    },
                  ),
              ),
            SizedBox(height: AppSize.s28,),
            Padding(
              padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppString.password,
                      labelText: AppString.password,
                      errorText: (snapshot.data ?? true) ? null : AppString.passwordError
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSize.s28,),
            Padding(
              padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputIsAllInputsValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSize.s53,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false) ? (){
                        _viewModel.login();
                      }:null,
                      child: Text(AppString.login),
                      style: ElevatedButton.styleFrom(
                          onSurface: Colors.white,
                        backgroundColor: (snapshot.data ?? false) ? ColorManager.buttonColor : ColorManager.grey1
                      ),
                    ),
                  );
                },
              ),
            ),
              const SizedBox(height: 50,),
              //or continue with
              _getDividerOrWidget(),
              const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getSquareTitleWidget(ImageAssets.facebookLogo),
                    const SizedBox(width: 10,),
                    _getSquareTitleWidget(ImageAssets.googleLogo),
                    const SizedBox(width: 10,),
                    _getSquareTitleWidget(ImageAssets.appleLogo),
                    const SizedBox(width: 10,),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(padding: EdgeInsets.only(
                left: AppPadding.p28,
                right: AppPadding.p28,
                top: AppPadding.p8
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(
                            context, Routes.forgotPasswordRoute);
                      }, child: Text(
                    AppString.forgetPassword,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(
                            context, Routes.registerRoute);
                      }, child: Text(
                    AppString.registerText,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDividerOrWidget(){
      return Padding(
        padding: const EdgeInsets.only(right: AppPadding.p28, left: AppPadding.p28),
        child: Row(
          children: [
            Expanded(child: Divider(thickness: 0.8,color: Colors.grey[700],)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: Text(AppString.or, style: TextStyle(color: ColorManager.white),),
            ),
            Expanded(child: Divider(thickness: 0.8,color: Colors.grey[700],))
          ],
        ),
      );
  }

  Widget _getSquareTitleWidget(String imagePath){
    return Container(
      width: 90,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p28, vertical: AppPadding.p18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorManager.black1
      ),
      child: Image.asset(imagePath, height: AppSize.s25,width: AppSize.s25,),
    );
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}


