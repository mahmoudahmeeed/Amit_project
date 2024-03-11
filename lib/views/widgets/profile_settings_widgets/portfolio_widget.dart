import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/controller/cubit/edit_profile_screens_cubit/file_path_cubit.dart';

class PortfolioWidget extends StatefulWidget {
  final int index;
  const PortfolioWidget({super.key, required this.index, this.onSelected});
  final void Function()? onSelected;
  @override
  State<PortfolioWidget> createState() => _PortfolioWidgetState();
}

class _PortfolioWidgetState extends State<PortfolioWidget> {
  late List<FileContent> files;
  @override
  initState() {
    super.initState();
    files = BlocProvider.of<FilePathCubit>(context).files;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: BlocProvider.of<FilePathCubit>(context).selectedFileIndex ==
                widget.index
            ? const Color.fromRGBO(214, 228, 255, 1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(209, 213, 219, 1),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        leading: Image.asset('assets/images/icons/pdf_logo.png'),
        title: Text(
          files[widget.index].name,
          style: const TextStyle(
            color: Color.fromRGBO(17, 24, 39, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: BlocBuilder<FilePathCubit, FilePathCubitState>(
          buildWhen: (previous, current) {
            if (current is SelectedFileSuccessCubitState) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return Text(
              BlocProvider.of<FilePathCubit>(context).files[widget.index].size,
              style: const TextStyle(
                color: Color.fromRGBO(107, 114, 128, 1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
        trailing: IconButton(
          icon: const Icon(
            FontAwesomeIcons.fileCircleXmark,
            color: Color.fromRGBO(255, 106, 83, 1),
          ),
          onPressed: () {
            BlocProvider.of<FilePathCubit>(context).removePdfFile(widget.index);
          },
        ),
      ),
    );
  }
}
