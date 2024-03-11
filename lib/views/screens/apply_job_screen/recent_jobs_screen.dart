import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../widgets/home_and_search_screen_widgets/job_title_widget.dart';

class RecentJobsScreen extends StatefulWidget {
  const RecentJobsScreen({super.key});

  @override
  State<RecentJobsScreen> createState() => _RecentJobsScreenState();
}

class _RecentJobsScreenState extends State<RecentJobsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<JobDataCubit>(context).getRecentJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Jobs Based on Your Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<JobDataCubit, JobDataState>(
          builder: (context, state) {
            if (state is RecentJobDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is RecentJobDataError) {
              return const Center(
                child: Text('Error Loading Jobs'),
              );
            }
            var recentJobs = BlocProvider.of<JobDataCubit>(context).recentJobs;
            return ListView.separated(
              itemBuilder: (context, index) {
                return JobTitleWidget(
                  jobModel: recentJobs[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1.5,
                  color: Colors.grey,
                  indent: 10,
                  endIndent: 10,
                );
              },
              itemCount: recentJobs.length,
            );
          },
        ),
      ),
    );
  }
}
