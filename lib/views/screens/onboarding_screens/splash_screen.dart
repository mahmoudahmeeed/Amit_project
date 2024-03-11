import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/controller/utils/enum_active_routes_observer.dart';
import 'package:job_finder/controller/utils/shared_helper.dart';
import 'package:job_finder/controller/utils/sql_helper/sql_helper.dart';
import 'package:job_finder/model/signup_models/user_model.dart';
import 'package:job_finder/views/screens/create_account_screens/setup_work_type_screen.dart';

import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../../controller/utils/app_images.dart';
import '../create_account_screens/work_preferred_location_screen.dart';
import '../home_screen_and_search/main_screen.dart';
import 'onboarding_screen.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    SqlHelper.tableHasData(table: UserTableColumnTitles.usersTable)
        .then((hasUser) async {
      if (hasUser) {
        var userMap = {
          ...(await SqlHelper.getAllRows(
                  table: UserTableColumnTitles.usersTable))
              .first
        };
        // false = 0, true = 1;
        if (userMap[UserTableColumnTitles.login] == 1) {
          userMap[UserTableColumnTitles.login] = true;
          if (userMap[UserTableColumnTitles.careerType] != null) {
            userMap[UserTableColumnTitles.careerType] =
                jsonDecode(userMap[UserTableColumnTitles.careerType])
                    as List<dynamic>;
          }
          if (userMap[UserTableColumnTitles.workLocations] != null) {
            userMap[UserTableColumnTitles.workLocations] =
                jsonDecode(userMap[UserTableColumnTitles.workLocations])
                    as List<dynamic>;
          }
          if (context.mounted) {
            BlocProvider.of<JobDataCubit>(context).getRecentJobs();

            BlocProvider.of<SignupLoginScreenCubit>(context).userModel =
                UserModel.fromMap(userMap);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false);
          }
        } else {
          userMap[UserTableColumnTitles.login] = false;
          if (context.mounted) {
            String activeRoute = SharedHelper.getData(
                key: SharedHelper.activeRouteKey, valueDataType: 'String');

            if (activeRoute == ActiveRoute.careerType.route) {
              BlocProvider.of<SignupLoginScreenCubit>(context).userModel =
                  UserModel.fromMap(userMap);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CareerTypeScreen()),
                  (route) => false);
            } else if (activeRoute == ActiveRoute.preferedLocations.route) {
              userMap[UserTableColumnTitles.careerType] =
                  jsonDecode(userMap[UserTableColumnTitles.careerType]);
              BlocProvider.of<SignupLoginScreenCubit>(context).userModel =
                  UserModel.fromMap(userMap);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PreferedWorkLocationScreen(),
                  ),
                  (route) => false);
            }
          }
        }
      } else {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnBoradingScreen()),
              (route) => false);
        }
      }
    });
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.14),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 85) - 95,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.14),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 180) - 95,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.14),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 260) - 95,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(214, 228, 255, 0.3),
            ),
          ),
          Image.asset(
            Assets.imagesLargeImagesLogo,
            width: 141,
            height: 31,
          ),
        ],
      ),
    );
  }
}
