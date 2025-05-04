import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/themes.dart';

import '../../../../styles.dart';
import '../bloc/upload_progress_bloc.dart';
import '../components/upload_file_widget.dart';

class UploadProgressView extends StatelessWidget {
  const UploadProgressView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    final state = context.select((UploadProgressBloc bloc) => bloc.state);
    return Container(
      margin: EdgeInsets.only(right: Insets.med, bottom: Insets.med),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: colors.inversePrimary,
        borderRadius: Corners.lgBorder,
        boxShadow: Shadows.universal,
      ),
      //todo: make sure the list view don't overlap
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!state.collapsed) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                      vertical: Insets.sm, horizontal: Insets.lg)
                  .copyWith(bottom: Insets.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Uploading",
                    style: TextStyles.h3.copyWith(color: colors.surface),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              BlocProvider.of<UploadProgressBloc>(context)
                                  .add(const UpdateUploadUi(collapsed: true)),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: colors.surface,
                          )),
                      if (state.uploadComplete)
                        IconButton(
                            onPressed: () =>
                                BlocProvider.of<UploadProgressBloc>(context)
                                    .add(const UpdateUploadUi(close: true)),
                            icon: Icon(
                              Icons.close,
                              color: colors.surface,
                            ))
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
            SizedBox(
              height: state.itemsCount >= 5 ? 65 * 5 : null,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: Insets.med),
                shrinkWrap: state.itemsCount >= 5 ? false : true,
                itemCount: state.progressMap.length,
                separatorBuilder: (context, index) => VSpace.sm,
                itemBuilder: (context, index) {
                  return UploadFileWidget(index: index);
                },
              ),
            ),
          ],
          buildBottom(state, colors, context)
        ],
      ),
    );
  }

  Container buildBottom(
      UploadState state, ColorScheme colors, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: colors.primary,
          color: state.uploadComplete
              ? AppTheme.greenSurface
              : AppTheme.blueSurface,
          borderRadius: Corners.lgBorder),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Insets.lg),
            decoration: BoxDecoration(
                // color: colors.error,
                color: state.uploadComplete
                    ? AppTheme.greenSurfaceDark
                    : AppTheme.blueSurfaceDark,
                borderRadius: Corners.lgBorder),
            child: Icon(
              Icons.upload,
              color: colors.surface,
            ),
          ),
          HSpace.sm,
          Column(
            children: [
              Text(
                "Uploaded ${state.completed} of ${state.progressMap.length} files",
                style: TextStyles.h3.copyWith(color: colors.surface),
              )
            ],
          ),
          if (state.collapsed) ...[
            const Spacer(),
            IconButton(
                onPressed: () => BlocProvider.of<UploadProgressBloc>(context)
                    .add(const UpdateUploadUi(collapsed: false)),
                icon: Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: colors.surface,
                )),
            IconButton(
                onPressed: () => BlocProvider.of<UploadProgressBloc>(context)
                    .add(const UpdateUploadUi(close: true)),
                icon: Icon(
                  Icons.close,
                  color: colors.surface,
                )),
            HSpace.med
          ]
        ],
      ),
    );
  }
}
