import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreenCubit extends Cubit<int> {
  NavigationScreenCubit() : super(0);

  updateNavigationIndex(int newIndex) {
    emit(newIndex);
  }
}
