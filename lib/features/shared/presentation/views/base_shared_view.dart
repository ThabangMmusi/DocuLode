import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/shared/presentation/bloc/shared_bloc.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
import 'package:its_shared/widgets/gray_rounded_text.dart';
import 'package:its_shared/widgets/styled_horizontal_name_list.dart';
import 'package:its_shared/widgets/ui_text.dart';

class BaseSharedView extends StatelessWidget {
  const BaseSharedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return BlocBuilder<SharedBloc, SharedState>(
      builder: (context, state) {
        return Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiText(
              text: state.fileFullName,
              style: TextStyles.h2,
            ),
            VSpace.sm,

            StyledHorizontalNameList(
              state.modules.map((p) => p.name!).toList(),
              style: TextStyles.body3,
              maxWidth: 440,
            ),
            VSpace.sm,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AccessStateWidget(state.access),
                HSpace.sm,
                GrayRoundedText(state.type!.asString),
              ],
            ),
            // const Divider(),
            VSpace.med,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AbsorbPointer(
                  absorbing: state.owners,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconBtn(Icons.thumb_up_alt, onPressed: () {}),
                      const UiText(text: "2K"),
                      HSpace.med,
                      IconBtn(Icons.thumb_down_alt_outlined, onPressed: () {}),
                      const UiText(text: "126"),
                      HSpace.med,
                      const Icon(Icons.cloud_download),
                      const UiText(text: "100K"),
                    ],
                  ),
                ),
                const Spacer(),
                // RawBtn(
                //   // label: 'Save',
                //   icon: Icons.bookmarks_outlined,
                //   onPressed: () =>
                //       context.read<SharedBloc>().add(const SharedDownload()),
                // ),
                if (!state.owners)
                  SimpleBtn(
                    // enableShadow: false,
                    normalColors: BtnColors(
                        bg: colorScheme.onSurface, fg: colorScheme.onPrimary),
                    hoverColors: BtnColors(
                        bg: colorScheme.primary, fg: colorScheme.onPrimary),
                    child: Padding(
                      padding: EdgeInsets.all(Insets.xs),
                      child: Padding(
                        padding: EdgeInsets.all(Insets.xs),
                        child: const Icon(
                          Ionicons.bookmark_outline,
                          size: 21,
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),

                HSpace.med,
                PrimaryBtn(
                  label: 'Download',
                  onPressed: () =>
                      context.read<SharedBloc>().add(const SharedDownload()),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
