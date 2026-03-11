part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PdfViewerPageRoute>(
  path: '/pdf-viewer/:itemId',
  name: 'pdfViewer',
)
final class PdfViewerPageRoute extends GoRouteData with $PdfViewerPageRoute {
  final String itemId;
  final String title;

  const PdfViewerPageRoute({required this.itemId, required this.title});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PdfViewerPageBloc>(
      create: (context) => PdfViewerPageBloc(
        courseRepository: context.read<CourseRepository>(),
        itemId: itemId,
        title: title,
      )..add(const PdfViewerPageInitialized()),
      child: const PdfViewerPageWrapper(),
    );
  }
}
