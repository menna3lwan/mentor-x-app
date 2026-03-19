part of '../../mentorx_core.dart';

/// Pagination parameters for list/paginated repository methods.
final class MentorXPaginationInfo extends Equatable {
  final int? limit;
  final int? page;
  final String? cursor;

  const MentorXPaginationInfo({this.limit, this.page, this.cursor});

  @override
  List<Object?> get props => [limit, page, cursor];

  Map<String, dynamic> toJson() => {
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
        if (cursor != null) 'cursor': cursor,
      };
}
