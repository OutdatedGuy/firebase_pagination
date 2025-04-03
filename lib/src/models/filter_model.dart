/// A class for creating a search filter model in [FirestorePagination]
class FilterModel {
  /// Creates a [FilterModel] object
  FilterModel({
    required this.fieldName,
    required this.searchValue,
    final bool Function(String, String)? match,
  }):
      match = match ?? ((value, search) =>
          value.toLowerCase().contains(search.toLowerCase()));

  /// The name of the field in collection to be searched.
  final String fieldName;

  /// The substring that is intented to search in [fieldName] value.
  final String searchValue;

  /// A function to compare [searchValue] with the value of [fieldName].
  ///
  /// Defaults to a case-insensitive substring search.
  bool Function(String, String) match;
}
