import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/shared/presentation/views/base_shared_view.dart';
import 'package:its_shared/widgets/styled_load_spinner.dart';

import '../../../../styles.dart';
import '../../../../widgets/buttons/styled_buttons.dart';
import '../../../../widgets/ui_text.dart';
import '../bloc/shared_bloc.dart';

class SharedView extends StatefulWidget {
  const SharedView(this.id, {super.key});
  final String id;
  @override
  State<SharedView> createState() => _SharedViewState();
}

class _SharedViewState extends State<SharedView> {
  @override
  void initState() {
    super.initState();
    context.read<SharedBloc>().add(SharedViewStart(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<SharedBloc, SharedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            VSpace.xl,
            const FullAppLogo(),
            Expanded(
              child: Center(
                  child: state.status == SharedStatus.initial
                      ? const StyledLoadSpinner()
                      : state.status == SharedStatus.failure
                          ? _buildErrorUI(context)
                          : _buildFileDetails(context, state)),
            ),
            VSpace(Insets.xl * 3),
          ],
        );
      },
    )));
  }

  Widget _buildFileDetails(BuildContext context, SharedState state) {
    ThemeData theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 750, maxHeight: 178),
      child: RoundedBorder(
          color: theme.dividerColor,
          ignorePointer: false,
          child: Container(
              padding: EdgeInsets.all(Insets.lg),
              // color: colorScheme.surface,
              child: const BaseSharedView())),
    );
  }

  RoundedBorder _buildErrorUI(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return RoundedBorder(
        color: theme.dividerColor,
        child: Container(
            padding: EdgeInsets.all(Insets.lg),
            // color: colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Ionicons.close_circle, size: 56, color: colorScheme.error),
                VSpace.xs,
                UiText(
                  text: "Error Loading...",
                  style: TextStyles.h2.copyWith(color: colorScheme.error),
                ),
                VSpace.xs,
                UiText(
                  text:
                      "File is not found or the url enter is incorrect.", // Replace with your actual file name
                  style: TextStyles.body3,
                ),
              ],
            )));
  }
}
