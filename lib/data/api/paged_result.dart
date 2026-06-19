/// A page of results plus the total count reported by the backend's
/// `X-Total-Count` header, so the UI can paginate / show totals.
class PagedResult<T> {
  const PagedResult({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  final List<T> items;
  final int total;
  final int page;
  final int pageSize;

  /// Whether more pages remain beyond the ones already loaded.
  bool get hasMore => page * pageSize < total;
}
