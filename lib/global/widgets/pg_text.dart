import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PgText extends LeafRenderObjectWidget {
  final String text;
  final int maxLines;
  final TextStyle style;
  final TextAlign textAlign;
  final double? maxWidth;


  const PgText(this.text, {
    super.key,
    this.maxLines = 1,
    required this.style,
    this.textAlign = TextAlign.start,
    this.maxWidth,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomParagraphText(
      text,
      maxLines,
      style,
      textAlign,
      Directionality.of(context),
      maxWidth,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderCustomParagraphText renderObject) {
    renderObject
      ..text = text
      ..maxLines = maxLines
      ..style = style
      ..textAlign = textAlign
      ..textDirection = Directionality.of(context)
      ..maxWidth = maxWidth;
  }

}

class RenderCustomParagraphText extends RenderBox {
  RenderCustomParagraphText(
      this._text,
      this._maxLines,
      this._style,
      this._textAlign,
      this._textDirection,
      this._maxWidth,
      );

  String _text;
  int _maxLines;
  TextStyle _style;
  TextAlign _textAlign;
  ui.TextDirection _textDirection;
  double? _maxWidth;

  set text(String value) {
    if (_text != value) {
      _text = value;
      markNeedsLayout();
    }
  }

  set maxLines(int value) {
    if (_maxLines != value) {
      _maxLines = value;
      markNeedsLayout();
    }
  }

  set style(TextStyle value) {
    if (_style != value) {
      _style = value;
      markNeedsLayout();
    }
  }

  set textAlign(TextAlign value) {      // 新增TextAlign setter
    if (_textAlign != value) {
      _textAlign = value;
      markNeedsLayout();
    }
  }

  set textDirection(ui.TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsLayout();
    }
  }

  set maxWidth(double? value) {
    if (_maxWidth != value) {
      _maxWidth = value;
      markNeedsLayout();
    }
  }

  late ui.Paragraph _paragraph;

  void _buildParagraph(double maxWidth) {
    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: _style.fontFamily,
        fontSize: _style.fontSize,
        fontWeight: _style.fontWeight,
        fontStyle: _style.fontStyle,
        maxLines: _maxLines,
        ellipsis: '\u2026',
        height: _style.height,
        textAlign: _textAlign,
        textDirection: _textDirection,
        // No extra leading here, custom line height control
      ),
    );

    builder.pushStyle(ui.TextStyle(
      color: _style.color,
      fontWeight: _style.fontWeight,
      fontStyle: _style.fontStyle,
      fontFamily: _style.fontFamily,
      fontSize: _style.fontSize,
      height: _style.height,
      letterSpacing: _style.letterSpacing,
    ));

    builder.addText(_text);
    _paragraph = builder.build();
    _paragraph.layout(ui.ParagraphConstraints(width: maxWidth));
  }

  @override
  void performLayout() {
    double layoutWidth = _maxWidth ?? (constraints.maxWidth.isFinite ? constraints.maxWidth : 1000);
    if (_maxWidth != null) {
      final double naturalWidth = _measureNaturalWidth();
      layoutWidth = naturalWidth < layoutWidth ? naturalWidth : layoutWidth;
    }

    _buildParagraph(layoutWidth);
    final double textHeight = _paragraph.height;
    // debugPrint("$_text, $textHeight");
    size = Size(layoutWidth, textHeight);
  }

  double _measureNaturalWidth() {
    final painter = TextPainter(
      text: TextSpan(text: _text, style: _style),
      maxLines: _maxLines,
      textDirection: _textDirection,
    );
    painter.layout(minWidth: 0, maxWidth: double.infinity);
    return painter.size.width;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawParagraph(_paragraph, offset);
  }
}