import 'package:auto_size_text/auto_size_text.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class ConsumerContainer extends StatelessWidget {
  final String consumerName;
  final String phoneNumber;
  final String email;
  final String imageUrl;

  const ConsumerContainer({
    super.key,
    required this.consumerName,
    required this.phoneNumber,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGreen3D,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secoundaryBackground,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: imageUrl != "" ? NetworkImage(imageUrl) : null,
              backgroundColor: AppColors.primaryText,
              child: const Icon(
                Icons.person,
                color: AppColors.secoundaryBackground,
                size: 40,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    consumerName,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  AutoSizeText(
                    phoneNumber,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  AutoSizeText(
                    email,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
