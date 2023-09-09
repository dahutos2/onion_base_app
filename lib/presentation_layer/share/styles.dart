import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

/// 文字を管理するクラス
///
/// (例) `StyleType.header.title`
class StyleType {
  StyleType._();

  static const common = StylesCommon();

  static const header = StylesHeader();

  static const footer = StylesFooter();

  static const page01 = StylesPage01();
}

class StylesCommon {
  const StylesCommon();
  TextStyle get alertDialogTitle => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF));
  TextStyle get alertDialogSubTitle =>
      const TextStyle(fontSize: 12, color: Color(0xFFFFFFFF));
  TextStyle get alertDialogDone => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFF0000));
  TextStyle get alertDialogCancel => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3093DA));
  TextStyle get createDialogTitle => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF373737));
  TextStyle get createDialogDone => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF));
  TextStyle get createDialogDoneDisable => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFAAAAAA));
  TextStyle get createDialogHintText => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFB8B8B8));
  TextStyle get createDialogInput => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF000000));
}

class StylesHeader {
  const StylesHeader();

  TextStyle get title => const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF));
  TextStyle get editComplete =>
      const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF));
}

class StylesFooter {
  const StylesFooter();

  TextStyle get label =>
      const TextStyle(fontSize: 13, color: Color(0xFFFFFFFF));
  TextStyle get disabledLabel =>
      const TextStyle(fontSize: 13, color: Color(0xFFAAAAAA));
}

class StylesPage01 {
  const StylesPage01();

  TextStyle get listSampleTitle => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF000000));
  TextStyle get listSampleEmptyMessage =>
      const TextStyle(fontSize: 18, color: Color(0xFF9E9E9E));
  TextStyle get listSampleSubTitle =>
      const TextStyle(fontSize: 16, color: Color(0xFF000000));
  TextStyle get searchTextBoxHintText =>
      const TextStyle(fontSize: 16, color: Color(0xFFB8B8B8));
  TextStyle get searchTextBoxInput =>
      const TextStyle(fontSize: 16, color: Color(0xFF000000));
  TextStyle get searchTextBoxCancel =>
      const TextStyle(fontSize: 16, color: Color(0xFF9261E0));
  TextStyle get editTextBoxHintText =>
      const TextStyle(fontSize: 16, color: Color(0xFFB8B8B8));
  TextStyle get editTextBoxInput =>
      const TextStyle(fontSize: 16, color: Color(0xFF000000));
}
