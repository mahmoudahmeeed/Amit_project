import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/edit_profile_screens_cubit/file_path_cubit.dart';
import 'package:job_finder/views/widgets/profile_settings_widgets/portfolio_widget.dart';

import '../../../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../../../controller/utils/app_images.dart';

class AddPortfolioScreen extends StatefulWidget {
  const AddPortfolioScreen({super.key});

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(236, 242, 255, 1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromRGBO(51, 102, 255, 1),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesIconsUploadPortfolio),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Upload your Portfolio',
                      style: TextStyle(
                        color: Color.fromRGBO(17, 24, 39, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Max. file size 10 MB',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(214, 228, 255, 1),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Color.fromRGBO(51, 102, 255, 1),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onPressed: () {
                          var userModel =
                              BlocProvider.of<SignupLoginScreenCubit>(context)
                                  .userModel!;
                          BlocProvider.of<FilePathCubit>(context).pickPortfolio(
                            token: userModel.token,
                            userId: userModel.id,
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: Color.fromRGBO(51, 102, 255, 1),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add file',
                              style: TextStyle(
                                color: Color.fromRGBO(51, 102, 255, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FilePathCubit, FilePathCubitState>(
              // buildWhen: (previous, current) {
              //   if (current is PortfolioCubitState) {
              //     return true;
              //   }
              //   return false;
              // },
              builder: (context, state) {
                var files = BlocProvider.of<FilePathCubit>(context).files;
                return Expanded(
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: PortfolioWidget(
                          index: index,
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
