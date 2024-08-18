import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:its_shared/features/uploads/presentation/components/dl_button.dart';
import 'package:its_shared/features/uploads/presentation/components/uploaded_status.dart';
import 'package:its_shared/features/upload_edit/presentation/views/update_file_dialog.dart';
import 'package:its_shared/features/uploads/presentation/views/upload_file_view.dart';
import 'package:its_shared/styles.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '../uploads_constants.dart';

class DLTableRow extends StatefulWidget {
  const DLTableRow(
    this.document, {
    super.key,
  });

  final RemoteDocModel document;

  @override
  State<DLTableRow> createState() => _DLTableRowState();
}

class _DLTableRowState extends State<DLTableRow> {
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    const borderRadius = Corners.medBorder;
    // final padding = EdgeInsets.symmetric(horizontal: Insets.med, vertical: 0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.xl),
      child: InkWell(
        onHover: (value) => setState(() => _hovered = value),
        onTap: () {},
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        borderRadius: borderRadius,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
          decoration: BoxDecoration(
              // borderRadius: borderRadius,
              color: _hovered
                  ? colorScheme.tertiaryContainer.withAlpha(60)
                  : Colors.transparent),
          child: Row(children: [
            ColumnItem(
              child: Row(children: [
                SizedBox(
                  height: 38,
                  child: Stack(
                    children: [
                      Container(
                        color: colorScheme.error,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Ionicons.document_outline),
                      ),
                    ],
                  ),
                ),
                HSpace.xs,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TableText(widget.document.name),
                      Row(
                        children: [
                          // Icon(
                          //   Ionicons.calendar_outline,
                          //   color: colorScheme.primary,
                          //   size: 12,
                          // ),
                          // HSpace.sm,
                          if (widget.document.modules.isEmpty)
                            Text(
                              "Not yet accessible by public",
                              style: TextStyles.caption
                                  .copyWith(color: colorScheme.error),
                            )
                          else
                            Text(widget.document.modules[1])
                        ],
                      ),
                    ],
                  ),
                ),
                if (_hovered)
                  Row(
                    children: [
                      DlTableIconButton(
                        icon: Icons.publish_outlined,
                        onPressed: () {
                          context.read<UploadEditBloc>().add(
                                UploadEditLoaded(widget.document),
                              );
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const UpdateFileDialog(),
                          );
                        },
                      ),
                      DlTableIconButton(
                        icon: Ionicons.trash_bin_outline,
                        onPressed: () {},
                      ),
                      HSpace.sm
                    ],
                  ),
              ]),
            ),
            ColumnItem(
              width: TableColumnSizes.fileSize,
              child: TableText(widget.document.size),
            ),
            ColumnItem(
              width: TableColumnSizes.fileUploaded,
              child: TableText(timeAgo.format(widget.document.uploaded)),
            ),
            ColumnItem(
                width: TableColumnSizes.fileStatus,
                child: widget.document.modules.isEmpty
                    ? const Row(
                        children: [
                          UploadedStatus(),
                        ],
                      )
                    : const Row()),
          ]),
        ),
      ),
    );
  }
}
