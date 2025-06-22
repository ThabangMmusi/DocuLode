import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/utils/utils.dart';
import 'package:doculode/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'package:doculode/app/config/styles.dart';

class UploadFileWidget extends StatelessWidget {
  const UploadFileWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    final state = context.select((UploadProgressBloc bloc) => bloc.state);
    final file = state.pickedFiles[index];
    final progress = state.progressMap[file.name] ?? 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VSpace.sm,
                      Icon(
                        progress < 1
                            ? Ionicons.radio_button_off
                            : Ionicons.checkmark_circle_outline,
                        color: progress < 1
                            ? colors.onInverseSurface
                            : AppTheme.successColor,
                      ),
                    ],
                  ),
                  HSpace.xs,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                          file.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.surface),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Insets.sm)
                                .copyWith(top: 2),
                            decoration: BoxDecoration(
                                color: colors.inverseSurface,
                                borderRadius: Corners.lgBorder),
                            child: Text(
                              file.ext.toUpperCase(),
                              style: TextStyles.labelSmall.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: colors.surface),
                            ),
                          ),
                          HSpace.sm,
                          Text(
                            "Uploading... ${StringUtils.convertToPercentage(progress, 0)}",
                            style: TextStyles.labelSmall
                                .copyWith(color: colors.surface),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              //TODO: ADD THE EDIT BUTTON LATER
              // HSpace.xs,
              // SizedBox(
              //   height: 20,
              //   child: OutlinedButton(
              //       onPressed: () {},
              //       child: Text(
              //         "Edit",
              //         style: TextStyles.bodySmall,
              //       )),
              // )
            ],
          ),
          if (progress < 1) ...[
            VSpace.sm,
            LinearProgressIndicator(
              value: progress,
              backgroundColor: colors.inversePrimary,
              color: AppTheme.infoColor,
              borderRadius: const BorderRadius.all(Corners.medRadius),
            ),
          ]
        ],
      ),
    );
  }
}
