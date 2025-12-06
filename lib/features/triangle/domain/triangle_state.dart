import 'triangle_option.dart';

/// Состояние треугольника проекта
/// 
/// Инкапсулирует логику взаимного исключения:
/// при включении двух опций третья автоматически выключается
class TriangleState {
  final bool isFastEnabled;
  final bool isQualityEnabled;
  final bool isNoQuestionsEnabled;

  const TriangleState({
    this.isFastEnabled = false,
    this.isQualityEnabled = false,
    this.isNoQuestionsEnabled = false,
  });

  /// Фабричный конструктор для начального состояния
  factory TriangleState.initial() => const TriangleState();

  /// Количество активных опций
  int get activeCount {
    int count = 0;
    if (isFastEnabled) count++;
    if (isQualityEnabled) count++;
    if (isNoQuestionsEnabled) count++;
    return count;
  }

  /// Проверяет, включена ли опция
  bool isEnabled(TriangleOption option) {
    switch (option) {
      case TriangleOption.fast:
        return isFastEnabled;
      case TriangleOption.quality:
        return isQualityEnabled;
      case TriangleOption.noQuestions:
        return isNoQuestionsEnabled;
    }
  }

  /// Переключает опцию с учётом логики взаимного исключения
  /// 
  /// Правило: если после включения активны 3 опции,
  /// автоматически выключается "противоположная" опция
  TriangleState toggle(TriangleOption option) {
    bool newFast = isFastEnabled;
    bool newQuality = isQualityEnabled;
    bool newNoQuestions = isNoQuestionsEnabled;

    // Переключаем выбранную опцию
    switch (option) {
      case TriangleOption.fast:
        newFast = !newFast;
        break;
      case TriangleOption.quality:
        newQuality = !newQuality;
        break;
      case TriangleOption.noQuestions:
        newNoQuestions = !newNoQuestions;
        break;
    }

    // Применяем логику взаимного исключения
    // Если включены все три - выключаем ту, которую НЕ трогали
    if (newFast && newQuality && newNoQuestions) {
      switch (option) {
        case TriangleOption.fast:
          // Включили быстро при качественно+без вопросов
          // → выключаем без вопросов (т.к. быстро+качественно = дорого)
          newNoQuestions = false;
          break;
        case TriangleOption.quality:
          // Включили качественно при быстро+без вопросов
          // → выключаем быстро (т.к. качественно+без вопросов = долго)
          newFast = false;
          break;
        case TriangleOption.noQuestions:
          // Включили без вопросов при быстро+качественно
          // → выключаем качественно (т.к. быстро+без вопросов = некачественно)
          newQuality = false;
          break;
      }
    }

    return TriangleState(
      isFastEnabled: newFast,
      isQualityEnabled: newQuality,
      isNoQuestionsEnabled: newNoQuestions,
    );
  }

  /// Создаёт копию с изменёнными полями
  TriangleState copyWith({
    bool? isFastEnabled,
    bool? isQualityEnabled,
    bool? isNoQuestionsEnabled,
  }) {
    return TriangleState(
      isFastEnabled: isFastEnabled ?? this.isFastEnabled,
      isQualityEnabled: isQualityEnabled ?? this.isQualityEnabled,
      isNoQuestionsEnabled: isNoQuestionsEnabled ?? this.isNoQuestionsEnabled,
    );
  }
}
