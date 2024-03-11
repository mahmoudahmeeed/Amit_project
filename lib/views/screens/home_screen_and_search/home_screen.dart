import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/views/screens/apply_job_screen/job_details_screen.dart';
import 'package:job_finder/views/screens/home_screen_and_search/search_screen.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/job_title_widget.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/search_widget.dart';

import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../widgets/home_and_search_screen_widgets/home_screen_title.dart';
import '../../widgets/home_and_search_screen_widgets/suggest_headline_job.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import '../apply_job_screen/recent_jobs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<JobDataCubit>(context).getRecentJobs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHomeScreen(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchScreen();
                    },
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  const SearchWidget(),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SuggestHeadlineJob(
              text: 'Suggested Job',
              onPressed: null,
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<JobDataCubit, JobDataState>(
              buildWhen: (previous, current) {
                if (current is RecentJobDataSuccess ||
                    current is RecentJobDataError ||
                    current is RecentJobDataLoading ||
                    current is SuggestJobDataSuccess ||
                    current is SuggestJobDataError ||
                    current is SuggestJobDataLoading) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SuggestJobDataError ||
                    state is RecentJobDataError) {
                  return const Center(
                    child: Text('Something Unexpected Happened!'),
                  );
                }
                if (state is SuggestJobDataSuccess ||
                    state is RecentJobDataSuccess) {
                  var jobs = BlocProvider.of<JobDataCubit>(context).recentJobs;
                  return CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1),
                        ),
                        child: Column(
                          children: [
                            JobTitleWidget(
                              jobModel: jobs[index],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(jobs[index].salary),
                                CustomButton(
                                  text: 'Apply Now',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsScreen(
                                          jobModel: jobs[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      viewportFraction: .8,
                      height: 230,
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      padEnds: true,
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SuggestHeadlineJob(
              text: 'Recent Jobs',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecentJobsScreen(),
                  ),
                );
              },
            ),
            BlocConsumer<JobDataCubit, JobDataState>(
              listener: (context, state) {
                if (state is RecentJobDataError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something Unexpected Happened!'),
                    ),
                  );
                }
              },
              buildWhen: (previous, current) {
                if (current is RecentJobDataSuccess ||
                    current is RecentJobDataError ||
                    current is RecentJobDataLoading) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is RecentJobDataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var jobs = BlocProvider.of<JobDataCubit>(context).recentJobs;
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1),
                        ),
                        child: JobTitleWidget(
                          jobModel: jobs[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
