import 'package:theme_color_palette/src/theme_color_palette.dart';

/// Divider for class names.
const divider = r'$';

/// Divider for the class name with the platform.
const platformDivider = '_';

/// Themes.
mixin Themes {
  /// The list of themes.
  static final List<String> themes = [];

  /// The default theme is the first one in the list of themes.
  static String get defaultTheme => themes.first;

  /// The different supported platforms.
  static final List<String> platforms = [];
}

/// All the values.
final allValues = <String, Value>{};

/// Errors.
final errors = <String>[];

/// RegExp for camel case.
final camelCaseRegExp = RegExp(r'^[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])?$');

/// Base names.
mixin BaseName {
  /// Themed base name.
  static const themed = '.themed';

  /// Shared base name.
  static const shared = '.shared';

  /// Color palette base name.
  static var colorPalette = '';
}
