import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
              AppString.changeLanguage,
              style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: (){
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppString.changeLanguage,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: (){
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppString.contractUs,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: (){
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppString.inviteYourFriends,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: (){
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppString.logout,
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: (){
            _logout();
          },
        ),
      ],
    );
  }

  void _changeLanguage(){

  }

  void _contactUs(){

  }

  void _inviteFriends(){

  }

  void _logout(){

  }
}