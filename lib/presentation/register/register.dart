import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movie_video/presentation/register/register_viewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/route_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();
  TextEditingController _firstNameTextEditingController = TextEditingController();
  TextEditingController _lastNameTextEditingController = TextEditingController();
  TextEditingController _dobTextEditingController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }


  _bind(){
    _viewModel.start();
    _usernameTextEditingController.addListener(() {
      _viewModel.setUserName(_usernameTextEditingController.text);
    });

    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });

    _firstNameTextEditingController.addListener(() {
      _viewModel.setFirstName(_firstNameTextEditingController.text);
    });

    _lastNameTextEditingController.addListener(() {
      _viewModel.setLastName(_lastNameTextEditingController.text);
    });

    _dobTextEditingController.addListener(() {
      _viewModel.setDob(_dobTextEditingController.text);
    });

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
    .listen((isSuccessLoggedIn) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(child: snapshot.data?.getScreenWidget(context, _getContentWidget(), (){
            _viewModel.register();
          }) ?? _getContentWidget(),);
        },
      ),
    );
  }

  Widget _getContentWidget(){
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p30),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(padding:EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ Text(AppString.signup,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: AppSize.s32,color: ColorManager.white
                    ),
                  ),
                    const SizedBox(width: AppSize.s1_5,)
                  ],
                ),
              ),
              const SizedBox(height: AppSize.s23,),
              Padding(padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _usernameTextEditingController,
                      decoration: InputDecoration(
                        hintText: AppString.username,
                        labelText: AppString.username,
                        errorText: snapshot.data
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s28,),
              Padding(padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordTextEditingController,
                      decoration: InputDecoration(
                          hintText: AppString.password,
                          labelText: AppString.password,
                          errorText: snapshot.data
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s28,),
              Padding(padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorFirstName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _firstNameTextEditingController,
                      decoration: InputDecoration(
                          hintText: AppString.firstName,
                          labelText: AppString.firstName,
                          errorText: snapshot.data
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s28,),
              Padding(padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorLastName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _lastNameTextEditingController,
                      decoration: InputDecoration(
                          hintText: AppString.lastName,
                          labelText: AppString.lastName,
                          errorText: snapshot.data
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s28,),
              Padding(padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool?>(
                  stream: _viewModel.outputIsDob,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _dobTextEditingController,
                      decoration: InputDecoration(
                          hintText: AppString.dob,
                          labelText: AppString.dob,
                          errorText: (snapshot.data ?? true) ? null : AppString.dobError
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s28,),
              Padding(
                padding: EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputsValid,
                  builder: (context, snapshot){
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s53,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false) ?  (){
                            _viewModel.register();
                          }: null ,
                          child: Text(AppString.register),
                          style:  ElevatedButton.styleFrom(
                              onSurface: Colors.white,
                              backgroundColor: (snapshot.data ?? false) ? ColorManager.buttonColor : ColorManager.grey1
                          ),
                      ),
                    );
                  },
                ),),
              Padding(padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                  top: AppPadding.p8
              ),
                child: TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppString.haveAccount,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

