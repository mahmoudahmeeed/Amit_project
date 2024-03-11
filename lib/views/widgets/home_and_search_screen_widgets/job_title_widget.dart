import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/job_data_cubit/job_data_cubit.dart';

import '../../../model/job_model/job_model.dart';
import '../../screens/apply_job_screen/job_details_screen.dart';

class JobTitleWidget extends StatefulWidget {
  const JobTitleWidget({
    super.key,
    required this.jobModel,
  });
  final JobModel jobModel;

  @override
  State<JobTitleWidget> createState() => _JobTitleWidgetState();
}

class _JobTitleWidgetState extends State<JobTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsScreen(
              jobModel: widget.jobModel,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  width: 40,
                  height: 40,
                  widget.jobModel.image,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes == null
                                  ? null
                                  : loadingProgress.cumulativeBytesLoaded *
                                      1.0 /
                                      loadingProgress.expectedTotalBytes!,
                            ),
                          );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      widget.jobModel.image,
                      width: 40,
                      height: 40,
                    );
                  },
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      widget.jobModel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      widget.jobModel.compName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(57, 83, 107, 1),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<JobDataCubit, JobDataState>(
                  listener: (context, state) {
                    if (state is SaveJobDataSuccess) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: widget.jobModel.isFavorite!
                              ? const Text('Job Saved Successfully!')
                              : const Text('Job Unsaved Successfully!'),
                        ),
                      );
                    }
                    if (state is SaveJobDataError) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('error while saving!'),
                        ),
                      );
                    }
                  },
                  listenWhen: (previous, current) {
                    if (BlocProvider.of<JobDataCubit>(context)
                            .currentJobContext ==
                        context) {
                      return true;
                    }
                    return false;
                  },
                  buildWhen: (previous, current) {
                    if ((current is SaveJobDataLoading ||
                            current is SaveJobDataSuccess ||
                            current is SaveJobDataError) &&
                        BlocProvider.of<JobDataCubit>(context)
                                .currentJobContext ==
                            context) {
                      return true;
                    }
                    return false;
                  },
                  builder: (_, state) {
                    if (state is SaveJobDataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return IconButton(
                      onPressed: () {
                        widget.jobModel.isFavorite!
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
                    );
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            )
          ],
        ),
      ),
    );
  }
}
