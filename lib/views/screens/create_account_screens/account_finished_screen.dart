import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/root/root_app.dart';
import 'package:job_finder/views/screens/home_screen_and_search/main_screen.dart';
import '../../../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../../../controller/utils/app_images.dart';
import '../../../controller/utils/enum_active_routes_observer.dart';
import '../../../controller/utils/shared_helper.dart';
import '../../../controller/utils/sql_helper/sql_helper.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';

class AccountFinishedScreen extends StatefulWidget {
  const AccountFinishedScreen({super.key});

  @override
  State<AccountFinishedScreen> createState() => _AccountFinishedScreenState();
}

class _AccountFinishedScreenState extends State<AccountFinishedScreen>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    BlocProvider.of<SignupLoginScreenCubit>(context).userModel!.isLogin = true;
    SqlHelper.updateData(queryStatement: ''' 
                          UPDATE  ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.login} = 1;
                          ''');
    SharedHelper.saveData(
        key: SharedHelper.activeRouteKey,
        value: ActiveRoute.accountFinished.route);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.asset(
              Assets.imagesLargeImagesSuccessAccount,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your account has been set up!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(17, 24, 39, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'We have customized feeds according to your preferences',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color.fromRGBO(107, 114, 128, 1),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Get Started',
                fontSize: 16,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
