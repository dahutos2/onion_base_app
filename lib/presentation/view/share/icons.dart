import 'package:flutter/material.dart';

/// アイコンを管理するクラス
///
/// (例) `IconType.footer.home`
class IconType {
  IconType._();

  static const common = IconsCommon();

  static const header = IconsHeader();

  static const footer = IconsFooter();

  static const home = IconsHome();
}

class IconsCommon {
  const IconsCommon();

  Icon get contentDialogClose => const Icon(
        Icons.close,
        color: Color(0xFF424242),
      );
}

class IconsHeader {
  const IconsHeader();
}

class IconsFooter {
  const IconsFooter();
}

class IconsHome {
  const IconsHome();
}
