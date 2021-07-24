library theme_color_palette;

part 'globals.dart';
part 'types.dart';
part 'json_to_dart.dart';
part 'object_type.dart';
part 'value/value_type.dart';
part 'value/color.dart';
part 'value/double.dart';
part 'value/font_weight.dart';
part 'value/int.dart';
part 'value/value.dart';
part 'collection.dart';
part 'themed_value.dart';
part 'shared_value.dart';
part 'string_buffer.dart';

/// The color palette containing everything
class ColorPalette extends JsonToDart {
  /// [ColorPalette] from Json
  ColorPalette.fromJson({required Json json}) : super(json: json, names: [json['.name'] as String]) {
    // Themes
    _addThemes(List<String>.from(json['.themes'] as List));
    // Check the themes have valid names (camelCase)
    baseName = names.first;
    sharedValues
        .addAll((json['.shared'] as Map).entries.map((entry) => SharedValue(json: entry.value as Json, names: [sharedBaseName, entry.key as String])).toList());
    collections.addAll(
        (json['.themed'] as Map).entries.map((entry) => JsonToDart.fromJson(json: entry.value as Json, names: [baseName, entry.key as String])).toList());
  }

  /// The base name for themed values
  static String baseName = '';

  /// The based name for shared values
  static const sharedBaseName = '.shared';

  static void _addThemes(List<String> themes) {
    // Add it to the global variable
    Themes.themes.addAll(themes);
    // Check the names
    for (final theme in themes) {
      if (!camelCaseRegExp.hasMatch(theme)) {
        errors.add('Theme "$theme" is not in camelCase');
      }
    }
  }

  /// List of collections (themed)
  final List<JsonToDart> collections = [];

  /// List of shared values
  final List<SharedValue> sharedValues = [];

  @override
  List<JsonToDart> get values => collections;

  @override
  List<SharedValue> get constants => sharedValues;

  @override
  String dartDefine() {
    final buffer = StringBuffer()..writeLine(0, '/// Different Themes')..writeLine(0, 'enum Themes {');

    // Add the enum
    for (final theme in Themes.themes) {
      buffer..writeLine(1, '/// ${JsonToDart.firstUpperCase(theme)} theme')..writeLine(1, '${JsonToDart.firstLowerCase(theme)},');
    }
    buffer
      ..writeLine(0, '}')
      ..writeln();

    // Extension on enum
    final extensionBody = StringBuffer();
    for (final theme in Themes.themes.sublist(1)) {
      extensionBody..writeLine(3, 'case Themes.${JsonToDart.firstLowerCase(theme)}:')..writeLine(4, 'return ${dartConstructor(theme)};');
    }
    // Default theme
    extensionBody
      ..writeLine(3, 'case Themes.${JsonToDart.firstLowerCase(Themes.defaultTheme)}:')
      ..writeLine(3, 'default:')
      ..writeLine(4, 'return ${dartConstructor(Themes.defaultTheme)};');
    buffer.write('''
extension ThemesExtension on Themes {
  /// Color palette
  ${JsonToDart.firstUpperCase(baseName)} get colorPalette {
    switch (this) {
$extensionBody
    }
  }
}''');

    // Color palette
    buffer.write(super.dartDefine());
    return buffer.toString();
  }
}
