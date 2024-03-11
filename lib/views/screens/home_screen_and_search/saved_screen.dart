import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/views/screens/apply_job_screen/job_details_screen.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../../controller/utils/app_images.dart';
import '../../../model/job_model/job_model.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<JobDataCubit>(context).getSavedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: true,
      ),
      body: BlocConsumer<JobDataCubit, JobDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          var jobCubit = BlocProvider.of<JobDataCubit>(context);
          return jobCubit.savedJobs.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesLargeImagesNoSavedJobs),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Nothing has been saved yet',
                      style: TextStyle(
                        color: Color.fromRGBO(17, 24, 39, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Press the bookmark icon on the job you want to save.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffF4F4F5),
                        border: Border.all(
                          color: const Color(0xffE5E7EB),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${jobCubit.savedJobs.length} Jobs Saved',
                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Image.asset(
                                    jobCubit.savedJobs[index].image),
                                title: Text(
                                  jobCubit.savedJobs[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Color.fromRGBO(17, 24, 39, 1),
                                  ),
                                ),
                                subtitle: Text(
                                  jobCubit.savedJobs[index].compName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color.fromRGBO(55, 65, 81, 1),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      showDragHandle: true,
                                      constraints: const BoxConstraints(
                                        maxHeight: 350,
                                      ),
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: const Color.fromRGBO(
                                                      209, 213, 219, 1),
                                                ),
                                                child: ListTile(
                                                  leading: const Icon(
                                                      FontAwesomeIcons
                                                          .briefcase),
                                                  title:
                                                      const Text('Apply Job'),
                                                  trailing: const Icon(
                                                      Icons.arrow_right),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          JobModel savedJob = jobCubit
                                                              .recentJobs
                                                              .firstWhere((jobModel) =>
                                                                  jobModel.id ==
                                                                  jobCubit
                                                                      .savedJobs[
                                                                          index]
                                                                      .id);
                                                          return JobDetailsScreen(
                                                            jobModel: savedJob,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: const Color.fromRGBO(
                                                      209, 213, 219, 1),
                                                ),
                                                child: ListTile(
                                                  leading:
                                                      const Icon(Icons.share),
                                                  title: const Text('Share'),
                                                  trailing: const Icon(
                                                      Icons.arrow_right),
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await Share.share(
                                                        'developer: mohamed ibrahem & wtsapp: 01275314934');
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: const Color.fromRGBO(
                                                      209, 213, 219, 1),
                                                ),
                                                child: ListTile(
                                                  leading: const Icon(
                                                      FontAwesomeIcons
                                                          .bookmark),
                                                  title:
                                                      const Text('Cancel Save'),
                                                  trailing: const Icon(
                                                      Icons.arrow_right),
                                                  onTap: () {
                                                    jobCubit.deleteSavedJob(
                                                      jobCubit.recentJobs
                                                          .firstWhere(
                                                        (element) =>
                                                            element.id ==
                                                            jobCubit
                                                                .savedJobs[
                                                                    index]
                                                                .id,
                                                      ),
                                                      context,
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.more_horiz),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                jobCubit.savedJobs[index].createdAt!,
                                style: const TextStyle(
                                  color: Color.fromRGBO(55, 65, 81, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
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
                        itemCount: jobCubit.savedJobs.length,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
