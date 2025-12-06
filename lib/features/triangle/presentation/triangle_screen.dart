import 'package:flutter/material.dart';
import '../domain/triangle_option.dart';
import '../domain/triangle_state.dart';
import 'widgets/option_card.dart';
import 'widgets/triangle_visualization.dart';

/// Главный экран приложения
///
/// Отображает три переключателя с логикой взаимного исключения
/// и визуализацию треугольника проекта
class TriangleScreen extends StatefulWidget {
  const TriangleScreen({super.key});

  @override
  State<TriangleScreen> createState() => _TriangleScreenState();
}

class _TriangleScreenState extends State<TriangleScreen> {
  /// Текущее состояние треугольника
  TriangleState _state = TriangleState.initial();

  /// Обработчик переключения опции
  void _onToggle(TriangleOption option) {
    setState(() {
      _state = _state.toggle(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Треугольник проекта'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  // Визуализация треугольника
                  TriangleVisualization(state: _state),

                  const SizedBox(height: 24),

                  // Подсказка
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Можно выбрать только 2 из 3 опций',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Карточки опций
                  ...TriangleOption.values.map((option) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: OptionCard(
                          option: option,
                          isEnabled: _state.isEnabled(option),
                          onToggle: () => _onToggle(option),
                        ),
                      )),

                  const SizedBox(height: 16),

                  // Статус
                  _buildStatusText(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Строит текст статуса на основе выбранных опций
  Widget _buildStatusText(ThemeData theme) {
    final messages = <String>[];

    if (_state.isFastEnabled && _state.isQualityEnabled) {
      messages.add('⚡ Быстро и качественно = дорого!');
    } else if (_state.isFastEnabled && _state.isNoQuestionsEnabled) {
      messages.add('🎲 Быстро и без вопросов = на свой страх и риск');
    } else if (_state.isQualityEnabled && _state.isNoQuestionsEnabled) {
      messages.add('🐢 Качественно и без вопросов = придётся подождать');
    } else if (_state.activeCount == 0) {
      messages.add('👆 Выберите опции');
    } else {
      messages.add('🤔 Выберите ещё одну опцию');
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(messages.first),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          messages.first,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
