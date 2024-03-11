part of 'signup_login_screens_cubit.dart';

abstract class SignupCubitState {}

class SignupCubitInitialState extends SignupCubitState {}

class ObscureVisbilityCubitState extends SignupCubitState {}

class ChangeButtonStyleCubitState extends SignupCubitState {}

class ChangeCheckedCubitState extends SignupCubitState {}

class SingupLoadingCubitState extends SignupCubitState {}

class SingupSuccessCubitState extends SignupCubitState {}

class SignupUnauthorizedCubitState extends SignupCubitState {
  String? errorMessage;
  SignupUnauthorizedCubitState({this.errorMessage});
}

class SingupErrorCubitState extends SignupCubitState {
  String? errorMessage;
  SingupErrorCubitState({this.errorMessage});
}

class GetDataFromStorageLoadingCubitState extends SignupCubitState {}

class GetDataFromStorageSuccessCubitState extends SignupCubitState {}

class UpdateUserDataLoadingCubitState extends SignupCubitState {}

class UpdateUserDataSuccessCubitState extends SignupCubitState {}

class UpdateUserDataErrorCubitState extends SignupCubitState {}
