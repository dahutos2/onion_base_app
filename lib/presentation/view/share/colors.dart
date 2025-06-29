import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// 色を管理するクラス
///
/// (例) `ColorType.header.background`
class ColorType {
  ColorType._();

  static const base = ColorsBase();

  static const common = ColorsCommon();

  static const header = ColorsHeader();

  static const footer = ColorsFooter();

  static const home = ColorsHome();
}

class ColorsBase {
  const ColorsBase();

  Color get background => const Color(0xFFF3E5E5);
}

class ColorsCommon {
  const ColorsCommon();
}

class ColorsHeader {
  const ColorsHeader();
}

class ColorsFooter {
  const ColorsFooter();
}

class ColorsHome {
  const ColorsHome();
}
