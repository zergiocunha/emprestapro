import 'package:auto_size_text/auto_size_text.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class DescriptionValueWidget extends StatelessWidget {
  const DescriptionValueWidget({
    super.key,
    required this.descrtiption,
    required this.value,
    this.descriptionSize,
  });

  final String descrtiption;
  final String value;
  final double? descriptionSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: 120,
              child: AutoSizeText(
                descrtiption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: descriptionSize != null ? 32 : 25,
              width: descriptionSize ?? 120,
              child: AutoSizeText(
                value,
                maxLines: descriptionSize != null ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
