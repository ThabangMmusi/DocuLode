import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/features/shared/presentation/bloc/shared_bloc.dart';
import 'package:doculode/features/shared/presentation/views/shared_dialog.dart';
import 'package:doculode/features/uploads/presentation/views/upload_share_dialog.dart';
import 'package:doculode/core/widgets/buttons/buttons.dart';
import 'package:doculode/core/widgets/index.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as time_ago;

import 'package:doculode/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:doculode/features/upload_edit/presentation/views/update_file_dialog.dart';
import 'package:doculode/features/upload_edit/presentation/views/upload_edit_view.dart';
import 'package:doculode/features/uploads/presentation/uploads_constants.dart';
import 'package:doculode/features/uploads/presentation/views/upload_file_view.dart';
import 'uploaded_status.dart';

class DLTableRow extends StatefulWidget {
  const DLTableRow(this.document, {super.key});
  final RemoteDocModel document;

  @override
  State<DLTableRow> createState() => _DLTableRowState();
}

class _DLTableRowState extends State<DLTableRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final BorderRadius borderRadius = Corners.medBorder;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.xs),
      child: InkWell(
        onHover: (value) => setState(() => _hovered = value),
        onTap: () => widget.document.isPublished
            ? _handleDefaultClick(context)
            : _handleEditClick(context),
        borderRadius: borderRadius,
        hoverColor: colorScheme.primary.withOpacity(0.04),
        splashColor: colorScheme.primary.withOpacity(0.08),
        highlightColor: colorScheme.primary.withOpacity(0.06),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.sm),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: _hovered
                ? colorScheme.surfaceContainerHighest.withOpacity(0.5)
                : Colors.transparent,
          ),
          child: Stack(
            children: [
              Row(children: [
                ColumnItem(
                  child: Row(children: [
                    SizedBox(
                      width: IconSizes.lg + Insets.xs,
                      height: IconSizes.lg + Insets.xs,
                      child: Center(
                        child: Icon(
                          Ionicons.document_text_outline,
                          size: IconSizes.lg * 0.8,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    HSpace.sm,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.document.name,
                            style: textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VSpace.xs,
                          if (!widget.document.isPublic)
                            Text(
                              "Not yet published",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: colorScheme.error),
                            )
                          else if ((widget.document.modules ?? []).isNotEmpty)
                            StyledHorizontalNameList(
                              (widget.document.modules ?? [])
                                  .map((p) => p.name)
                                  .whereType<String>()
                                  .toList(),
                              style: textTheme.labelSmall!.copyWith(
                                  color: colorScheme.onSurfaceVariant),
                              maxWidth: 440,
                            )
                          else
                            _buildTimeAgoSmall(
                                context, widget.document.uploaded),
                        ],
                      ),
                    ),
                  ]),
                ),
                ColumnItem(
                  width: TableColumnSizes.fileSize,
                  child: _buildDownloadInfo(context, widget.document.size),
                ),
                ColumnItem(
                    width: TableColumnSizes.fileUploaded,
                    child: _buildRatingInfo(context, "None")),
                ColumnItem(
                  width: TableColumnSizes.fileStatus,
                  child: UploadedStatus(widget.document.access),
                ),
              ]),
              if (_hovered) _buildActionButtons(context, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ColorScheme colorScheme) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
        decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest
                .withOpacity(_hovered ? 0.8 : 0.0),
            borderRadius: const BorderRadius.only(
              topRight: Corners.medRadius,
              bottomRight: Corners.medRadius,
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.document.isPublished) ...[
              TextBtn(
                "Share",
                isCompact: true,
                onPressed: () => _handleShareClick(context),
              ),
              HSpace.xs,
              IconBtn(
                Ionicons.create_outline,
                isCompact: true,
                tooltip: "Edit",
                onPressed: () => _handleEditClick(context),
              ),
            ] else ...[
              PrimaryBtn(
                label: "Publish",
                isCompact: true,
                onPressed: () => _handleEditClick(context),
              ),
              HSpace.xs,
              IconBtn(
                Ionicons.trash_bin_outline,
                isCompact: true,
                tooltip: "Delete",
                color: colorScheme.error,
                onPressed: () {/* Implement delete logic */},
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAgoSmall(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) return const SizedBox.shrink();
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Row(
      children: [
        Icon(
          Ionicons.calendar_outline,
          color: colorScheme.onSurfaceVariant,
          size: textTheme.labelSmall!.fontSize ?? 12,
        ),
        HSpace.xs,
        Text(
          time_ago.format(dateTime),
          style: textTheme.labelSmall!
              .copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildCategorySmall(BuildContext context, String categoryName) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Row(
      children: [
        Icon(
          Ionicons.folder_open_outline,
          color: colorScheme.onSurfaceVariant,
          size: textTheme.labelSmall!.fontSize ?? 12,
        ),
        HSpace.xs,
        Text(
          categoryName,
          style: textTheme.labelSmall!
              .copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildRatingInfo(BuildContext context, String rating) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Ionicons.star_outline,
          color: colorScheme.onSurfaceVariant,
          size: IconSizes.med * 0.85,
        ),
        HSpace.xs,
        Text(
          rating,
          style: textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildDownloadInfo(BuildContext context, String downloadCount) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Ionicons.download_outline,
          color: colorScheme.onSurfaceVariant,
          size: IconSizes.med * 0.85,
        ),
        HSpace.xs,
        Text(
          downloadCount,
          style: textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  void _handleDefaultClick(BuildContext context) {
    context.read<SharedBloc>().add(SharedShowFile(widget.document));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const SharedFileDialog(),
    );
  }

  void _handleEditClick(BuildContext context) {
    context.read<UploadEditBloc>().add(UploadEditStart(widget.document));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const UpdateFileDialog(),
    );
  }

  void _handleShareClick(BuildContext context) {
    final String baseUrl =
        kDebugMode ? "http://localhost:3000" : "https://doculode.com";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) =>
          UpdateShareDialog("$baseUrl/shared/${widget.document.id}"),
    );
  }
}

class DLResourceListItem extends StatelessWidget {
  const DLResourceListItem(this.document, {super.key});
  final RemoteDocModel document;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final BorderRadius borderRadius = Corners.medBorder;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.xs),
      child: InkWell(
        onTap: () {
          context.read<UploadEditBloc>().add(UploadEditStart(document));
          _handleOnTap(context);
        },
        borderRadius: borderRadius,
        hoverColor: colorScheme.primary.withOpacity(0.04),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.sm),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: Row(children: [
            ColumnItem(
              child: Row(children: [
                Container(
                  height: IconSizes.lg,
                  width: IconSizes.lg,
                  decoration: BoxDecoration(
                      borderRadius: Corners.smBorder,
                      color: colorScheme.surfaceContainer),
                  child: Center(
                    child: Icon(
                      Ionicons.document_text_outline,
                      size: IconSizes.lg * 0.75,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                HSpace.med,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.name,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      VSpace.xs,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            !document.isPublished
                                ? Ionicons.lock_closed_outline
                                : Ionicons.calendar_clear_outline,
                            color: !document.isPublished
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.primary,
                            size: textTheme.labelSmall!.fontSize ?? 12,
                          ),
                          HSpace.xs,
                          Text(
                            !document.isPublished
                                ? "Private"
                                : (document.modules!.isNotEmpty
                                    ? document.modules![0].name
                                    : "Published")!,
                            style: textTheme.labelSmall!.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          HSpace.xs,
                          const DotWidget(),
                          HSpace.xs,
                          Text(
                            document.size,
                            style: textTheme.labelSmall!.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _handleOnTap(BuildContext context) {
    return showStyledBottomSheet(context,
        child: Padding(
          padding: EdgeInsets.only(
              top: Insets.med,
              left: Insets.med,
              right: Insets.med,
              bottom: Insets.med + MediaQuery.of(context).viewInsets.bottom),
          child: const UploadEditView(),
        ));
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
    this.style,
  });
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return TextButton.icon(
      icon: icon != null
          ? Icon(icon, size: IconSizes.med)
          : const SizedBox.shrink(),
      label: Text(label),
      onPressed: () {
        onPressed();
      },
      style: style ??
          TextButton.styleFrom(
            foregroundColor:
                isDestructive ? colorScheme.error : colorScheme.primary,
            padding: EdgeInsets.symmetric(
                horizontal: Insets.med, vertical: Insets.lg),
            textStyle: textTheme.labelLarge,
            alignment: Alignment.centerLeft,
          ).copyWith(
            minimumSize: WidgetStateProperty.all(
                const Size(double.infinity, kMinInteractiveDimension)),
          ),
    );
  }
}

class DotWidget extends StatelessWidget {
  const DotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Text(
      "•",
      style: textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w800,
        color: colorScheme.onSurfaceVariant.withOpacity(0.6),
      ),
    );
  }
}
