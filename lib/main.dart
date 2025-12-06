import 'package:flutter/material.dart';
import 'features/triangle/presentation/triangle_screen.dart';
import 'core/theme/app_theme.dart';

/// Точка входа в приложение
void main() {
  runApp(const ProjectTriangleApp());
}

/// Корневой виджет приложения
class ProjectTriangleApp extends StatelessWidget {
  const ProjectTriangleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Треугольник проекта',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const TriangleScreen(),
    );
  }
}
