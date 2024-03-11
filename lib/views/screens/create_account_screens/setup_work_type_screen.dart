import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/controller/utils/enum_active_routes_observer.dart';
import 'package:job_finder/controller/utils/shared_helper.dart';
import 'package:job_finder/controller/utils/sql_helper/sql_helper.dart';
import 'package:job_finder/root/root_app.dart';
import 'package:job_finder/views/screens/create_account_screens/work_preferred_location_screen.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';
import '../../../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../../../model/signup_models/work_type_model.dart';
import '../../widgets/signup_screen_widget/interested_work_type_widget.dart';

class CareerTypeScreen extends StatefulWidget {
  const CareerTypeScreen({super.key});

  @override
  State<CareerTypeScreen> createState() => _CareerTypeScreenState();
}

class CareerTypeSelectedCubit extends Cubit<bool> {
  CareerTypeSelectedCubit() : super(false);

  int currentSelectedItemIndex = -1;
  void changeSelected([int newSelected = -1]) {
    currentSelectedItemIndex = newSelected;
    emit(!state);
  }

  List<String> getSelectedWorkType() {
    return workType
        .where((element) => element.selected == true)
        .map((e) => e.text)
        .toList();
  }
}

final List<WorkTypeModel> workType = [
  WorkTypeModel(icon: FontAwesomeIcons.bezierCurve, text: 'UI/UX Designer'),
  WorkTypeModel(icon: FontAwesomeIcons.penNib, text: 'Ilustrator Designer'),
  WorkTypeModel(icon: FontAwesomeIcons.laptopCode, text: 'Developer'),
  WorkTypeModel(icon: FontAwesomeIcons.chartPie, text: 'Management'),
  WorkTypeModel(
      icon: FontAwesomeIcons.laptopFile, text: 'Information Technology'),
  WorkTypeModel(
      icon: FontAwesomeIcons.bookAtlas, text: 'Research and Analytics'),
];

class _CareerTypeScreenState extends State<CareerTypeScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    SharedHelper.saveData(
        key: SharedHelper.activeRouteKey, value: ActiveRoute.careerType.route);
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
      body: BlocProvider(
        create: (context) => CareerTypeSelectedCubit(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'What type of work are you interested in?',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(17, 24, 39, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tell us what you\'re interested in so we can customise the app for your needs.',
                style: TextStyle(
                  color: Color.fromRGBO(115, 115, 121, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: workType.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 150,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return InterestedWorkTypeWidget(
                      workTypeModel: workType[index],
                      index: index,
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                child: Builder(builder: (context) {
                  return CustomButton(
                      fontSize: 16,
                      onPressed: () async {
                        if (BlocProvider.of<CareerTypeSelectedCubit>(context)
                                .currentSelectedItemIndex ==
                            -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your work type'),
                            ),
                          );
                        } else {
                          List<String> careerType = context
                              .read<CareerTypeSelectedCubit>()
                              .getSelectedWorkType();
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .userModel!
                              .careerType = careerType;
                          await SqlHelper.updateData(queryStatement: ''' 
                          UPDATE  ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.careerType} = '${jsonEncode(careerType)}';
                          ''');
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PreferedWorkLocationScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        }
                      },
                      text: 'Next');
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
