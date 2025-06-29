import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// 文字を管理するクラス
///
/// (例) `StyleType.header.title`
class StyleType {
  StyleType._();

  static const common = StylesCommon();

  static const header = StylesHeader();

  static const footer = StylesFooter();

  static const home = StylesHome();
}

class StylesCommon {
  const StylesCommon();

  TextStyle get title => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      );
}

class StylesHeader {
  const StylesHeader();
}

class StylesFooter {
  const StylesFooter();
}

class StylesHome {
  const StylesHome();
}
