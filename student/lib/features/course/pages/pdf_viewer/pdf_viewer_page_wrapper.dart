import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

import '../../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import 'bloc/pdf_viewer_bloc.dart';
import 'pdf_viewer_page.dart';

final class PdfViewerPageWrapper extends StatefulWidget {
  const PdfViewerPageWrapper({super.key});
  @override
  State<PdfViewerPageWrapper> createState() => _PdfViewerPageWrapperState();
}

final class _PdfViewerPageWrapperState extends State<PdfViewerPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      PdfViewerBloc,
      PdfViewerPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case PdfViewerFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: Builder(
        builder: (context) {
          final bloc = context.read<PdfViewerBloc>();
          final title = context.select(
            (PdfViewerBloc bloc) => bloc.state.title,
          );
          final contentUrl = context.select(
            (PdfViewerBloc bloc) => bloc.state.contentUrl,
          );
          final isLoading = context.select(
            (PdfViewerBloc bloc) => bloc.state.isLoading,
          );
          final isReady = context.select(
            (PdfViewerBloc bloc) => bloc.state.isReady,
          );
          final isCompleted = context.select(
            (PdfViewerBloc bloc) => bloc.state.isCompleted,
          );
          final isFailure = context.select(
            (PdfViewerBloc bloc) => bloc.state.isFailure,
          );
          final errorMessage = context.select(
            (PdfViewerBloc bloc) => bloc.state.errorMessage,
          );

          final user = context.select(
            (AppAuthenticationCubit cubit) => cubit.state,
          );
          final watermarkText = user != null
              ? '${user.fullName}\n${user.phoneNumber}'
              : null;

          return PdfViewerPage(
            title: title,
            contentUrl: contentUrl,
            isLoading: isLoading,
            isReady: isReady,
            isCompleted: isCompleted,
            errorMessage: isFailure ? errorMessage : null,
            watermarkText: watermarkText,
            onMarkComplete: () => bloc.add(const PdfViewerCompleted()),
          );
        },
      ),
    );
  }
}
