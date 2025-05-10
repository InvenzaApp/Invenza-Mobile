import 'package:app/enums/task_status.dart';
import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  Color get onSecondaryContainer =>
      Theme.of(this).colorScheme.onSecondaryContainer;

  Color get tertiary => Theme.of(this).colorScheme.tertiary;

  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;

  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;

  Color get onTertiaryContainer =>
      Theme.of(this).colorScheme.onTertiaryContainer;

  Color get error => Theme.of(this).colorScheme.error;

  Color get onError => Theme.of(this).colorScheme.onError;

  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  Color get surfaceDim => Theme.of(this).colorScheme.surfaceDim;

  Color get surface => Theme.of(this).colorScheme.surface;

  Color get surfaceBright => Theme.of(this).colorScheme.surfaceBright;

  Color get containerLowest =>
      Theme.of(this).colorScheme.surfaceContainerLowest;

  Color get containerLow => Theme.of(this).colorScheme.surfaceContainerLow;

  Color get container => Theme.of(this).colorScheme.surfaceContainer;

  Color get containerHigh => Theme.of(this).colorScheme.surfaceContainerHigh;

  Color get containerHighest =>
      Theme.of(this).colorScheme.surfaceContainerHighest;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;

  Color get outline =>
      Theme.of(this).colorScheme.outline.withValues(alpha: 0.3);

  Color get outlineVariant => Theme.of(this).colorScheme.outlineVariant;

  Color get scrim => Theme.of(this).colorScheme.scrim;

  Color get shadow => Theme.of(this).colorScheme.shadow;

  bool get isDarkMode =>
      Theme.of(this).colorScheme.brightness == Brightness.dark;
}

extension TaskStatusColorExtension on TaskStatus {
  Color get color => switch (this) {
        TaskStatus.toDo => const Color(0xFF4577C1),
        TaskStatus.inProgress => const Color(0xFF318719),
        TaskStatus.waiting => const Color(0xFF288E7F),
        TaskStatus.testing => const Color(0xFF7135B3),
        TaskStatus.review => const Color(0xFFBD3838),
        TaskStatus.done => const Color(0xFFB56D11),
      };

  Color get surfaceColor => switch (this) {
        TaskStatus.toDo => const Color(0xFFD1E4FF),
        TaskStatus.inProgress => const Color(0xFFD2FDC6),
        TaskStatus.waiting => const Color(0xFFD6FFF7),
        TaskStatus.testing => const Color(0xFFE9D3FF),
        TaskStatus.review => const Color(0xFFFFCCCC),
        TaskStatus.done => const Color(0xFFFFEDC5),
      };
}
