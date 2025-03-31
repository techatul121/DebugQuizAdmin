extension JsonExtensions on Map<String, dynamic> {
  ///Remove keys with null value.
  Map<String, dynamic> removeNullOrEmpty() {
    removeWhere((String key, dynamic value) => value == null || value == '');
    return this;
  }

  Map<String, dynamic> removeKeys({List<String> keys = const []}) {
    for (var key in keys) {
      removeWhere((String k, dynamic v) => k == key);
    }
    return this;
  }
}
