import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';

class AppliedScreen extends StatefulWidget {
  const AppliedScreen({super.key});

  @override
  State<AppliedScreen> createState() => _AppliedScreenState();
}

class _AppliedScreenState extends State<AppliedScreen> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<JobDataCubit>(context).getAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied'),
        centerTitle: true,
      ),
      body: BlocBuilder<JobDataCubit, JobDataState>(
        builder: (context, state) {
          if (state is AppliedJobDataSuccess) {
            var appliedJobs =
                BlocProvider.of<JobDataCubit>(context).appliedJobs;
            return appliedJobs.isEmpty
                ? const Center(
                    child: Text(
                      'No applied jobs yet\napply to a job to see it here',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    itemCount: appliedJobs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Image.asset(appliedJobs[index].image),
                            title: Text(appliedJobs[index].name),
                            subtitle: Text(appliedJobs[index].compName),
                            trailing: IconButton(
                              onPressed: () {
                                BlocProvider.of<JobDataCubit>(context)
                                    .deleteAppliedJob(appliedJobs[index]);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              'Posted at: ${appliedJobs[index].createdAt!}',
                              style: const TextStyle(
                                color: Color.fromRGBO(107, 114, 128, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 1,
                        height: 10,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                  );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
