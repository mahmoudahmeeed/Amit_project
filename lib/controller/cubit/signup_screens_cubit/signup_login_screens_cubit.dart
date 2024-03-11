import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';

import '../../../model/signup_models/user_model.dart';
import '../../utils/sql_helper/sql_helper.dart';

part 'signup_cubit_states.dart';

class SignupLoginScreenCubit extends Cubit<SignupCubitState> {
  SignupLoginScreenCubit() : super(SignupCubitInitialState());

  bool visible = false;
  bool changed = false;
  bool checked = false;
  UserModel? userModel;
  String? errorMessageWhileSignup;

  updateVisibility() {
    visible = !visible;
    emit(ObscureVisbilityCubitState());
  }

  changeButtonStyle() {
    changed = !changed;
    emit(ChangeButtonStyleCubitState());
  }

  /// ! ........................................................................ ! ///

  Future updateUserData({
    String? name,
    String? password,
    String? email,
    String? mobile,
    String? bio,
    String? address,
  }) async {
    emit(UpdateUserDataLoadingCubitState());
    try {
      if (name != null || password != null) {
        Map<String, dynamic> namePassword = {};
        if (name != null) {
          namePassword.putIfAbsent('name', () => name);
        }
        if (password != null) {
          namePassword.putIfAbsent('password', () => password);
        }
        userModel!.name = name!;
        await SqlHelper.updateData(queryStatement: ''' 
                 UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.name} = '${userModel!.name}';
            ''');
        // await DioHelper.putData(
        //   endPoint: UrlPaths.updateNPProfile,
        //   token: userModel!.token,
        //   data: namePassword,
        // ).then(
        //   (response) async {
        //     if (response!.statusCode == 200) {
        //       userModel!.name = name!;
        //       await SqlHelper.updateData(queryStatement: '''
        //          UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.name} = '${userModel!.name}';
        //     ''');
        //       emit(UpdateUserDataSuccessCubitState());
        //     }
        //   },
        // );
      }
      if (email != null) {
        await SqlHelper.insertData(queryStatement: ''' 
            UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.email} = '$email'; 
            ''');
      }
      if (mobile != null || bio != null || address != null) {
        userModel!.mobile = mobile;
        userModel!.bio = bio;
        userModel!.address = address;
        await SqlHelper.updateData(queryStatement: ''' 
            UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.mobile} = '${userModel!.mobile}', ${UserTableColumnTitles.bio} = '${userModel!.bio}', ${UserTableColumnTitles.address} = '${userModel!.address}';
            ''');

        // await DioHelper.putData(
        //     endPoint: '${UrlPaths.updateMBAProfile}${userModel!.id}',
        //     token: userModel!.token,
        //     queryParameters: {
        //       'mobile': mobile ?? userModel!.mobile,
        //       'bio': bio ?? userModel!.bio,
        //       'address': address ?? userModel!.address,
        //     }).then(
        //   (response) async {
        //     if (response!.statusCode == 200) {
        //       userModel!.mobile = mobile;
        //       await SqlHelper.updateData(queryStatement: '''
        //     UPDATE ${UserTableColumnTitles.usersTable} SET ${UserTableColumnTitles.mobile} = '${userModel!.mobile}', ${UserTableColumnTitles.bio} = '${userModel!.bio}', ${UserTableColumnTitles.address} = '${userModel!.address}';
        //     ''');
        //       emit(UpdateUserDataSuccessCubitState());
        //     }
        //   },
        // );
      }

      emit(UpdateUserDataSuccessCubitState());
    } on Exception catch (e) {
      debugPrint('cubit-$e');
      emit(UpdateUserDataErrorCubitState());
    }
  }

  /// ! ........................................................................ ! ///

  void singup({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SingupLoadingCubitState());
    try {
      await DioHelper.postData(
        endPoint: UrlPaths.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      ).then(
        (response) async {
          log(response.runtimeType.toString());
          if (response!.statusCode == 200) {
            var collection = <String, dynamic>{};
            collection[UserTableColumnTitles.token] = response.data['token'];
            collection[UserTableColumnTitles.login] = false;
            collection.addAll(response.data['data'] as Map<String, dynamic>);
            userModel = UserModel.fromMap(collection);
            await _inserData();
            debugPrint(userModel.toString());
            emit(SingupSuccessCubitState());
          } else if (response.statusCode == 401) {
            errorMessageWhileSignup = response.data['massege']['email'][0];
            emit(SignupUnauthorizedCubitState(
                errorMessage: errorMessageWhileSignup));
          } else {
            emit(SingupErrorCubitState());
          }
        },
      );
    } catch (e) {
      debugPrint('cubit-$e');
      emit(SingupErrorCubitState(errorMessage: e.toString()));
    }
  }

  void logout() async {
    emit(SingupLoadingCubitState());
    await SqlHelper.deleteData(queryStatement: '''
              DELETE FROM ${UserTableColumnTitles.usersTable};
            ''');
    await SqlHelper.deleteData(queryStatement: '''
              DELETE FROM ${SavedJobTableColumnTitles.jobTable};
            ''');
    await SqlHelper.deleteData(queryStatement: '''
              DELETE FROM ${AppliedJobTableColumnTitles.jobTable};
            ''');
    userModel = null;
    emit(SingupSuccessCubitState());
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(SingupLoadingCubitState());
    try {
      await DioHelper.postData(
        endPoint: UrlPaths.login,
        data: {
          'email': email,
          'password': password,
        },
      ).then(
        (response) async {
          if (response!.statusCode == 200) {
            var collection = response.data as Map;
            collection.putIfAbsent('token', () => response.data['token']);
            collection[UserTableColumnTitles.login] = true;
            collection.addAll(response.data['user'] as Map);
            userModel = UserModel.fromMap(collection as Map<String, dynamic>);
            await _inserData();
            emit(SingupSuccessCubitState());
          } else if (response.statusCode == 401) {
            errorMessageWhileSignup = response.data['massage'];
            log('unAuthorized - $errorMessageWhileSignup');
            emit(SignupUnauthorizedCubitState(
                errorMessage: errorMessageWhileSignup));
          } else {
            log(response.statusCode.toString());
            emit(SingupErrorCubitState());
          }
        },
      );
    } catch (e) {
      debugPrint('cubit-$e');
      emit(SingupErrorCubitState());
      rethrow;
    }
  }

  Future<void> _inserData() async {
    // await SqlHelper.deleteData(queryStatement: '''
    //           DELETE FROM ${UserTableColumnTitles.usersTable};
    //         ''');
    await SqlHelper.insertData(queryStatement: '''
              INSERT INTO ${UserTableColumnTitles.usersTable}
              (${UserTableColumnTitles.id}, ${UserTableColumnTitles.name}, ${UserTableColumnTitles.otp}, ${UserTableColumnTitles.email}, ${UserTableColumnTitles.createdAt}, ${UserTableColumnTitles.token}, ${UserTableColumnTitles.login})
              VALUES (${userModel!.id}, '${userModel!.name}', ${userModel!.otp}, '${userModel!.email}', '${userModel!.createdAt}', '${userModel!.token}', ${userModel!.isLogin ? 1 : 0});
            ''');
  }

  /// ! ........................................................................ ! ///

  // update the checkbox state
  updateChecked() {
    checked = !checked;
    emit(ChangeCheckedCubitState());
  }
}
