import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/signup_models/work_type_model.dart';
import '../../screens/create_account_screens/setup_work_type_screen.dart';

class InterestedWorkTypeWidget extends StatelessWidget {
  final WorkTypeModel workTypeModel;
  final int index;
  const InterestedWorkTypeWidget(
      {super.key, required this.workTypeModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareerTypeSelectedCubit, bool>(
      buildWhen: (previous, current) {
        if (BlocProvider.of<CareerTypeSelectedCubit>(context)
                .currentSelectedItemIndex ==
            index) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        log(' interested work type widget');

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            onTap: () {
              workTypeModel.selected = !workTypeModel.selected;
              BlocProvider.of<CareerTypeSelectedCubit>(context)
                  .changeSelected(index);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: !workTypeModel.selected
                    ? const Color.fromRGBO(250, 250, 250, 1)
                    : const Color.fromRGBO(214, 228, 255, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: !workTypeModel.selected
                      ? const Color.fromRGBO(250, 250, 250, 1)
                      : const Color.fromRGBO(51, 102, 255, 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: !workTypeModel.selected
                        ? BoxDecoration(
                            color: const Color.fromRGBO(250, 250, 250, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(209, 213, 219, 1),
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                          )
                        : BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(51, 102, 255, 1),
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                          ),
                    child: Icon(
                      workTypeModel.icon,
                      size: 24,
                      color: !workTypeModel.selected
                          ? const Color.fromRGBO(209, 213, 219, 1)
                          : const Color.fromRGBO(51, 102, 255, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    workTypeModel.text,
                    style: const TextStyle(
                      color: Color.fromRGBO(17, 24, 39, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
