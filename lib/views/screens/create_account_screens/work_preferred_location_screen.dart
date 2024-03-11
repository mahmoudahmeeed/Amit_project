import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/controller/utils/enum_active_routes_observer.dart';
import 'package:job_finder/root/root_app.dart';
import '../../../controller/utils/app_images.dart';
import '../../../controller/utils/shared_helper.dart';
import '../../../controller/utils/sql_helper/sql_helper.dart';
import '../../../model/signup_models/country_model.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import 'account_finished_screen.dart';

class PreferedWorkLocationScreen extends StatefulWidget {
  const PreferedWorkLocationScreen({super.key});

  @override
  State<PreferedWorkLocationScreen> createState() =>
      _PreferedWorkLocationScreenState();
}

// store work prefered location in cubit signup
class WorkTypeNature extends Cubit<int> {
  WorkTypeNature() : super(-1);
  String workNature = 'Office';
  void changeSelectedIndex(int index) {
    index == 0 ? workNature = 'Office' : workNature = 'Remote';
    emit(index);
  }
}

class _PreferedWorkLocationScreenState extends State<PreferedWorkLocationScreen>
    with RouteAware {
  final MultiSelectController<String> controller =
      MultiSelectController<String>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    SharedHelper.saveData(
        key: SharedHelper.activeRouteKey,
        value: ActiveRoute.preferedLocations.route);
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => WorkTypeNature(),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Where are you preferred Location?',
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
                  'Let us know, where is the work location you want at this time, so we can adjust it.',
                  style: TextStyle(
                    color: Color.fromRGBO(115, 115, 121, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<WorkTypeNature, int>(
                  builder: (context, state) {
                    return Center(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(244, 244, 245, 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<WorkTypeNature>()
                                    .changeSelectedIndex(0);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: state == 0
                                      ? const Color.fromRGBO(9, 26, 122, 1)
                                      : const Color.fromRGBO(244, 244, 245, 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    'Work From Office',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: state == 0
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(
                                              107, 114, 128, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<WorkTypeNature>()
                                    .changeSelectedIndex(1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: state == 1
                                      ? const Color.fromRGBO(9, 26, 122, 1)
                                      : const Color.fromRGBO(244, 244, 245, 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    'Remote Work',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: state == 1
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(
                                              107, 114, 128, 1),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Select the country you want for your job',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(115, 115, 121, 1),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: MultiSelectContainer(
                    controller: controller,
                    wrapSettings: const WrapSettings(
                      runSpacing: 10,
                    ),
                    itemsPadding: const EdgeInsets.all(5),
                    itemsDecoration: MultiSelectDecorations(
                      selectedDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromRGBO(51, 102, 255, 1),
                        ),
                        color: const Color.fromRGBO(214, 228, 255, 1),
                      ),
                    ),
                    items: List.generate(
                      countries.length,
                      (index) => MultiSelectCard(
                        value: '${countries[index].countryName}}',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: !countries[index].selected
                                  ? const Color.fromRGBO(229, 231, 235, 1)
                                  : const Color.fromRGBO(51, 102, 255, 1),
                            ),
                            color: !countries[index].selected
                                ? const Color.fromRGBO(250, 250, 250, 1)
                                : const Color.fromRGBO(214, 228, 255, 1),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                countries[index].countryImage,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                countries[index].countryName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(17, 24, 39, 1),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onChange: (allSelectedItems, selectedItem) {},
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Builder(builder: (context) {
                    return CustomButton(
                      text: 'Next',
                      fontSize: 16,
                      onPressed: () async {
                        if (controller.getSelectedItems().isEmpty ||
                            context.read<WorkTypeNature>().state == -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select work type and one country of work location',
                              ),
                            ),
                          );
                        } else {
                          var workNature =
                              context.read<WorkTypeNature>().workNature;
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .userModel!
                              .workNature = workNature;

                          var workLocations = controller
                              .getSelectedItems()
                              .map((e) => e.replaceAll('}', ''))
                              .toList();
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .userModel!
                              .workLocations = workLocations;

                          /// ------------------------------------------------ ///
                          await SqlHelper.updateData(queryStatement: ''' 
                          UPDATE  ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.workNature} = '$workNature', ${UserTableColumnTitles.workLocations} = '${jsonEncode(workLocations)}';
                          ''');
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AccountFinishedScreen(),
                              ),
                              (route) => false,
                            );
                          }
                        }
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ));
  }
}

/// Country model
List<Country> countries = [
  Country(
    countryName: 'Argentina',
    countryImage: Assets.imagesIconsArgentina,
    selected: false,
  ),
  Country(
    countryName: 'Brazil',
    countryImage: Assets.imagesIconsBrazil,
    selected: false,
  ),
  Country(
    countryName: 'Singapore',
    countryImage: Assets.imagesIconsSingapore,
    selected: false,
  ),
  Country(
    countryName: 'Canada',
    countryImage: Assets.imagesIconsCanada,
    selected: false,
  ),
  Country(
    countryName: 'China',
    countryImage: Assets.imagesIconsChina,
    selected: false,
  ),
  Country(
    countryName: 'India',
    countryImage: Assets.imagesIconsIndia,
    selected: false,
  ),
  Country(
    countryName: 'Indonesia',
    countryImage: Assets.imagesIconsIndonesia,
    selected: false,
  ),
  Country(
    countryName: 'Malaysia',
    countryImage: Assets.imagesIconsMalaysia,
    selected: false,
  ),
  Country(
    countryName: 'Philippines',
    countryImage: Assets.imagesIconsPhilippines,
    selected: false,
  ),
  Country(
    countryName: 'Saudi Arabia',
    countryImage: Assets.imagesIconsSaudiArabia,
    selected: false,
  ),
  Country(
    countryName: 'United States',
    countryImage: Assets.imagesIconsUnitedStates,
    selected: false,
  ),
  Country(
    countryName: 'Vietnam',
    countryImage: Assets.imagesIconsVietnam,
    selected: false,
  ),
];
