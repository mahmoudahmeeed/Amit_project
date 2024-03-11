import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/enum_languages_names.dart';

import '../../../controller/utils/app_images.dart';

///
/// this is just design for the screen not applying the language
///
class SetLanguageScreen extends StatefulWidget {
  const SetLanguageScreen({super.key});

  @override
  State<SetLanguageScreen> createState() => _SetLanguageScreenState();
}

class LanguageCubit extends Cubit<Languages> {
  LanguageCubit() : super(Languages.english);

  changeLanguage(Languages language) {
    emit(language);
  }
}

class _SetLanguageScreenState extends State<SetLanguageScreen> {
  List<String> images = [
    Assets.imagesIconsSaudiArabia,
    Assets.imagesIconsUnitedStates,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (insideContext) => LanguageCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Language',
            style: TextStyle(
              color: Color.fromRGBO(17, 24, 39, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<LanguageCubit, Languages>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(images[index]),
                    title: Text(
                      Languages.values[index].name,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Radio(
                      value: Languages.values[index],
                      groupValue: BlocProvider.of<LanguageCubit>(context).state,
                      onChanged: (value) {
                        BlocProvider.of<LanguageCubit>(context)
                            .changeLanguage(value!);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemCount: Languages.values.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
