extension IterableExtension<T> on Iterable<T> {
  /// Returns the first element that satisfies the given [test] or `null` if
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Returns a new list containing the elements at the specified [indices].
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this) {
      yield convert(index++, element);
    }
  }
}
