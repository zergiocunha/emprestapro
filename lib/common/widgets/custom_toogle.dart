import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String onText;
  final String offText;
  final Color colorOn;
  final Color colorOff;

  const CustomToggle({
    Key? key,
    this.initialValue = false,
    required this.onChanged,
    required this.onText,
    required this.offText,
    this.colorOn = AppColors.primaryGreen,
    this.colorOff = AppColors.primaryRed,
  }) : super(key: key);

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
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        constraints: BoxConstraints(
          minWidth: 80, // Largura mínima
          maxWidth: MediaQuery.of(context).size.width * 0.8, // Largura máxima
        ),
        height: 55,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: _isOn ? widget.colorOn : widget.colorOff,
        ),
        child: Stack(
          children: [
            // Texto
            Align(
              alignment: _isOn ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  _isOn ? widget.onText : widget.offText,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2, // Permite até 2 linhas
                  overflow: TextOverflow
                      .ellipsis, // Adiciona "..." se o texto for muito longo
                  softWrap: true, // Permite quebra de linha
                ),
              ),
            ),
            // Botão circular
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: _isOn ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 30,
                  height: 30,
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
    );
  }
}
