import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';
import 'package:job_finder/controller/utils/shared_helper.dart';
import 'package:job_finder/root/root_app.dart';
import 'controller/utils/sql_helper/sql_helper.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  SharedHelper.init();
  await SqlHelper.init();
  runApp(const Root());
}
