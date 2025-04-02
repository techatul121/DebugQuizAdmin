import 'package:flutter/material.dart';

import '../../../common/constants/app_strings_constants.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../widgets/category_data_grid.dart';

class QuestionView extends StatelessWidget {
  static const String path = '/questions';
  static const String name = 'questions';
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.size20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text36W400(AppStrings.category),
        Expanded(child: CategoryDataGrid()),
      ],
    );
  }
}
