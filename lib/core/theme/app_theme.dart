import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';  
  
class AppTheme {  
  static ThemeData get theme {  
    return ThemeData(  
      primarySwatch: Colors.blueGrey,  
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Urbanist',  
      scaffoldBackgroundColor: AppColor.whiteColor
    );  
  }  
}  
