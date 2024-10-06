// ignore_for_file: use_super_parameters

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/extensions/page_controller_ext.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatefulWidget {
  final PageController controller;
  final Color? selectedItemColor;
  final List<CustomBottomAppBarItem> children;
  const CustomBottomAppBar({
    Key? key,
    this.selectedItemColor,
    required this.children,
    required this.controller,
  })  : assert(children.length >= 2, 'children.length must be 2'),
        super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shadowColor: AppColors.background,
      color: AppColors.secoundaryBackground,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map(
          (item) {
            bool currentItem;
            currentItem = widget.children.indexOf(item) ==
                widget.controller.selectedBottomAppBarItemIndex;
            return Expanded(
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                onTap: item.onPressed,
                onTapUp: (_) {
                  widget.controller.setBottomAppBarItemIndex =
                      widget.children.indexOf(item);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(
                    size: 36.0,
                    currentItem ? item.primaryIcon : item.secondaryIcon,
                    color: currentItem
                        ? widget.selectedItemColor
                        : AppColors.secoundaryText,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final String? label;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final VoidCallback? onPressed;

  CustomBottomAppBarItem({
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });

  CustomBottomAppBarItem.empty({
    this.label,
    this.secondaryIcon,
    this.primaryIcon,
    this.onPressed,
  });
}
