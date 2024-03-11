import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/controller/cubit/job_data_cubit/job_data_cubit.dart';
import 'package:job_finder/views/screens/apply_job_screen/job_details_screen.dart';

class RecentSuggestWidget extends StatelessWidget {
  const RecentSuggestWidget({
    super.key,
    required this.jobTitle,
    required this.isRecent,
    required this.index,
  });
  final String jobTitle;
  final bool isRecent;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isRecent ? Icons.history : Icons.search_outlined,
          size: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          jobTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            if (isRecent) {
              BlocProvider.of<JobDataCubit>(context).removeRecentSearch(index);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailsScreen(
                    jobModel: context.read<JobDataCubit>().recentJobs[index],
                  ),
                ),
              );
            }
          },
          child: Icon(
            isRecent
                ? FontAwesomeIcons.xmark
                : FontAwesomeIcons.rightFromBracket,
            size: 22,
          ),
        )
      ],
    );
  }
}
