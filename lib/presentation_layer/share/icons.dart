import 'package:flutter/material.dart';

/// アイコンを管理するクラス
///
/// (例) `IconType.footer.home`
class IconType {
  IconType._();

  static const common = IconsCommon();

  static const header = IconsHeader();

  static const footer = IconsFooter();

  static const page01 = IconsPage01();
}

class IconsCommon {
  const IconsCommon();

  Icon get contentDialogClose => const Icon(
        Icons.close,
        color: Color(0xFF424242),
      );
  Widget get textBoxClear => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF919191),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          color: Color(0xFFFFFFFF),
        ),
      );
  Icon get search => const Icon(
        Icons.search,
        color: Color(0xFFB8B8B8),
      );
}

class IconsHeader {
  const IconsHeader();

  Icon get page01HeaderEdit => const Icon(
        Icons.edit_square,
        color: Color(0xFFFFFFFF),
      );
}

class IconsFooter {
  const IconsFooter();

  Icon get page01 => const Icon(Icons.book_sharp);
  Icon get page02 => const Icon(Icons.lightbulb_outline_sharp);
  Icon get page03 => const Icon(Icons.settings);
  Icon get copy => const Icon(Icons.copy);
  Icon get delete => const Icon(Icons.delete);
  Icon get temp => const Icon(Icons.tab);
}

class IconsPage01 {
  const IconsPage01();

  Icon get addSample => const Icon(
        Icons.add,
        color: Color(0xFFFFFFFF),
      );
  Icon get listSample => const Icon(
        Icons.book_outlined,
        color: Color(0xFF383689),
        size: 35,
      );
  Icon get moveSampleDetail => const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Color(0xFFB8B8B8),
      );
}
