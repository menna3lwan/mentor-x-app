part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PdfViewerRoute>(
  path: '/pdf-viewer/:itemId',
  name: 'pdfViewer',
)
final class PdfViewerRoute extends GoRouteData with $PdfViewerRoute {
  final String itemId;
  final String title;
  final String? enrollmentId;
  final int completedLessons;
  final int totalLessons;
  final String? contentUrl;

  const PdfViewerRoute({
    required this.itemId,
    required this.title,
    this.enrollmentId,
    this.completedLessons = 0,
    this.totalLessons = 0,
    this.contentUrl,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PdfViewerBloc>(
      create: (context) => PdfViewerBloc(
        courseRepository: context.read<CourseRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        itemId: itemId,
        title: title,
        enrollmentId: enrollmentId,
        completedLessons: completedLessons,
        totalLessons: totalLessons,
        contentUrl: contentUrl,
      )..add(const PdfViewerInitialized()),
      child: const PdfViewerPageWrapper(),
    );
  }
}
