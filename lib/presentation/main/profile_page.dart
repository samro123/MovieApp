import 'package:flutter/material.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              const SizedBox(height: AppSize.s100,),
              Stack(
                children: [
                  SizedBox(
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
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: AppString.lastName,
                      labelText: AppString.lastName,
                    ),
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: AppString.firstName,
                      labelText: AppString.firstName,
                    ),
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: AppString.lastName,
                      labelText: AppString.lastName,
                    ),
                  ),
                  const SizedBox(height: AppSize.s10,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: AppString.lastName,
                      labelText: AppString.lastName,
                    ),
                  ),
                  const SizedBox(height: AppSize.s20,),
          SizedBox(
            width: double.infinity,
            height: AppSize.s53,
            child: ElevatedButton(
              onPressed: (){},
              child: Text("Edit Profile"),
            ),
          )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
