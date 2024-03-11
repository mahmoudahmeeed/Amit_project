import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../../screens/profile_settings_screens/set_notification_screen.dart';

class TitleHomeScreen extends StatelessWidget {
  const TitleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${BlocProvider.of<SignupLoginScreenCubit>(context).userModel?.name}👋',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Create a better future for yourself here',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            iconSize: 16,
            style: const ButtonStyle(
              side: MaterialStatePropertyAll(
                BorderSide(
                  color: Color.fromRGBO(209, 213, 219, 1),
                  width: 1,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SetNotificationScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.notifications,
              color: Color.fromRGBO(41, 45, 50, 1),
            ),
          ),
        ],
      ),
    );
  }
}
