import 'package:flutter/material.dart';

class Sizes {
  Sizes._();

  double _width = 0;
  double _heigth = 0;

  static const Size _designerSize = Size(414.0, 896.0);

  static final Sizes _instance = Sizes._();

  factorySizes() => _instance;

  double get width => _width;
  double get height => _heigth;

  static void init(
    BuildContext context, {
    Size designSize = _designerSize,
  }) {
    final deviceData = MediaQuery.maybeOf(context);

    final deviceSize = deviceData?.size ?? _designerSize;

    _instance._heigth = deviceSize.height;
    _instance._width = deviceSize.width;
  }
}

extension SizesExt on num {
  double get w {
    return (this * Sizes._instance._width) / Sizes._designerSize.width;
  }

  double get h {
    return (this * Sizes._instance.height) / Sizes._designerSize.height;
  }
}
