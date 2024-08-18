import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/ui_text.dart';

import '../../domain/entities/module.dart';

class ModuleWidget extends StatelessWidget {
  const ModuleWidget(this.module, {super.key});
  // final VoidCallback? onPress;
  final Module module;
  // final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupState>(
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<SetupBloc>().add(SetupModulesSelectedChange(module));
            },
            child: Container(
                height: 42,
                padding: EdgeInsets.symmetric(horizontal: Insets.med),
                child: Row(
                  children: [
                    _buildIcon(context, module),
                    Text(module.name),
                  ],
                )),
          ),
        );
      },
    );
  }

  Widget _buildIcon(BuildContext context, Module module) {
    final state = context.watch<SetupBloc>().state;
    ColorScheme colors = Theme.of(context).colorScheme;
    Color primary = colors.primary;
    Color onSurface = colors.onSurface;
    Color onPrimary = colors.onPrimary;
    Color border = colors.onInverseSurface;
    bool isSelected = false;
    if (state.selectedModules.isNotEmpty) {
      isSelected = state.selectedModules.contains(module);
    }
    final currentIcon =
        isSelected ? Ionicons.checkbox : Ionicons.checkbox_outline;

    return Icon(
      currentIcon,
      color: isSelected ? primary : onSurface,
    );
  }
}
