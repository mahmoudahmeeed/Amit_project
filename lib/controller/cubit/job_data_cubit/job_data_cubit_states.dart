part of 'job_data_cubit.dart';

abstract class JobDataState {}

class JobDataInitial extends JobDataState {}

/// suggest job
class SuggestJobDataLoading extends JobDataState {}

class SuggestJobDataSuccess extends JobDataState {}

class SuggestJobDataError extends JobDataState {}

/// recent job
class RecentJobDataLoading extends JobDataState {}

class RecentJobDataSuccess extends JobDataState {}

class RecentJobDataError extends JobDataState {}

/// saved job
class SaveJobDataLoading extends JobDataState {}

class SaveJobDataSuccess extends JobDataState {}

class SaveJobDataError extends JobDataState {}

/// applied job
class AppliedJobDataLoading extends JobDataState {}

class AppliedJobDataSuccess extends JobDataState {}

class AppliedJobDataError extends JobDataState {}

/// recent search
class RecentSearchLoading extends JobDataState {}

class RecentSearchSuccess extends JobDataState {}

class RecentSearchError extends JobDataState {}
