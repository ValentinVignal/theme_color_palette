part of theme_color_palette;

/// Divider for class names
const divider = r'$';

/// Themes
mixin Themes {
  /// The list of themes
  static final List<String> themes = [];

  /// The default theme is the first one in the list of themes
  static String get defaultTheme => themes.first;
}

/// All the values
final allValues = <String, Value>{};

/// Errors
final errors = <String>[];

/// RegExp for camel case
final camelCaseRegExp = RegExp(r'^[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])?$');
