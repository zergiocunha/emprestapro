// ignore_for_file: use_super_parameters

import 'package:emprestapro/common/constants/app_collors.dart';
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
  int _currentIndex = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        _currentIndex = widget.controller.page?.round() ?? 0;
      });
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
      shadowColor: AppColors.secoundaryBackground,
      color: AppColors.secoundaryBackground,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.children.length,
          (index) {
            final item = widget.children[index];
            final isSelected = index == _currentIndex;

            return Expanded(
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                onTap: () {
                  widget.controller.jumpToPage(index);
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(
                    isSelected ? item.primaryIcon : item.secondaryIcon,
                    size: 36.0,
                    color: isSelected
                        ? widget.selectedItemColor
                        : AppColors.secoundaryText,
                  ),
                ),
              ),
            );
          },
        ),
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
