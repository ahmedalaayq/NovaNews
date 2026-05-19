import 'package:flutter/material.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  useMaterial3: true,
  brightness: .light,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      fontSize: 24,
      color: Color(0xFF161F1B),
      fontWeight: .w400,
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return LightAppColors.primaryColor;
      }
      return const Color(0xFFCDCDCD);
    }),
    thumbColor: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFFFFFFFF);
      }
      return Colors.grey;
    }),
    trackOutlineColor: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return LightAppColors.primaryColor.withValues(alpha: 0.15);
      }
      return Colors.white;
    }),
    trackOutlineWidth: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 18;
      }
      return 2;
    }),
    thumbIcon: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Icon(
          Icons.dark_mode_outlined,
          color: Colors.grey.shade600,
        );
      }
      return Icon(Icons.light_mode_outlined);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightAppColors.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: Color(0xFFFFFCFC),
      ),
    ),
  ),
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,

  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      color: Color(0xFF141414),
      fontWeight: .w400,
    ),
    displayMedium: TextStyle(
      fontSize: (24),
      color: Color(0xFF141414),
      fontWeight: .w400,
    ),
    displaySmall: TextStyle(
      fontSize: (16),
      color: Color(0xFF141414),
      fontWeight: .w400,
    ),
    bodyLarge: TextStyle(
      fontSize: (16),
      color: Color(0xFF141414),
      fontWeight: .w400,
    ),
    bodyMedium: TextStyle(
      fontSize: (14),
      color: Color(0xFF3A4640),
      fontWeight: .w400,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      color: LightAppColors.blackColor,
      fontWeight: .bold,
    ),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: _buildFieldBorder(),
    enabledBorder: _buildFieldBorder(color: Color(0xFFD1DAD6)),
    focusedBorder: _buildFieldBorder(),
    errorBorder: _buildFieldBorder(),
    focusedErrorBorder: _buildFieldBorder(),
    contentPadding: .all((16)),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: LightAppColors.primaryColor,
    selectionHandleColor: LightAppColors.primaryColor,
    selectionColor: LightAppColors.primaryColor.withValues(
      alpha: 0.15,
    ),
  ),
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFFFFF),
  ),

  // popupMenuTheme: PopupMenuThemeData(
  //   color: Color(0xFFF6F7F9),
  //   labelTextStyle: .all(
  //     TextStyle(fontSize: (14), color: Color(0xFF161F1B)),
  //   ),
  //   elevation: 2,
  //   shadowColor: LightAppColors.primaryColor,
  //   enableFeedback: true,
  // ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: LightAppColors.whiteBgColor,
    indicatorColor: LightAppColors.primaryColor.withValues(
      alpha: 0.2,
    ),
    labelTextStyle: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          fontSize: (14),
          color: LightAppColors.primaryColor,
          fontWeight: .w600,
          height: 2.0,
        );
      } else {
        return TextStyle(
          fontSize: (14),
          color: Color(0xFF161F1B),
          fontWeight: .w400,
          height: 2.0,
        );
      }
    }),
    height: 85,
    iconTheme: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: LightAppColors.primaryColor);
      } else {
        IconThemeData(color: LightAppColors.secondaryColor);
      }
      return null;
    }),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: LightAppColors.whiteBgColor,
  ),
);
OutlineInputBorder _buildFieldBorder({Color? color, double? width}) {
  return OutlineInputBorder(
    borderRadius: .circular(0),
    borderSide: BorderSide(
      color: color ?? LightAppColors.primaryColor,
      width: width ?? 1.0,
    ),
  );
}
