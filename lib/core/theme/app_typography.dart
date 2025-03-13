import 'package:flutter/material.dart';

class Typograph {
  const Typograph({
    required this.light,
    required this.regular,
    required this.medium,
    required this.bold,
    required this.black,
  });

  final TextStyle light;
  final TextStyle regular;
  final TextStyle medium;
  final TextStyle bold;
  final TextStyle black;
}

class AppTypograph {
  static const String _fontName = 'urbanist';

  //* Heading 1
  static const Typograph heading1 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w200,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Heading 2
  static const Typograph heading2 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Heading 3
  static const Typograph heading3 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Label 1
  static const Typograph label1 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Label 2
  static const Typograph label2 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w200,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Label 3
  static const Typograph label3 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Body 1
  static const Typograph body1 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Body 2
  static const Typograph body2 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Body 3
  static const Typograph body3 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w700,
    ),
    black: TextStyle(
      fontFamily: _fontName,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w900,
    ),
  );

  //* Body 4
  static const Typograph body4 = Typograph(
    light: TextStyle(
      fontFamily: _fontName,
      fontSize: 10,
      height: 14 / 10,
      fontWeight: FontWeight.w300,
    ),
    regular: TextStyle(
      fontFamily: _fontName,
      fontSize: 10,
      height: 14 / 10,
      fontWeight: FontWeight.w400,
    ),
    medium: TextStyle(
      fontFamily: _fontName,
      fontSize: 10,
      height: 14 / 10,
      fontWeight: FontWeight.w500,
    ),
    bold: TextStyle(
      fontFamily: _fontName,
      fontSize: 10,
      height: 14 / 10,
      fontWeight: FontWeight.w700,
    ),
    black: const TextStyle(
      fontFamily: _fontName,
      fontSize: 10,
      height: 14 / 10,
      fontWeight: FontWeight.w900,
    ),
  );
}
