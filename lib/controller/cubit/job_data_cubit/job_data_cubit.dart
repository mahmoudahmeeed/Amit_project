import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';
import 'package:job_finder/controller/utils/shared_helper.dart';

import '../../../model/job_model/databse_job_model.dart';
import '../../../model/job_model/job_model.dart';
import '../../../model/signup_models/user_model.dart';
import '../../utils/sql_helper/sql_helper.dart';

part 'job_data_cubit_states.dart';

class JobDataCubit extends Cubit<JobDataState> {
  JobDataCubit() : super(JobDataInitial());

  /// jobs from api
  List<JobModel> recentJobs = [];
  List<JobModel> suggestedJobs = [];

  /// to save interaction with user
  List<DatabaseJobModel> savedJobs = [];
  List<DatabaseJobModel> appliedJobs = [];

  List<String> recentSearch = [];

  Future addRecentSearch(String searchName) async {
    emit(RecentSearchLoading());
    try {
      recentSearch.add(searchName);
      await SharedHelper.saveData(key: 'recent_search', value: recentSearch);
      emit(RecentSearchSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(RecentSearchError());
    }
  }

  Future removeRecentSearch(int index) async {
    emit(RecentSearchLoading());
    try {
      recentSearch.removeAt(index);
      await SharedHelper.saveData(key: 'recent_search', value: recentSearch);
      emit(RecentSearchSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(RecentSearchError());
    }
  }

  void getRecentSearch() {
    emit(RecentSearchLoading());
    try {
      recentSearch = SharedHelper.getData(
            key: 'recent_search',
            valueDataType: [],
          ) ??
          [];
      emit(RecentSearchSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(RecentSearchError());
    }
  }

  Future<void> getSuggestedJobData({required String token}) async {
    emit(SuggestJobDataLoading());
    try {
      await DioHelper.getData(endPoint: UrlPaths.suggestJob, token: token).then(
        (response) {
          if (response!.statusCode == 200) {
            var list = response.data['data'] as List<Map<String, dynamic>>;
            for (var element in list) {
              suggestedJobs.add(JobModel.fromMap(element));
            }
          }
          emit(SuggestJobDataSuccess());
        },
      );
    } catch (e) {
      emit(SuggestJobDataError());
    }
  }

  Future<void> getRecentJobs() async {
    emit(RecentJobDataLoading());
    try {
      await rootBundle.loadString('assets/files/jobs.json').then((value) {
        var list = jsonDecode(value);
        for (var element in list) {
          recentJobs.add(JobModel.fromMap(element));
        }
      });
      emit(RecentJobDataSuccess());
    } catch (e) {
      emit(RecentJobDataError());
    }
  }

  Future applyToJob({
    required JobModel job,
    required UserModel user,
    required String filePath,
  }) async {
    emit(AppliedJobDataLoading());
    try {
      // await DioHelper.postData(
      //   endPoint: UrlPaths.applyToJob,
      //   token: user.token,
      //   data: {
      //     'cv_file': await MultipartFile.fromFile(
      //       filePath,
      //     ),
      //     'name': user.name,
      //     'email': user.email,
      //     'mobile': user.mobile,
      //     'work_type': job.jobType,
      //     'other_file': await MultipartFile.fromFile(
      //       filePath,
      //     ),
      //     'user_id': user.id,
      //     'jobs_id': job.id,
      //   },
      // ).then(
      //   (response) {
      //     if (response!.statusCode == 200) {
      //       emit(AppliedJobDataSuccess());
      //     }
      //     emit(AppliedJobDataSuccess());
      //   },
      // );

      Future.delayed(
        const Duration(seconds: 2),
        () async {
          await saveAppliedJob(job);
          emit(AppliedJobDataSuccess());
        },
      );
    } catch (e) {
      // emit(AppliedJobDataError());
      emit(AppliedJobDataSuccess());
    }
  }

  BuildContext? currentJobContext;

  /// insert in realtime and database
  Future<bool> saveJob(JobModel job, BuildContext context) async {
    emit(SaveJobDataLoading());
    try {
      // save in realtime list
      currentJobContext = context;
      job.isFavorite = true;
      DatabaseJobModel savedJobModel = DatabaseJobModel(
        id: job.id,
        name: job.name,
        image: job.image,
        compName: job.compName,
        createdAt: job.createdAt,
      );
      savedJobs.add(savedJobModel);
      // save in database
      await SqlHelper.insertRowAsMap(
        table: SavedJobTableColumnTitles.jobTable,
        values: savedJobModel.toMap(),
      );
      emit(SaveJobDataSuccess());
      return true;
    } catch (e) {
      emit(SaveJobDataError());
      return false;
    }
  }

  /// delete from realtime and database
  Future<bool> deleteSavedJob(JobModel job, BuildContext context) async {
    emit(SaveJobDataLoading());
    try {
      // delete from realtime list
      currentJobContext = context;
      job.isFavorite = false;
      savedJobs.removeWhere(
        (element) {
          return element.id == job.id;
        },
      );
      // delete from database
      await SqlHelper.deleteData(queryStatement: '''
      DELETE FROM ${SavedJobTableColumnTitles.jobTable} WHERE ${DatabseJobTableColumnTitles.jobId} = ${job.id}
       ''');
      emit(SaveJobDataSuccess());
      return true;
    } catch (e) {
      emit(SaveJobDataError());
      return false;
    }
  }

  /// get saved jobs from database
  Future<List<JobModel>> getSavedJobs() async {
    emit(SaveJobDataLoading());
    try {
      await SqlHelper.tableHasData(table: SavedJobTableColumnTitles.jobTable)
          .then((data) async {
        savedJobs.clear();
        if (data) {
          // get data from database
          await SqlHelper.getAllRows(table: SavedJobTableColumnTitles.jobTable)
              .then((jobData) {
            for (var element in jobData) {
              savedJobs.add(DatabaseJobModel.fromMap(element));
            }
            return savedJobs;
          });
          emit(SaveJobDataSuccess());
        }
      });
    } catch (e) {
      emit(SaveJobDataError());
    }
    return [];
  }

  /// insert in realtime & database
  Future<bool> saveAppliedJob(JobModel job) async {
    emit(AppliedJobDataLoading());
    try {
      // save in realtime list
      DatabaseJobModel appliedJobModel = DatabaseJobModel(
        id: job.id,
        name: job.name,
        image: job.image,
        compName: job.compName,
        createdAt: job.createdAt,
      );
      appliedJobs.add(appliedJobModel);
      // save in database
      await SqlHelper.insertRowAsMap(
        table: AppliedJobTableColumnTitles.jobTable,
        values: appliedJobModel.toMap(),
      );
      emit(AppliedJobDataSuccess());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      emit(AppliedJobDataError());
      return false;
    }
  }

  /// delete from realtime & database

  Future<bool> deleteAppliedJob(DatabaseJobModel job) async {
    emit(AppliedJobDataLoading());
    try {
      // delete from realtime list
      appliedJobs.remove(
        job,
      );
      // delete from database
      await SqlHelper.deleteData(queryStatement: '''
      DELETE FROM ${AppliedJobTableColumnTitles.jobTable} WHERE ${DatabseJobTableColumnTitles.jobId} = ${job.id}
       ''');
      emit(AppliedJobDataSuccess());
      return true;
    } catch (e) {
      emit(AppliedJobDataError());
      return false;
    }
  }

  /// get applied jobs from database
  Future<void> getAppliedJobs() async {
    emit(AppliedJobDataLoading());
    log('get applied jobs loading');
    try {
      await SqlHelper.tableHasData(table: AppliedJobTableColumnTitles.jobTable)
          .then((data) async {
        log('applied has data$data');
        appliedJobs.clear();
        if (data) {
          await SqlHelper.getAllRows(
                  table: AppliedJobTableColumnTitles.jobTable)
              .then((jobData) {
            for (var element in jobData) {
              appliedJobs.add(DatabaseJobModel.fromMap(element));
            }
          });
        }
        emit(AppliedJobDataSuccess());
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(AppliedJobDataError());
    }
  }
}
