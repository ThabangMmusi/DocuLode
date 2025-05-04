import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/constants/responsive.dart';
import 'package:its_shared/core/components/module_selector.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
import 'package:its_shared/widgets/gray_rounded_text.dart';
import 'package:its_shared/widgets/inline_text_editor.dart';
import 'package:its_shared/widgets/styled_load_spinner.dart';

import '../../../../styles.dart';
import '../../../../widgets/styled_dropdown_textfield.dart';

class UploadEditView extends StatelessWidget {
  const UploadEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<UploadEditBloc, UploadEditState>(
        listener: (context, state) {
          if (state.status == UploadEditStatus.success) {
            return Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return state.status == UploadEditStatus.initial
              ? const Center(child: StyledLoadSpinner())
              : CustomScrollView(
                  slivers: <Widget>[
                    // if (Responsive.isMobile(context))
                    //   SliverPersistentHeader(
                    //     pinned: true,
                    //     delegate: MySliverAppBar(
                    //       minTopBarHeight: minTopBarHeight,
                    //       maxTopBarHeight: minTopBarHeight,
                    //       title: state.name,
                    //       leading: IconBtn(Ionicons.arrow_back,
                    //           onPressed: () => Navigator.of(context).pop()),
                    //       // trailing: Row(
                    //       //   children: [
                    //       //     // IconButton.filled(
                    //       //     //   onPressed: () {},
                    //       //     //   icon: Icon(Ionicons.filter),
                    //       //     // ),
                    //       //     DLFilledButton(
                    //       //       "Uploads",
                    //       //       onPressed: () async {
                    //       //         await PickFileCommand()
                    //       //             .run(enableCamera: false)
                    //       //             .then((pickedFiles) {
                    //       //           if (pickedFiles.isNotEmpty) {
                    //       //             BlocProvider.of<UploadProgressBloc>(context)
                    //       //                 .add(UploadingFiles(pickedFiles));
                    //       //           }
                    //       //         });
                    //       //       },
                    //       //       // icon: Ionicons.cloud_upload_outline,
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //     ),
                    //   ),

                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isMobile(context)
                              ? Insets.lg + Insets.sm
                              : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _NameField(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AccessStateWidget(state.access),
                                  HSpace.sm,
                                  GrayRoundedText(".${state.ext}"),
                                ],
                              ),
                            ],
                          ),
                          VSpace.med,
                          SizedBox(
                            height: 209,
                            child: ModuleSelector(
                              modules: state.modules,
                              onModulePress: (module) => context
                                  .read<UploadEditBloc>()
                                  .add(UploadEditSelectModule(module)),
                              selectedModules: state.selectedModules,
                              label: "Upload Type",
                              value: state.type,
                              listItems: List.generate(
                                UploadCategory.values.length,
                                (int index) => AppListItem(
                                    UploadCategory.values[index].asString,
                                    value: UploadCategory.values[index]),
                              ),
                              onChange: (p0) => context
                                  .read<UploadEditBloc>()
                                  .add(UploadEditTypesChanged(p0)),
                            ),
                          ),
                          const Divider(height: 1),
                          VSpace.lg,
                          Row(
                            children: [
                              const Spacer(),
                              PrimaryBtn(
                                label: state.access.isUnpublished
                                    ? "Publish"
                                    : 'Save Changes',
                                onPressed: () {
                                  context
                                      .read<UploadEditBloc>()
                                      .add(const UploadEditSubmit());
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                );
        },
      ),
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
          style: TextStyles.body2,
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
    final state = context.watch<UploadEditBloc>().state;

    return InlineTextEditor(
      state.name,
      key: const Key('editTodoView_title_textFormField'),
      width: MediaQuery.of(context).size.width,
      maxLength: 150,
      style: TextStyles.h2,
      maxLines: 3,
      // suffix: Padding(
      //   padding: EdgeInsets.all(Insets.sm),
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: Insets.sm).copyWith(top: 2),
      //     decoration: BoxDecoration(
      //         color: colors.inverseSurface, borderRadius: Corners.lgBorder),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           state.ext.toUpperCase(),
      //           style: TextStyles.body3.copyWith(color: colors.surface),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

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
