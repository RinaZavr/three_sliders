/// Перечисление опций треугольника проектного менеджмента
/// 
/// Концепция: можно выбрать только 2 из 3 опций одновременно
enum TriangleOption {
  fast,      // Быстро
  quality,   // Качественно
  noQuestions; // Без вопросов (дёшево)

  /// Возвращает локализованное название опции
  String get title {
    switch (this) {
      case TriangleOption.fast:
        return 'Быстро';
      case TriangleOption.quality:
        return 'Качественно';
      case TriangleOption.noQuestions:
        return 'Без вопросов';
    }
  }

  /// Возвращает описание опции
  String get description {
    switch (this) {
      case TriangleOption.fast:
        return 'Минимальные сроки выполнения';
      case TriangleOption.quality:
        return 'Высокое качество результата';
      case TriangleOption.noQuestions:
        return 'Без лишних уточнений';
    }
  }

  /// Возвращает иконку для опции
  String get iconName {
    switch (this) {
      case TriangleOption.fast:
        return 'speed';
      case TriangleOption.quality:
        return 'stars';
      case TriangleOption.noQuestions:
        return 'chat_bubble_outline';
    }
  }
}
