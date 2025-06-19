import 'package:doculode/config/index.dart';
import 'package:doculode/widgets/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum MessageType {
  error,
  success,
  info,
  warning,
}

class MessageContainer extends StatefulWidget {
  final String message;
  final MessageType type;
  final VoidCallback? onClose;

  const MessageContainer({
    super.key,
    required this.message,
    required this.type,
    this.onClose,
  });

  factory MessageContainer.error(String message, {VoidCallback? onClose}) =>
      MessageContainer(
          message: message, type: MessageType.error, onClose: onClose);
  factory MessageContainer.success(String message, {VoidCallback? onClose}) =>
      MessageContainer(
          message: message, type: MessageType.success, onClose: onClose);
  factory MessageContainer.info(String message, {VoidCallback? onClose}) =>
      MessageContainer(
          message: message, type: MessageType.info, onClose: onClose);
  factory MessageContainer.warning(String message, {VoidCallback? onClose}) =>
      MessageContainer(
          message: message, type: MessageType.warning, onClose: onClose);

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    IconData icon;
    String title;

    switch (widget.type) {
      case MessageType.error:
        backgroundColor = colorScheme.errorContainer;
        borderColor = colorScheme.error;
        textColor = colorScheme.onErrorContainer;
        icon = Ionicons.close_circle_outline;
        title = "Error";
        break;
      case MessageType.success:
        backgroundColor = colorScheme.primaryContainer;
        borderColor = colorScheme.primary;
        textColor = colorScheme.onPrimaryContainer;
        icon = Ionicons.checkmark_circle_outline;
        title = "Success";
        break;
      case MessageType.info:
        backgroundColor = colorScheme.secondaryContainer;
        borderColor = colorScheme.secondary;
        textColor = colorScheme.onSecondaryContainer;
        icon = Ionicons.information_circle_outline;
        title = "Information";
        break;
      case MessageType.warning:
        backgroundColor = colorScheme.tertiaryContainer;
        borderColor = colorScheme.tertiary;
        textColor = colorScheme.onTertiaryContainer;
        icon = Ionicons.warning_outline;
        title = "Warning";
        break;
    }

    final titleStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: textColor,
    );
    final messageStyle = theme.textTheme.bodySmall?.copyWith(
      color: textColor,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(Insets.sm),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: .1),
        border: Border.all(color: borderColor, width: 1.2),
        borderRadius: Corners.smBorder,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 28),
              SizedBox(width: Insets.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: titleStyle),
                    SizedBox(height: 2),
                    UiText(
                      text: widget.message,
                      style: messageStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() => _visible = false);
                widget.onClose?.call();
              },
              child: Icon(Ionicons.close, color: textColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
