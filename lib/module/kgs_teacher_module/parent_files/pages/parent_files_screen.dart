import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/loading_indicator.dart';
import '../../../../core/di/service_locator.dart';
import '../cubits/parent_files_cubit.dart';
import '../cubits/parent_files_state.dart';

class ParentFilesScreen extends StatefulWidget {
  const ParentFilesScreen({super.key});

  @override
  State<ParentFilesScreen> createState() => _ParentFilesScreenState();
}

class _ParentFilesScreenState extends State<ParentFilesScreen> {
  String getFileType(String url) {
    if (url.endsWith('.png') ||
        url.endsWith('.jpg') ||
        url.endsWith('.jpeg') ||
        url.endsWith('.gif')) {
      return 'image';
    } else if (url.endsWith('.pdf')) {
      return 'pdf';
    } else {
      return 'other';
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url.toString()))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentFilesCubit(sl())..getParentFiles(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Parent Files List')),
        body: BlocBuilder<ParentFilesCubit, ParentFilesState>(
          builder: (context, state) {
            if (state.status == ParentFilesStatus.loading) {
              return const Center(child: LoadingIndicator());
            }
            if (state.status == ParentFilesStatus.failure) {
              return Center(child: Text(state.message));
            }
            if (state.status == ParentFilesStatus.success) {
              return state.parentFiles.isNotEmpty
                  ? ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: state.parentFiles.length,
                    itemBuilder: (context, index) {
                      final item = state.parentFiles[index];
                      final fileUrl = item.fileDownloadLink;
                      final studentName = item.studentName;
                      final text = item.text;
                      final fileType = getFileType(fileUrl);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          title: Text(
                            studentName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          trailing: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  fileType == 'image'
                                      ? Colors.transparent
                                      : Colors.grey[300],
                            ),
                            child:
                                fileType == 'image'
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        fileUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : Icon(
                                      fileType == 'pdf'
                                          ? Icons.picture_as_pdf
                                          : fileType == 'video'
                                          ? Icons.video_library
                                          : Icons.insert_drive_file,
                                      color:
                                          fileType == 'pdf'
                                              ? Colors.red
                                              : Colors.grey[700],
                                      size: 35,
                                    ),
                          ),
                          onTap: () {
                            _launchUrl(fileUrl);
                          },
                        ),
                      );
                    },
                  )
                  : const Center(child: Text("Date not found!"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// Image Viewer Page
class ImageViewer extends StatelessWidget {
  final String fileUrl;

  const ImageViewer({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Viewer")),
      body: Center(child: Image.network(fileUrl)),
    );
  }
}

// PDF Viewer Page
class PdfViewerPage extends StatefulWidget {
  final String fileUrl;

  const PdfViewerPage({super.key, required this.fileUrl});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      // body: SfPdfViewer.network(widget.fileUrl),
    );
  }
}
