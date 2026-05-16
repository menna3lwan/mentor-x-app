part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PdfViewerPageRoute>(
  path: '/pdf-viewer/:itemId',
  name: 'pdfViewer',
)
final class PdfViewerPageRoute extends GoRouteData with $PdfViewerPageRoute {
  final String itemId;
  final String title;
  final String? enrollmentId;
  final int completedLessons;
  final int totalLessons;

  const PdfViewerPageRoute({
    required this.itemId,
    required this.title,
    this.enrollmentId,
    this.completedLessons = 0,
    this.totalLessons = 0,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PdfViewerPageBloc>(
      create: (context) => PdfViewerPageBloc(
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        itemId: itemId,
        title: title,
        enrollmentId: enrollmentId,
        completedLessons: completedLessons,
        totalLessons: totalLessons,
      )..add(const PdfViewerPageInitialized()),
      child: const PdfViewerPageWrapper(),
    );
  }
}
