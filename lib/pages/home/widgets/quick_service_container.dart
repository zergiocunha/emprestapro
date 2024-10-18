import 'package:auto_size_text/auto_size_text.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class QuickServiceContainer extends StatelessWidget {
  const QuickServiceContainer({
    super.key,
    required this.quickContainerIcon,
    required this.quickContainerTitle1,
    required this.onTap,
  });

  final IconData quickContainerIcon;
  final String quickContainerTitle1;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 90,
          decoration: const BoxDecoration(
            gradient: AppColors.background3D,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  quickContainerIcon,
                  color: AppColors.primaryText,
                  size: 36,
                ),
                AutoSizeText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  quickContainerTitle1,
                  style: const TextStyle(
                      color: AppColors.primaryText, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
