import 'dart:ui';

class ColorManager {
  static Color bgColor = HexColor.fromHexColor("FFF3F1F1");
  static Color primary = HexColor.fromHexColor("9E090F");
  static Color ctgColor = HexColor.fromHexColor("666666");
}

extension HexColor on Color {
  static Color fromHexColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
