import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/controller/cubit/navigation_screens_cubit/navigation_screen_cubit.dart';
import 'package:job_finder/views/screens/home_screen_and_search/applied_screen.dart';
import 'package:job_finder/views/screens/home_screen_and_search/messages_screen.dart';
import 'package:job_finder/views/screens/home_screen_and_search/saved_screen.dart';

import '../profile_settings_screens/profile_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const MessagesScreen(),
    const AppliedScreen(),
    const SavedScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationScreenCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state],
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.message_outlined), label: 'Messages'),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.briefcase), label: 'Applied'),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.bookmark), label: 'Saved'),
              NavigationDestination(
                  icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
            ],
            selectedIndex: state,
            onDestinationSelected: (selectedIndex) {
              BlocProvider.of<NavigationScreenCubit>(context)
                  .updateNavigationIndex(selectedIndex);
            },
          ),
        );
      },
    );
  }
}
