/// A class for creating a search filter model in [FirestorePagination]
class FilterModel {
  /// Creates a [FilterModel] object
  FilterModel({required this.fieldName, required this.searchValue});

  /// The name of the field in collection to be searched.
  final String fieldName;

  /// The substring that is intented to search in [fieldName] value.
  final String searchValue;
}
