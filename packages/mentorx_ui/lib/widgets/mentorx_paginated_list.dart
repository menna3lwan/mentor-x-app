part of '../mentorx_ui.dart';

final class MentorXPaginatedList extends StatefulWidget {
  final double threshold;
  final bool hasReachedMax;
  final VoidCallback onPaginationTriggered;
  final ScrollController? scrollController;
  final Widget Function(BuildContext context, ScrollController scrollController)
      builder;

  const MentorXPaginatedList({
    super.key,
    this.threshold = 0.7,
    required this.builder,
    required this.hasReachedMax,
    required this.onPaginationTriggered,
    this.scrollController,
  });

  @override
  State<MentorXPaginatedList> createState() => _MentorXPaginatedListState();
}

class _MentorXPaginatedListState extends State<MentorXPaginatedList> {
  ScrollController? _internalScrollController;
  bool _hasTriggeredPagination = false;

  ScrollController get _scrollController =>
      widget.scrollController ?? _internalScrollController!;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _internalScrollController = ScrollController();
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(MentorXPaginatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle scroll controller changes
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      _internalScrollController?.removeListener(_onScroll);

      if (widget.scrollController == null && _internalScrollController == null) {
        _internalScrollController = ScrollController();
      } else if (widget.scrollController != null) {
        _internalScrollController?.dispose();
        _internalScrollController = null;
      }

      _scrollController.addListener(_onScroll);
    }
    // Reset trigger flag when hasReachedMax changes or when new data is loaded
    if (oldWidget.hasReachedMax != widget.hasReachedMax) {
      _hasTriggeredPagination = false;
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Special case for empty or small lists where maxScroll is 0
    if (maxScroll <= 0) return true;
    return currentScroll >= (maxScroll * widget.threshold);
  }

  void _onScroll() {
    // Skip if already reached max
    if (widget.hasReachedMax) return;

    if (_isBottom) {
      // Only trigger once when reaching bottom
      if (!_hasTriggeredPagination) {
        _hasTriggeredPagination = true;
        widget.onPaginationTriggered();
      }
    } else {
      // Reset flag when user scrolls away from bottom
      _hasTriggeredPagination = false;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _internalScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _scrollController);
  }
}
