import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/shared/presentation/bloc/shared_bloc.dart';
import 'package:its_shared/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:its_shared/features/uploads/presentation/components/dl_button.dart';
import 'package:its_shared/features/uploads/presentation/components/uploaded_status.dart';
import 'package:its_shared/features/upload_edit/presentation/views/update_file_dialog.dart';
import 'package:its_shared/features/uploads/presentation/views/upload_file_view.dart';
import 'package:its_shared/routes/app_pages.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/ui_text.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '../../../../themes.dart';
import '../../../../widgets/buttons/styled_buttons.dart';
import '../../../../widgets/styled_bottom_sheet.dart';
import '../../../../widgets/styled_horizontal_name_list.dart';
import '../../../shared/presentation/views/shared_dialog.dart';
import '../../../upload_edit/presentation/views/upload_edit_view.dart';
import '../uploads_constants.dart';
import '../views/upload_share_dialog.dart';

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
        onTap: () => widget.document.isPublished
            ? _handleDefaultClick(context)
            : _handleEditClick(context),
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        borderRadius: borderRadius,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
          decoration: BoxDecoration(
              // borderRadius: borderRadius,
              color: _hovered ? AppTheme.bg1 : Colors.transparent),
          child: Stack(
            children: [
              Row(children: [
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
                          Text(widget.document.name),
                          Row(
                            children: [
                              // buildTimeAgoSmall(colorScheme),
                              // HSpace.sm,
                              if (!widget.document.isPublic)
                                Text(
                                  "Not yet published",
                                  style: TextStyles.caption
                                      .copyWith(color: colorScheme.error),
                                )
                              else
                                StyledHorizontalNameList(
                                  widget.document.modules!
                                      .map((p) => p.name!)
                                      .toList(),
                                  style: TextStyles.caption,
                                  maxWidth: 440,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // if (_hovered)
                    //   Row(
                    //     children: [
                    //       DlTableIconButton(
                    //         icon: Icons.publish_outlined,
                    //         onPressed: () {
                    //           context.read<UploadEditBloc>().add(
                    //                 UploadEditStart(widget.document),
                    //               );
                    //           showDialog(
                    //             context: context,
                    //             barrierDismissible: false,
                    //             builder: (context) => const UpdateFileDialog(),
                    //           );
                    //         },
                    //       ),
                    //       DlTableIconButton(
                    //         icon: Ionicons.trash_bin_outline,
                    //         onPressed: () {},
                    //       ),
                    //       HSpace.sm
                    //     ],
                    //   ),
                  ]),
                ),
                ColumnItem(
                  width: TableColumnSizes.fileSize,
                  child: buildDownload(),
                ),
                ColumnItem(
                    width: TableColumnSizes.fileUploaded,
                    child: buildRating(colorScheme)),

                //  ColumnItem(
                //   width: TableColumnSizes.fileUploaded,
                //   child: TableText(timeAgo.format(widget.document.uploaded)),
                // ),
                ColumnItem(
                  width: TableColumnSizes.fileStatus,
                  child: UploadedStatus(widget.document.access),
                ),
              ]),
              if (_hovered) buildOnHover(colorScheme, context)
            ],
          ),
        ),
      ),
    );
  }

  Align buildOnHover(ColorScheme colorScheme, BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.all(Insets.xs),
        decoration:
            BoxDecoration(color: _hovered ? AppTheme.bg1 : colorScheme.surface),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.document.isPublished) ...[
              RawBtn(
                enableShadow: false,
                normalColors: BtnColors(
                    bg: colorScheme.onSurface, fg: colorScheme.onPrimary),
                hoverColors: BtnColors(
                    bg: colorScheme.primary, fg: colorScheme.onPrimary),
                child: const BtnContent(
                  isCompact: true,
                  label: "Share",
                ),
                onPressed: () => _handleShareClick(context),
              ),
              HSpace.sm,
              // RawBtn(
              //   enableShadow: false,
              //   normalColors: BtnColors(
              //       bg: colorScheme.onSurface, fg: colorScheme.onPrimary),
              //   hoverColors: BtnColors(
              //       bg: colorScheme.primary, fg: colorScheme.onPrimary),
              //   child: const BtnContent(
              //     isCompact: true,
              //     label: "Edit",
              //   ),
              //   onPressed: () => _handleEditClick(context),
              // ),
              IconBtn(
                Icons.edit_note,
                onPressed: () => _handleEditClick(context),
              ),
              // HSpace.sm,
              // IconBtn(Icons.more_vert, onPressed: () {}),
            ] else ...[
              PrimaryBtn(
                label: "Publish",
                isCompact: true,
                onPressed: () => _handleEditClick(context),
              ),
              HSpace.sm,
              IconBtn(Ionicons.trash_bin_outline, onPressed: () {})
            ],
          ],
        ),
      ),
    );
  }

  Row buildTimeAgoSmall(ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Ionicons.calendar_outline,
          color: colorScheme.primary,
          size: 12,
        ),
        HSpace.xs,
        Text(
          timeAgo.format(widget.document.uploaded!),
          style: TextStyles.caption.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Row buildCategorySmall(ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Ionicons.school,
          color: colorScheme.primary,
          size: 12,
        ),
        HSpace.xs,
        Text(
          widget.document.type!.asString,
          style: TextStyles.caption.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Row buildRating(ColorScheme colorScheme) {
    return Row(
      children: [
        const Icon(
          Icons.thumb_up,
          // color: colorScheme.primary,
          size: 16,
        ),
        HSpace.xs,
        Text(
          "None",
          style: TextStyles.body2.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Row buildDownload() {
    return Row(
      children: [
        const Icon(
          Icons.download,
          // color: colorScheme.primary,
          size: 18,
        ),
        HSpace.xs,
        Text(
          "0",
          style: TextStyles.body2.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  void _handleDefaultClick(BuildContext context) {
    context.read<SharedBloc>().add(
          SharedShowFile(widget.document),
        );
    // context.go('/uploads/${widget.document.id}');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SharedFileDialog(),
    );
  }

  void _handleEditClick(BuildContext context) {
    context.read<UploadEditBloc>().add(
          UploadEditStart(widget.document),
        );
    // context.go('/uploads/${widget.document.id}');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const UpdateFileDialog(),
    );
  }

  void _handleShareClick(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => UpdateShareDialog(
          "${kDebugMode ? "http://localhost:23429" : "https://spushare-2023.web.app"}/shared/${widget.document.id}"),
    );
  }
}

class DLResourceListItem extends StatelessWidget {
  const DLResourceListItem(
    this.document, {
    super.key,
  });

  final RemoteDocModel document;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    const borderRadius = Corners.medBorder;
    // final padding = EdgeInsets.symmetric(horizontal: Insets.med, vertical: 0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg),
      child: InkWell(
        onTap: () {
          context.read<UploadEditBloc>().add(
                UploadEditStart(document),
              );
          _handleOnTap(context);
          // context.go(Routes.uploadsEdit(document.id!));
        },
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        borderRadius: borderRadius,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
          decoration: const BoxDecoration(
              borderRadius: borderRadius, color: Colors.transparent),
          child: Row(children: [
            ColumnItem(
              child: Row(children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(color: Colors.grey)),
                  child: const Center(
                    child: Icon(Ionicons.document_outline),
                  ),
                ),
                HSpace.xs,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Insets.xs),
                        child: Text(
                          document.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.body2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.xs,
                          vertical: Insets.xs,
                        ),
                        // decoration: BoxDecoration(
                        // borderRadius: Corners.xlBorder,
                        // color: Colors.red[50]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              !document.isPublished
                                  ? Ionicons.lock_closed
                                  : Ionicons.calendar_outline,
                              color: colorScheme.primary,
                              size: 12,
                            ),
                            HSpace.xs,
                            if (!document.isPublished)
                              Text(
                                "Private",
                                style: TextStyles.callout2.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              )
                            else
                              Text(document.modules![1].id),
                            HSpace.xs,
                            const DotWidget(),
                            HSpace.xs,
                            Text(
                              document.size,
                              style: TextStyles.callout2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
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

  Future<void> _handleOnTapOld(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return showStyledBottomSheet(context,
        child: Padding(
          padding: EdgeInsets.all(Insets.med),
          child: Column(
            children: [
              BottomSheetButton(
                onPressed: () {
                  context.read<UploadEditBloc>().add(
                        UploadEditStart(document),
                      );
                  context.go(Routes.uploadsEdit(document.id!));
                },
                label: "Publish Resource",
                icon: Ionicons.cloud_upload_outline,
              ),
              BottomSheetButton(
                onPressed: () {},
                label: "Remove",
                icon: Ionicons.trash_bin_outline,
                normalColors:
                    BtnColors(bg: Colors.transparent, fg: colorScheme.error),
              ),
            ],
          ),
        ));
  }

  Future<void> _handleOnTap(BuildContext context) {
    return showStyledBottomSheet(context,
        child: Padding(
          padding: EdgeInsets.all(Insets.med),
          child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              child: const UploadEditView()),
        ));
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.normalColors,
  });
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;
  final BtnColors? normalColors;
  @override
  Widget build(BuildContext context) {
    return SimpleBtn(
      onPressed: () {
        onPressed.call();
        Navigator.of(context).pop();
      },
      normalColors: normalColors,
      child: Row(
        children: [
          BtnContent(
            leadingIcon: true,
            icon: icon,
            label: label,
            labelStyle: TextStyles.body2.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "•",
      style: TextStyles.body3.copyWith(
        fontWeight: FontWeight.w800,
        color: Colors.grey,
      ),
    );
  }
}
