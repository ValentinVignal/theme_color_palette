part of theme_color_palette;

/// String buffer extension
extension StringBufferExtension on StringBuffer {
  /// Indent from int
  static String indent(int indent) => '\t' * indent;

  /// Writes a line with a specific indentation
  void writeLine(int indentValue, String line) {
    writeln(indent(indentValue) + line);
  }
}
