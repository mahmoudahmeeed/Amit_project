import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../../model/job_model/job_model.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import 'apply_to_job_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, required this.jobModel});
  final JobModel jobModel;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('${widget.jobModel.isFavorite!}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Details',
          style: TextStyle(
            color: Color.fromRGBO(17, 24, 39, 1),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              !widget.jobModel.isFavorite!
                  ? BlocProvider.of<JobDataCubit>(context)
                      .deleteSavedJob(widget.jobModel, context)
                  : BlocProvider.of<JobDataCubit>(context)
                      .saveJob(widget.jobModel, context);
            },
            icon: widget.jobModel.isFavorite!
                ? const Icon(
                    Icons.bookmark_outlined,
                    color: Colors.blue,
                  )
                : const Icon(
                    Icons.bookmark_outline,
                    color: Colors.grey,
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.jobModel.image,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null
                                ? child
                                : Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes ==
                                                  null
                                              ? null
                                              : loadingProgress
                                                      .cumulativeBytesLoaded *
                                                  1.0 /
                                                  loadingProgress
                                                      .expectedTotalBytes!,
                                    ),
                                  );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              widget.jobModel.image,
                              width: 100,
                              height: 100,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.jobModel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color.fromRGBO(17, 24, 39, 1),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.jobModel.compName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color.fromRGBO(55, 65, 81, 1),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: widget.jobModel.salary,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color.fromRGBO(46, 142, 24, 1),
                              ),
                            ),
                            const TextSpan(
                              text: '/Month',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromRGBO(107, 114, 128, 1),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(214, 228, 255, 1),
                              ),
                              child: Text(
                                widget.jobModel.jobTimeType,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(51, 102, 255, 1),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(214, 228, 255, 1),
                              ),
                              child: Text(
                                widget.jobModel.jobLevel,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(51, 102, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    automaticIndicatorColorAdjustment: true,
                    controller: tabController,
                    isScrollable: true,
                    padding: const EdgeInsets.only(bottom: 5),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(107, 114, 128, 1),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          child: Text(
                            'Company',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(107, 114, 128, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: TabBarView(
                      controller: tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        /// first view of tab bar view
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Job Description',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.jobModel.jobDescription,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(75, 85, 99, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Job Skills',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.jobModel.jobSkill,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(75, 85, 99, 1),
                              ),
                            ),
                          ],
                        ),

                        /// second view of tab bar view
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 70,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromRGBO(
                                            229, 231, 235, 1),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Email',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(75, 85, 99, 1),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.jobModel.compEmail,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(17, 24, 39, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromRGBO(
                                            229, 231, 235, 1),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Website',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromRGBO(75, 85, 99, 1),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.jobModel.compWebsite,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(17, 24, 39, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'About Company',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.jobModel.aboutComp,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(75, 85, 99, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              left: 20,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: CustomButton(
                  fontSize: 16,
                  text: 'Apply',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ApplyToJobScreen(job: widget.jobModel);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
