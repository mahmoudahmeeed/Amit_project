import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/utils/app_images.dart';

import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../../model/job_model/job_model.dart';
import '../../widgets/home_and_search_screen_widgets/recent_suggest_search_jobs_widget.dart';
import '../../widgets/home_and_search_screen_widgets/result_search_screen.dart';
import '../../widgets/home_and_search_screen_widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<JobDataCubit>(context).getRecentSearch();
  }

  final TextEditingController _searchController = TextEditingController();
  List<JobModel> resultSearch = [];

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: SearchWidget(
          searchController: _searchController,
          onSearch: () {
            if (_searchController.text.isNotEmpty) {
              resultSearch = context
                  .read<JobDataCubit>()
                  .recentJobs
                  .where(
                    (element) => element.name.toLowerCase().contains(
                          _searchController.text.trim().toLowerCase(),
                        ),
                  )
                  .toList();
              context
                  .read<JobDataCubit>()
                  .addRecentSearch(_searchController.text);
              setState(() {});
            }
          },
        ),
      ),
      body: _searchController.text.isNotEmpty
          ? Builder(
              builder: (context) {
                if (resultSearch.isNotEmpty) {
                  return ResultOfSearchScreen(resultSearch: resultSearch);
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset(Assets.imagesLargeImagesSearchNotFound),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Search not found',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Try searching with different keywords so we can show you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(107, 114, 128, 1),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<JobDataCubit, JobDataState>(
                      buildWhen: (previous, current) {
                        if (current is RecentSearchSuccess ||
                            current is RecentSearchError ||
                            current is RecentSearchSuccess) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        if (state is RecentSearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is RecentSearchError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        context.read<JobDataCubit>().getRecentSearch();
                        var recentSearch =
                            context.read<JobDataCubit>().recentSearch;
                        if (recentSearch.isNotEmpty) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 36,
                                width: double.infinity,
                                color: const Color.fromRGBO(244, 244, 245, 1),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Recent Search',
                                    style: TextStyle(
                                      color: Color.fromRGBO(107, 114, 128, 1),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: recentSearch.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: RecentSuggestWidget(
                                        jobTitle: recentSearch[index],
                                        isRecent: true,
                                        index: index,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 36,
                      width: double.infinity,
                      color: const Color.fromRGBO(244, 244, 245, 1),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Popular searches',
                          style: TextStyle(
                            color: Color.fromRGBO(107, 114, 128, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                        itemCount: 3,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: RecentSuggestWidget(
                              jobTitle: context
                                  .read<JobDataCubit>()
                                  .recentJobs[index]
                                  .name,
                              isRecent: false,
                              index: index,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
