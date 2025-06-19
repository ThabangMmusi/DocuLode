import 'package:doculode/core/components/app_logo.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/features/shared/presentation/views/base_shared_view.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'package:doculode/config/styles.dart';

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
            const AppLogo(),
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
      child: Container(
          padding: EdgeInsets.all(Insets.lg),
          // color: colorScheme.surface,
          child: const BaseSharedView()),
    );
  }

  Widget _buildErrorUI(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
        padding: EdgeInsets.all(Insets.lg),
        // color: colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Ionicons.close_circle, size: 56, color: colorScheme.error),
            VSpace.xs,
            UiText(
              text: "Error Loading...",
              style:
                  TextStyles.headlineMedium.copyWith(color: colorScheme.error),
            ),
            VSpace.xs,
            UiText(
              text:
                  "File is not found or the url enter is incorrect.", // Replace with your actual file name
              style: TextStyles.bodySmall,
            ),
          ],
        ));
  }
}
