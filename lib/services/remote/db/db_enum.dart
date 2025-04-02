enum DBTablesEnum {
  quizCategories(name: 'quiz_categories'),
  quizzes(name: 'quizzes');

  const DBTablesEnum({required this.name});

  final String name;
}

enum DBRpcEnum {
  quizCategories(name: 'get_quizzes_with_category');

  const DBRpcEnum({required this.name});

  final String name;
}
