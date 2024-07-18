import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/_utils/string_utils.dart';
import 'package:its_shared/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';
import 'package:its_shared/themes.dart';

import '../../../../styles.dart';

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
                            : AppTheme.greenSurfaceDark,
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
                          style: TextStyles.body2.copyWith(
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
                              style: TextStyles.body4.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: colors.surface),
                            ),
                          ),
                          HSpace.sm,
                          Text(
                            "Uploading... ${StringUtils.convertToPercentage(progress, 0)}",
                            style: TextStyles.body4
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
              //         style: TextStyles.body3,
              //       )),
              // )
            ],
          ),
          if (progress < 1) ...[
            VSpace.sm,
            LinearProgressIndicator(
              value: progress,
              backgroundColor: colors.inversePrimary,
              color: AppTheme.blueSurface,
              borderRadius: const BorderRadius.all(Corners.medRadius),
            ),
          ]
        ],
      ),
    );
  }
}
