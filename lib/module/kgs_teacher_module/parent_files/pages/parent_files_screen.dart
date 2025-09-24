import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/cubits/parent_files_cubit.dart'; // import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/models/parent_file_input.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/models/parent_files_response.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../daily_diary/models/work_type.dart';
import '../cubits/parent_files_state.dart';
import '../widget/parent_tile_widget.dart';

class ParentFilesScreen extends StatelessWidget {
  const ParentFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentFilesCubit(sl()),
      child: ParentFileScreenView(),
    );
  }
}

class ParentFileScreenView extends StatefulWidget {
  const ParentFileScreenView({super.key});

  @override
  State<ParentFileScreenView> createState() => _ParentFileScreenViewState();
}

class _ParentFileScreenViewState extends State<ParentFileScreenView> {
  final int _next = 10;
  int offset = 0;

  returnOffset() {
    offset += _next;
    return offset;
  }

  List<WorkType> types = [
    WorkType(type: "All", id: 0),
    WorkType(type: "Assignemnt", id: 2),
    WorkType(type: "Punishment", id: 1),
  ];
  WorkType? selectedWorkType;

  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    ParentFileInput input = ParentFileInput(
      offSet: returnOffset(),
      next: _next,
      type: selectedWorkType != null ? selectedWorkType?.id : 0,
    );
    context.read<ParentFilesCubit>().getParentFiles(input);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        ParentFileInput input = ParentFileInput(
          offSet: returnOffset(),
          next: _next,
          type: selectedWorkType != null ? selectedWorkType?.id : 0,
        );
        Future.wait([
          context.read<ParentFilesCubit>().getParentFiles(input, loadMore: true)
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppbar(
        'Parent File',
        centerTitle: true,
      ),
      backgroundColor: AppColors.primaryGreen,
      hMargin: 0,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20) +
            const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Column(
          children: [
            GeneralCustomDropDown<WorkType>(
              hint: "Select Work Type",
              items: types,
              allPadding: 0,
              horizontalPadding: 15,
              isOutline: false,
              hintColor: AppColors.primaryGreen,
              iconColor: AppColors.primaryGreen,
              suffixIconPath: '',
              displayField: (v) => v.type,
              onSelect: (v) {
                setState(() {
                  selectedWorkType = v;
                });
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            BlocBuilder<ParentFilesCubit, ParentFilesState>(
                builder: (context, state) {
              if (state.status == ParentFilesStatus.loading) {
                return Expanded(
                  child: Center(
                    child: LoadingIndicator(),
                  ),
                );
              }
              if (state.status == ParentFilesStatus.success ||
                  state.status == ParentFilesStatus.loadMore) {
                if (state.parentFiles.isNotEmpty) {
                  return Expanded(
                      child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.parentFiles.length,
                    itemBuilder: (context, index) {
                      ParentsFileList model = state.parentFiles[index];
                      return ParentFileExpansionTile(model: model);
                    },
                  ));
                } else {
                  return Expanded(
                      child: Center(
                          child: Text(
                    "No Data Available",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  )));
                }
              }
              if (state.status == ParentFilesStatus.failure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Expanded(child: SizedBox());
            }),
            SizedBox(
              height: 12.0,
            ),
            CustomButton(
                onPressed: () {
                  offset = 0;
                  ParentFileInput input = ParentFileInput(
                      offSet: offset,
                      next: _next,
                      type:
                          selectedWorkType != null ? selectedWorkType?.id : 0);
                  context.read<ParentFilesCubit>().getParentFiles(input);
                },
                title: "Get Parent Files")
          ],
        ),
      ),
    );
  }
}

// // Image Viewer Page
// class ImageViewer extends StatelessWidget {
//   final String fileUrl;
//
//   const ImageViewer({super.key, required this.fileUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Image Viewer")),
//       body: Center(
//         child: Image.network(fileUrl),
//       ),
//     );
//   }
// }
//
// // PDF Viewer Page
// class PdfViewerPage extends StatefulWidget {
//   final String fileUrl;
//
//   const PdfViewerPage({super.key, required this.fileUrl});
//
//   @override
//   State<PdfViewerPage> createState() => _PdfViewerPageState();
// }
//
// class _PdfViewerPageState extends State<PdfViewerPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("PDF Viewer")),
//       // body: SfPdfViewer.network(widget.fileUrl),
//     );
//   }
// }
