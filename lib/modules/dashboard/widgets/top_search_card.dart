import 'package:flutter/cupertino.dart';

import '../../../common/constants/image_path_constants.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_card.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../model/dashboard_data_response_model.dart';
import 'custom_title.dart';

class TopSearchCard extends StatelessWidget {
  const TopSearchCard({super.key, required this.topSearches});
  final TopSearches topSearches;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: AppSize.size450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSize.size20,
        children: [
          CustomTitle(
            assetName: SvgImages.topSearchIcon,
            title: topSearches.title,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSize.size15,
            children: topSearches.value.map((e) => Text16W500(e)).toList(),
          ),
          const SBH25(),
        ],
      ),
    );
  }
}
