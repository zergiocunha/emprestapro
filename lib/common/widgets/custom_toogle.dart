// ignore_for_file: library_private_types_in_public_api

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String description;
  final Color colorOn;
  final Color colorOff;

  const CustomToggle({
    super.key,
    this.initialValue = false,
    required this.onChanged,
    required this.description,
    this.colorOn = AppColors.primaryGreen,
    this.colorOff = AppColors.primaryRed,
  });

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;
  }

  void _toggleSwitch() {
    setState(() {
      _isOn = !_isOn;
    });
    widget.onChanged(_isOn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Texto acima do switch
        Text(
          widget.description,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4), // Espaço entre o texto e o switch
        GestureDetector(
          onTap: _toggleSwitch,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50, // Largura compacta
            height: 25, // Altura compacta
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: _isOn ? widget.colorOn : widget.colorOff,
            ),
            child: Stack(
              children: [
                // Botão circular
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment:
                      _isOn ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 20, // Botão circular menor
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
