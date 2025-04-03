/// A class for creating a search filter model in [FirestorePagination]
class FilterModel {
  /// Creates a [FilterModel] object
  FilterModel({
    required this.fieldName,
    required this.searchValue,
    this.fuzzySearch = false,
  });

  /// The name of the field in collection to be searched.
  final String fieldName;

  /// The substring that is intented to search in [fieldName] value.
  final String searchValue;

  /// If true, the search will be fuzzy, based on the similarity of the strings.
  /// Uses the package [string_similarity](https://pub.dev/packages/string_similarity).
  final bool fuzzySearch;
}
