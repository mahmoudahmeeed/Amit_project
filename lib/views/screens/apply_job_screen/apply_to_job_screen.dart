import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/edit_profile_screens_cubit/file_path_cubit.dart';
import 'package:job_finder/controller/cubit/job_data_cubit/job_data_cubit.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/views/screens/apply_job_screen/data_sent_complete_screen.dart';
import 'package:job_finder/views/widgets/profile_settings_widgets/portfolio_widget.dart';

import '../../../controller/utils/app_images.dart';
import '../../../model/job_model/job_model.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';

class ApplyToJobScreen extends StatefulWidget {
  const ApplyToJobScreen({super.key, required this.job});
  final JobModel job;

  @override
  State<ApplyToJobScreen> createState() => _ApplyToJobScreenState();
}

class _ApplyToJobScreenState extends State<ApplyToJobScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // BlocProvider.of<FilePathCubit>(context).getPortoflios(
    //     userId: BlocProvider.of<SignupLoginScreenCubit>(context).userModel!.id,
    //     token:
    //         BlocProvider.of<SignupLoginScreenCubit>(context).userModel!.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apply Job',
          style: TextStyle(
            color: Color.fromRGBO(17, 24, 39, 1),
          ),
        ),
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
                      'Upload your CV',
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
                              'Select file',
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
              //   if (current is PortfolioCubitState ||
              //       current is PortfolioDownloadCubitLoadingState ||
              //       current is PortfolioDownloadCubitCompleteState ||
              //       current is PortfolioDownloadCubitErrorState ||
              //       current is SelectedFileSuccessCubitState ||
              //       current is SelectedFileLoadingCubitState ||
              //       current is SelectedFilePathCubitState) {
              //     return true;
              //   }
              //   return false;
              // },
              builder: (context, state) {
                if (state is PortfolioDownloadCubitLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PortfolioDownloadCubitErrorState) {
                  return Column(
                    children: [
                      const Text(
                        'Error while downloading file',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<FilePathCubit>(context).getPortoflios(
                              userId: BlocProvider.of<SignupLoginScreenCubit>(
                                      context)
                                  .userModel!
                                  .id,
                              token: BlocProvider.of<SignupLoginScreenCubit>(
                                      context)
                                  .userModel!
                                  .token);
                        },
                        child: const Text('try again'),
                      ),
                    ],
                  );
                }
                var files = BlocProvider.of<FilePathCubit>(context).files;
                return Expanded(
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<FilePathCubit>(context).selectFile =
                                index;
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: PortfolioWidget(
                              index: index,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<JobDataCubit, JobDataState>(
                listener: (context, state) {
                  if (state is AppliedJobDataSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DataSentSuccessfully(),
                      ),
                    );
                  }
                  if (state is PortfolioUploadCubitErrorState ||
                      state is AppliedJobDataError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error while uploading file'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PortfolioUploadCubitLoadingState ||
                      state is AppliedJobDataLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  log(BlocProvider.of<FilePathCubit>(context).files.toString());
                  return CustomButton(
                    fontSize: 16,
                    text: 'Sumbit',
                    onPressed: () {
                      log(BlocProvider.of<FilePathCubit>(context)
                          .files
                          .toString());
                      var selectedFileIndex =
                          BlocProvider.of<FilePathCubit>(context)
                              .selectedFileIndex;
                      if (selectedFileIndex != -1) {
                        var files =
                            BlocProvider.of<FilePathCubit>(context).files;
                        BlocProvider.of<JobDataCubit>(context).applyToJob(
                          job: widget.job,
                          user: BlocProvider.of<SignupLoginScreenCubit>(context)
                              .userModel!,
                          filePath: files[selectedFileIndex].path,
                        );
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select file'),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
