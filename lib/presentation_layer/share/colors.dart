import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

/// 色を管理するクラス
///
/// (例) `ColorType.header.background`
class ColorType {
  ColorType._();

  static const base = ColorsBase();

  static const common = ColorsCommon();

  static const header = ColorsHeader();

  static const footer = ColorsFooter();

  static const page01 = ColorsPage01();
}

class ColorsBase {
  const ColorsBase();

  Color get background => const Color(0xFFF3E5E5);
}

class ColorsCommon {
  const ColorsCommon();

  Color get alertDialogBack => const Color(0xFF393939);
  Color get alertDialogBorder => const Color(0x99FFFFFF);
  Color get createDialogBack => const Color(0xFFFFFFFF);
  Color get createDialogFrontBack => const Color(0xFFD9D9D9);
  Color get createDialogDone => const Color(0xFF6976E9);
  Color get createDialogDoneDisable => const Color(0xFF4F59AF);
}

class ColorsHeader {
  const ColorsHeader();

  Color get background => const Color(0xFF383689);
}

class ColorsFooter {
  const ColorsFooter();

  Color get background => const Color(0xFF383689);
  Color get item => const Color(0xFFFFFFFF);
  Color get disabledItem => const Color(0xFFAAAAAA);
  Color get unselectedItem => const Color(0xFFFFFFFF);
}

class ColorsPage01 {
  const ColorsPage01();

  Color get addSampleButton => const Color(0xFF898DE0);
  Color get listSampleBack => const Color(0xFFFAFAFA);
  Color get searchTextBoxBack => const Color(0xFFB8B8B8);
  Color get searchTextBoxFilled => const Color(0xFFFFFFFF);
  Color get editSampleBack => const Color(0xFFFAFAFA);
  Color get editSampleCheckBorder => const Color(0xFFB1B1B1);
  Color get editTextBoxFilled => const Color(0xFFFFFFFF);
}
