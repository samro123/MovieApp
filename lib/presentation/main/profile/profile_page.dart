import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movie_video/presentation/main/profile/profile_viewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/font_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImagePicker picker = instance<ImagePicker>();
  ProfileViewModel _viewModel = instance<ProfileViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameTextEditingController = TextEditingController();
  TextEditingController _firstNameTextEditingController = TextEditingController();
  TextEditingController _lastnameTextEditingController = TextEditingController();
  TextEditingController _dobTextEditingController = TextEditingController();
  TextEditingController _cityTextEditingController = TextEditingController();

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

    _firstNameTextEditingController.addListener(() {
      _viewModel.setFirstName(_firstNameTextEditingController.text);
    });

    _lastnameTextEditingController.addListener(() {
      _viewModel.setLastName(_lastnameTextEditingController.text);
    });

    _dobTextEditingController.addListener(() {
      _viewModel.setDob(_dobTextEditingController.text);
    });

    _cityTextEditingController.addListener(() {
      _viewModel.setCity(_cityTextEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
              (){
                _viewModel.updateProfile();
              }) ?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget(){
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          children: [
            const SizedBox(height: AppSize.s100,),
            Stack(
              children: [
                InkWell(
                  onTap: (){
                      _showPicker(context);
                  },
                  child: SizedBox(
                    height: AppSize.s120,
                    width: AppSize.s120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s100),
                      child: Image(
                        image: AssetImage('assets/data/actor_1.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: AppSize.s0,
                    right: AppSize.s0,
                    child: Container(
                      width: AppSize.s32,
                      height: AppSize.s32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s100),
                          color: ColorManager.buttonColor),
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: ColorManager.white,
                          size: AppSize.s20,
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: AppSize.s50,
            ),
            Form(
              key:_formKey,
                child: Column(
                  children: [
                    StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context, snapshot){
                        return TextFormField(
                          controller: _usernameTextEditingController,
                          decoration: InputDecoration(
                            hintText: AppString.username,
                            labelText: AppString.username,
                            errorText: (snapshot.data ?? true) ? null : AppString.usernameError
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.s10,),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsFirstNameValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _firstNameTextEditingController,
                            decoration: InputDecoration(
                              hintText: AppString.firstName,
                              labelText: AppString.firstName,
                              errorText: (snapshot.data ?? true) ? null : AppString.firstNameError
                            ),
                          );
                        },),
                    const SizedBox(height: AppSize.s10,),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsLastNameValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _lastnameTextEditingController,
                            decoration: InputDecoration(
                              hintText: AppString.lastName,
                              labelText: AppString.lastName,
                              errorText: (snapshot.data ?? true) ? null : AppString.lastNameError
                            ),
                          );
                        },),
                    const SizedBox(height: AppSize.s10,),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsDob,
                        builder: (context, snapshot) {
                          return  TextFormField(
                            controller: _dobTextEditingController,
                            decoration: InputDecoration(
                              hintText: AppString.dob,
                              labelText: AppString.dob,
                              errorText: (snapshot.data ?? true) ? null : AppString.dobError
                            ),
                          );
                        },),
                    const SizedBox(height: AppSize.s10,),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsCity,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _cityTextEditingController,
                            decoration: InputDecoration(
                              hintText: AppString.city,
                              labelText: AppString.city,
                              errorText: (snapshot.data ?? true) ? null : AppString.cityError
                            ),
                          );
                        },),
                    const SizedBox(height: AppSize.s20,),
                    StreamBuilder<bool>(
                        stream: _viewModel.outputIsAllInputsValid,
                        builder: (context, snapshot){
                          return SizedBox(
                            width: double.infinity,
                            height: AppSize.s53,
                            child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                              ? () => _viewModel.updateProfile():null,
                              child: Text("Edit Profile"),
                            ),
                          );
                        },
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _showPicker(BuildContext context){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s20),
            topRight: Radius.circular(AppSize.s20)
        )),
        builder: (_){
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: AppSize.s18,
                bottom: AppSize.s18
            ),
            children: [
              Text(
                AppString.pickProfilePicture,
                style: TextStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.medium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s18,),
              Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.s20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //pick from gallery button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.white,
                            shape: const CircleBorder(),
                            fixedSize: Size(AppSize.s60, AppSize.s60)
                        ),
                        onPressed: (){
                          _imageFormGallery();
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(ImageAssets.addImage)
                    ),

                    //take picture from camera button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.white,
                            shape: const CircleBorder(),
                            fixedSize: Size(AppSize.s60, AppSize.s60)
                        ),
                        onPressed: (){
                          _imageFormCamera();
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(ImageAssets.camera))
                  ],
                ),
              ),

            ],
          );
        });
  }
  _imageFormGallery() async{
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? "" ));
  }

  _imageFormCamera() async{
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? "" ));
  }
}
