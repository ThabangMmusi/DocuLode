import 'package:doculode/core/domain/entities/app_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:doculode/core/components/module_selector.dart';
import 'package:doculode/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:doculode/core/widgets/styled_text_input.dart';
import 'package:doculode/core/widgets/styled_load_spinner.dart';

import 'package:doculode/core/core.dart';
import 'package:doculode/app/config/styles.dart';
import 'package:doculode/core/widgets/styled_dropdown_textfield.dart';
import 'package:doculode/features/uploads/presentation/components/dl_button.dart';

class UploadEditBase extends StatelessWidget {
  const UploadEditBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadEditBloc, UploadEditState>(
      listener: (context, state) {
        if (state.status == UploadEditStatus.success) {
          return Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return state.status == UploadEditStatus.initial
            ? const Center(child: StyledLoadSpinner())
            : SizedBox(
                height: 425,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _NameField(),
                      VSpace.med,
                      Expanded(
                        child: ModuleSelector(
                          modules: state.modules,
                          onModulePress: (module) => context
                              .read<UploadEditBloc>()
                              .add(UploadEditSelectModule(module)),
                          selectedModules: state.selectedModules,
                          label: "Upload Type",
                          // value: 0,
                          listItems: List.generate(
                            UploadCategory.values.length,
                            (int index) => AppListItem(
                                UploadCategory.values[index].asString,
                                value: UploadCategory.values[index].asInt),
                          ),
                          onChange: (p0) {
                            // context.read<SetupBloc>().add(SetupLevelChange(p0!));
                          },
                        ),
                      ),
                      Divider(
                        height: Insets.lg - 1,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          DLFilledButton(
                            'Upload',
                            // iconToRight: true,
                            icon: Ionicons.arrow_up_circle_outline,
                            onPressed: () async {
                              // UploadFileCommand().run(files: pickedImage!);
                              // Trigger file upload event
                              // BlocProvider.of<UploadProgressBloc>(context)
                              //     .add(UploadFiles(pickedImage!));
                            },
                          )
                        ],
                      )
                    ]),
              );
      },
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle(
    this.title, {
    this.trailing,
    super.key,
  });
  final String title;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.bodyMedium,
        ),
        trailing ?? Container()
      ],
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    final state = context.watch<UploadEditBloc>().state;

    return StyledTextInput(
      key: const Key('editTodoView_title_textFormField'),
      label: "Filename",
      initialValue: state.name,
      maxLength: 50,
      suffixWidget: Padding(
        padding: EdgeInsets.all(Insets.sm),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Insets.sm).copyWith(top: 2),
          decoration: BoxDecoration(
              color: colors.inverseSurface, borderRadius: Corners.lgBorder),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.ext.toUpperCase(),
                style: TextStyles.bodySmall.copyWith(color: colors.surface),
              ),
            ],
          ),
        ),
      ),
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(50),
      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      // ],
      onChanged: (value) {
        context.read<UploadEditBloc>().add(UploadEditNameChanged(value));
      },
    );
  }
}
