import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

mixin CustomModalSheetMixin<T extends StatefulWidget> on State<T> {
  Future<bool?> showCustomModalBottomSheet({
    required BuildContext context,
    required String content,
    String? buttonText,
    VoidCallback? onPressed,
    List<Widget>? actions,
    bool isDismissible = true,
  }) {
    assert(buttonText != null || actions != null);

    return showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(38.0),
          topRight: Radius.circular(38.0),
        ),
      ),
      builder: (BuildContext context) {
        return PopScope(
          canPop: isDismissible,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryText,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(38.0),
                topRight: Radius.circular(38.0),
              ),
            ),
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    child: Text(
                      content,
                      style: const TextStyle()
                          .copyWith(color: AppColors.primaryGreen),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    child: actions != null ? 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: actions,)
                    :CustomElevatedButton(
                      label: buttonText!,
                      onPressed: onPressed ?? () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
