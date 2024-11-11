class FilterModel {
  /// The name of the field in collection to be searched.
  final String fieldName;

  /// The substring that is intented to search in [fieldName] value.
  final String searchValue;

  /// Creates a object that contains the properties of the [FilterModel] model.
  FilterModel({required this.fieldName, required this.searchValue});
}
