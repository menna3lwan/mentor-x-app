/// Parent-app-only cache keys.
///
/// The shared [CacheKeys] in `mentorx_core` covers keys used by both Student
/// and Parent apps (user, tokens, locale, ...). Anything specific to Parent
/// belongs here so the shared package stays free of app-scoped concerns.
final class ParentCacheKeys {
  ParentCacheKeys._();

  /// Last child the parent selected on the dashboard. Re-applied on launch
  /// so the parent lands on the same child they were viewing previously.
  static const String selectedChildId = 'parent_selected_child_id';

  /// Whether the parent has any linked children, cached at login so the UI
  /// can skip the "find your child first" gate when navigating back into
  /// dashboards on subsequent sessions.
  static const String hasLinkedChildren = 'parent_has_linked_children';
}
