extension StringExtensions on String {
  String toTitleCase() {
    return trim()
        .split(RegExp(r'\s+'))
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                  : '',
        )
        .join(' ');
  }
}
