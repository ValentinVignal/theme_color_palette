import 'dart:convert' as dart_convert;
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:themed_color_palette/src/themed_color_palette.dart';
import 'package:themed_color_palette/src/utils/dart_define_context.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('It should generate test.theme.g.dart', () async {
    final yamlContent = await File('test/e2e/test.theme.yaml').readAsString();
    final json = dart_convert.json.decode(
      dart_convert.json.encode(loadYaml(yamlContent)),
    );
    final colorPalette = ColorPalette.fromJson(
      json: json as Map<String, dynamic>,
    );

    final buffer = StringBuffer()
      ..writeln('import \'package:flutter/material.dart\';')
      ..writeln()
      ..write(colorPalette.dartDefine(const DartDefineContext()));

    final generatedContent = await File(
      'test/e2e/test.theme.g.dart',
    ).readAsString();

    expect(buffer.toString(), generatedContent);
  });
}
