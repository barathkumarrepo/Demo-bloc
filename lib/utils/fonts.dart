class Font {
  static const Font LatoBold = Font("Lato-Bold");
  static const Font LatoBlack = Font("Lato-Black");
  static const Font LatoMedium = Font("Lato-Medium");
  static const Font LatoSemiBold = Font("Lato-Semibold");
  static const Font OpenSansRegular = Font("OpenSans-Regular");
  static const Font OpenSansSemiBoldItalic = Font("OpenSans-SemiboldItalic");
  static const Font OpenSansSemiBold = Font("OpenSans-Semibold");
  static const Font ProximaNovaRegular = Font("ProximaNovaReg");
  static const Font OpenSansBold = Font("OpenSans-Bold");
  static const Font ProximaNovaBold = Font("Proxima Nova Bold");

  final String _fontName;
  const Font(this._fontName);
  String get value => _fontName;
}
