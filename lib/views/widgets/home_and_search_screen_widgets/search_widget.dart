import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onSearch, this.searchController});
  final TextEditingController? searchController;
  final void Function()? onSearch;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          onSearch!();
        }
      },
      decoration: InputDecoration(
        hintText: 'search...',
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromRGBO(209, 213, 219, 1),
            width: 1,
          ),
        ),
        prefixIcon: InkWell(
          onTap: onSearch,
          child: const Icon(
            Icons.search_outlined,
            color: Color.fromRGBO(41, 45, 50, 1),
          ),
        ),
        suffixIcon: InkWell(
          onTap: () {
            searchController!.clear();
          },
          child: const Icon(
            FontAwesomeIcons.xmark,
            color: Color.fromRGBO(41, 45, 50, 1),
          ),
        ),
      ),
    );
  }
}
