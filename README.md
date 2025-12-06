# Треугольник проекта 🔺

Демонстрационное Flutter-приложение с классической логикой "треугольника проектного менеджмента".

## Концепция

В любом проекте можно выбрать только **2 из 3** параметров:
- ⚡ **Быстро** — минимальные сроки
- ⭐ **Качественно** — высокое качество
- 💬 **Без вопросов** — без лишних уточнений

### Комбинации:
- Быстро + Качественно = Дорого (много вопросов)
- Быстро + Без вопросов = Низкое качество
- Качественно + Без вопросов = Долго

## Запуск

```bash
# Установка зависимостей
flutter pub get

# Запуск для Web
flutter run -d chrome

# Запуск для Android
flutter run -d android

# Запуск для iOS
flutter run -d ios
```

## Архитектура

Проект использует Feature-First структуру:

```
lib/
├── main.dart                 # Точка входа
├── core/
│   └── theme/
│       └── app_theme.dart    # Темы приложения
└── features/
    └── triangle/
        ├── domain/           # Бизнес-логика
        │   ├── triangle_option.dart
        │   └── triangle_state.dart
        └── presentation/     # UI
            ├── triangle_screen.dart
            └── widgets/
                ├── option_card.dart
                └── triangle_visualization.dart
```

## Требования

- Flutter 3.0+
- Dart 3.0+
