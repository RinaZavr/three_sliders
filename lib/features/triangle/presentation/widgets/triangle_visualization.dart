import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/triangle_state.dart';

/// Визуализация треугольника проекта
///
/// Отображает интерактивный треугольник с подсветкой
/// активных вершин
class TriangleVisualization extends StatelessWidget {
  final TriangleState state;

  const TriangleVisualization({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: _TrianglePainter(
          state: state,
          theme: Theme.of(context),
        ),
        size: const Size(double.infinity, 200),
      ),
    );
  }
}

/// CustomPainter для рисования треугольника
class _TrianglePainter extends CustomPainter {
  final TriangleState state;
  final ThemeData theme;

  _TrianglePainter({
    required this.state,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2.5;

    // Вычисляем вершины треугольника
    final topPoint = Offset(center.dx, center.dy - radius);
    final bottomLeftPoint = Offset(
      center.dx - radius * math.cos(math.pi / 6),
      center.dy + radius * math.sin(math.pi / 6),
    );
    final bottomRightPoint = Offset(
      center.dx + radius * math.cos(math.pi / 6),
      center.dy + radius * math.sin(math.pi / 6),
    );

    // Рисуем рёбра треугольника
    final linePaint = Paint()
      ..color = theme.colorScheme.outline.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(topPoint.dx, topPoint.dy)
      ..lineTo(bottomLeftPoint.dx, bottomLeftPoint.dy)
      ..lineTo(bottomRightPoint.dx, bottomRightPoint.dy)
      ..close();

    canvas.drawPath(path, linePaint);

    // Рисуем активные рёбра
    if (state.isFastEnabled && state.isQualityEnabled) {
      _drawActiveLine(canvas, topPoint, bottomRightPoint, Colors.orange);
    }
    if (state.isFastEnabled && state.isNoQuestionsEnabled) {
      _drawActiveLine(canvas, topPoint, bottomLeftPoint, Colors.purple);
    }
    if (state.isQualityEnabled && state.isNoQuestionsEnabled) {
      _drawActiveLine(canvas, bottomLeftPoint, bottomRightPoint, Colors.teal);
    }

    // Рисуем вершины
    _drawVertex(canvas, topPoint, 'Быстро', state.isFastEnabled, Colors.orange);
    _drawVertex(canvas, bottomLeftPoint, 'Без\nвопросов',
        state.isNoQuestionsEnabled, Colors.blue);
    _drawVertex(canvas, bottomRightPoint, 'Качественно', state.isQualityEnabled,
        Colors.green);
  }

  void _drawActiveLine(Canvas canvas, Offset p1, Offset p2, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawLine(p1, p2, paint);
  }

  void _drawVertex(
      Canvas canvas, Offset point, String label, bool isActive, Color color) {
    // Круг вершины
    final circlePaint = Paint()
      ..color = isActive ? color : theme.colorScheme.surfaceContainerHighest
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color =
          isActive ? color : theme.colorScheme.outline.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(point, isActive ? 14 : 10, circlePaint);
    canvas.drawCircle(point, isActive ? 14 : 10, borderPaint);

    // Галочка если активно
    if (isActive) {
      final checkPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final checkPath = Path()
        ..moveTo(point.dx - 5, point.dy)
        ..lineTo(point.dx - 1, point.dy + 4)
        ..lineTo(point.dx + 6, point.dy - 4);

      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return oldDelegate.state.isFastEnabled != state.isFastEnabled ||
        oldDelegate.state.isQualityEnabled != state.isQualityEnabled ||
        oldDelegate.state.isNoQuestionsEnabled != state.isNoQuestionsEnabled;
  }
}
