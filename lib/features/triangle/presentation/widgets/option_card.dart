import 'package:flutter/material.dart';
import '../../domain/triangle_option.dart';

/// Карточка опции с переключателем
///
/// Отображает название, описание и switch для переключения
class OptionCard extends StatelessWidget {
  final TriangleOption option;
  final bool isEnabled;
  final VoidCallback onToggle;

  const OptionCard({
    super.key,
    required this.option,
    required this.isEnabled,
    required this.onToggle,
  });

  /// Возвращает иконку для опции
  IconData _getIcon() {
    switch (option) {
      case TriangleOption.fast:
        return Icons.speed;
      case TriangleOption.quality:
        return Icons.stars;
      case TriangleOption.noQuestions:
        return Icons.chat_bubble_outline;
    }
  }

  /// Возвращает цвет для опции
  Color _getColor(BuildContext context) {
    switch (option) {
      case TriangleOption.fast:
        return Colors.orange;
      case TriangleOption.quality:
        return Colors.green;
      case TriangleOption.noQuestions:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColor(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEnabled
              ? color
              : theme.colorScheme.outline.withValues(alpha: 0.3),
          width: isEnabled ? 2 : 1,
        ),
        color: isEnabled
            ? color.withValues(alpha: 0.1)
            : theme.colorScheme.surface,
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Иконка
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? color.withValues(alpha: 0.2)
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIcon(),
                    color:
                        isEnabled ? color : theme.colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 16),

                // Текст
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isEnabled
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        option.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // Переключатель
                Switch.adaptive(
                  value: isEnabled,
                  onChanged: (_) => onToggle(),
                  activeThumbColor: color,
                  activeTrackColor: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
