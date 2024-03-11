import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardScreenCubit extends Cubit<int> {
  OnBoardScreenCubit() : super(0);

  updateScreenIndex(int newIndex) {
    emit(newIndex);
  }
}
