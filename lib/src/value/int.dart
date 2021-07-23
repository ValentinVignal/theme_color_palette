part of theme_color_palette;

/// Int
class Int extends Value {
  /// Int
  Int.fromJson({
    required dynamic value,
    required Names path,
    required String? theme,
  })  : value = value is int
            ? value
            : (allValues[Value._allValuesImportKey(
                path: List<String>.from((value as Map)['import'] as List),
                theme: theme,
              )]! as Int)
                .value,
        super(value: value, path: path, theme: theme);

  @override
  String get className => 'int';

  /// Value
  final int value;

  @override
  String get dartConstructor {
    return value.toString();
  }
}