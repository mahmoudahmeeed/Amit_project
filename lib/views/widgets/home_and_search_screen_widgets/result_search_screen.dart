import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/app_images.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../model/job_model/job_model.dart';
import 'job_title_widget.dart';

class ResultOfSearchScreen extends StatefulWidget {
  const ResultOfSearchScreen({super.key, required this.resultSearch});
  final List<JobModel> resultSearch;

  @override
  State<ResultOfSearchScreen> createState() => _ResultOfSearchScreenState();
}

class _ResultOfSearchScreenState extends State<ResultOfSearchScreen> {
  bool fullTimeTapped = false;
  bool partTimeTapped = false;
  bool seniorTapped = false;
  bool juniorTapped = false;
  late List<JobModel> resultFilterSearch;
  @override
  void initState() {
    resultFilterSearch = [...widget.resultSearch];
    super.initState();
  }

  @override
  dispose() {
    fullTimeTapped = false;
    partTimeTapped = false;
    seniorTapped = false;
    juniorTapped = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                IconButton(
                  onPressed: () {
                    // show modal bottom sheet
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      showDragHandle: true,
                      enableDrag: true,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: StatefulBuilder(builder: (context, setState) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 24,
                                  child: Row(
                                    children: [
                                      BackButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          fullTimeTapped = false;
                                          partTimeTapped = false;
                                          seniorTapped = false;
                                          juniorTapped = false;
                                        },
                                      ),
                                      const Center(
                                        child: Text(
                                          'Set Filter',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(17, 24, 39, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        fullTimeTapped = !fullTimeTapped;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: fullTimeTapped
                                                ? const Color(0xffE5E7EB)
                                                : const Color.fromRGBO(
                                                    9, 26, 122, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'Full Time',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                107, 114, 128, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        partTimeTapped = !partTimeTapped;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: !partTimeTapped
                                                ? const Color(0xffE5E7EB)
                                                : const Color.fromRGBO(
                                                    9, 26, 122, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'Part Time',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                107, 114, 128, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        seniorTapped = !seniorTapped;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: !seniorTapped
                                                ? const Color(0xffE5E7EB)
                                                : const Color.fromRGBO(
                                                    9, 26, 122, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'Senior Level',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                107, 114, 128, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        juniorTapped = !juniorTapped;
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: !juniorTapped
                                                ? const Color(0xffE5E7EB)
                                                : const Color.fromRGBO(
                                                    9, 26, 122, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          'Junior Level',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                107, 114, 128, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Center(
                                  child: CustomButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setFilter();
                                    },
                                    text: 'Show result',
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          }),
                        );
                      },
                    );
                  },
                  icon: Image.asset(Assets.imagesIconsFilterSearch),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    fullTimeTapped = !fullTimeTapped;
                    setFilter();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !fullTimeTapped
                            ? const Color(0xffE5E7EB)
                            : const Color.fromRGBO(9, 26, 122, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Full Time',
                      style: TextStyle(
                        color: Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    partTimeTapped = !partTimeTapped;
                    setFilter();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !partTimeTapped
                            ? const Color(0xffE5E7EB)
                            : const Color.fromRGBO(9, 26, 122, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Part Time',
                      style: TextStyle(
                        color: Color.fromRGBO(107, 114, 128, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F5),
              border: Border.all(
                color: const Color(0xffE5E7EB),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Featuring ${resultFilterSearch.length} Jobs',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: resultFilterSearch.length,
              itemBuilder: (context, index) {
                return JobTitleWidget(
                  jobModel: widget.resultSearch[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void setFilter() {
    resultFilterSearch = [...widget.resultSearch];
    if (fullTimeTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobTimeType == 'Full time')
          .toList();
    }
    if (partTimeTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobTimeType == 'Part time')
          .toList();
    }
    if (juniorTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobLevel == 'junior')
          .toList();
    }
    if (seniorTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobLevel == 'senior')
          .toList();
    }
    log(resultFilterSearch.length.toString());
    if (!fullTimeTapped && !partTimeTapped && !juniorTapped && !seniorTapped) {
      resultFilterSearch = [...widget.resultSearch];
    }
    log(resultFilterSearch.length.toString());

    setState(() {});
  }
}
