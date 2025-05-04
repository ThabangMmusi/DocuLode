// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:its_shared/constants/responsive.dart';
// import 'package:its_shared/core/bloc/auth/auth_bloc.dart';
// import 'package:its_shared/core/common/settings/presentation/bloc/base_settings_bloc.dart';
// import 'package:its_shared/routes/app_pages.dart';
// import 'package:its_shared/styles.dart';
// import 'package:its_shared/widgets/styled_load_spinner.dart';

// import '../../../../constants/app_text.dart';
// import '../../../../core/common/settings/presentation/views/step_one_view.dart';
// import '../../../../widgets/buttons/styled_buttons.dart';
// import '../../../../widgets/styled_dropdown_textfield.dart';
// import '../bloc/settings_bloc.dart';
// import '../widget/setup_side_image.dart';
// import '../../../../core/components/module_selector.dart';
// class SettingsView extends StatefulWidget {
//   const SettingsView({super.key});

//   @override
//   State<SettingsView> createState() => _SettingsViewState();
// }

// class _SettingsViewState extends State<SettingsView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SettingsBloc>().add(GetAllCoursesEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final size = MediaQuery.of(context).size;
//     final isMobile = Responsive.isMobile(context);

//     return SafeArea(
//       child: BlocConsumer<SettingsBloc, BaseSettingsState>(
//         listener: (_, state) {
//           if (state.status == SettingsStatus.done) {
//             context.go(Routes.home);
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             body: Row(
//               children: [
//                 SizedBox(
//                   width: isMobile ? size.width : (size.width * 0.5),
//                   child: Center(
//                     child: Container(
//                       constraints: const BoxConstraints(maxWidth: 600),
//                       padding: EdgeInsets.all(Responsive.sidePadding(context))
//                           .copyWith(bottom: Insets.lg),
//                       color: colorScheme.surface,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           _HeaderTitles(),
//                           Expanded(
//                             child: _buildMainContent(state, context),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (!isMobile) const SetupSideImage(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildMainContent(BaseSettingsState state, BuildContext context) {
//     final isLoading = state.status == SettingsStatus.loading;
//     final isFinalizing = state.status == SettingsStatus.finalizing;

//     return IgnorePointer(
//       ignoring: isFinalizing,
//       child: Opacity(
//         opacity: isFinalizing ? 0.75 : 1,
//         child: Column(
//           children: [
//             if (isLoading && state.selectedCourse == null)
//               const StyledLoadSpinner()
//             else ...[
//               const CourseSettings<SettingsBloc>(),
//               VSpace.med,
//               if (state.selectedCourse != null && state.userLevel != 0)
//                 _buildModuleSection(state, context),
//             ]
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildModuleSection(BaseSettingsState state, BuildContext context) {
//     if (state.status == SettingsStatus.loading) {
//       return Padding(
//         padding: EdgeInsets.all(Insets.med),
//         child: const StyledLoadSpinner(),
//       );
//     }

//     return Expanded(
//       child: Column(
//         children: [
//           Expanded(
//             child: ModuleSelector(
//               selectedModules: state.selectedModules,
//               modules: state.modules,
//               onModulePress: (module) =>
//                   context.read<SettingsBloc>().add(SelectModuleEvent(module)),
//               label: "Semester",
//               listItems: List.generate(
//                 2,
//                 (index) => AppListItem("Semester ${index + 1}", value: index + 1),
//               ),
//               onChange: (value) => context
//                   .read<SettingsBloc>()
//                   .add(SelectSemesterEvent(value!)),
//             ),
//           ),
//           const Divider(thickness: 1, height: 1),
//           VSpace.lg,
//           _buildActionButtons(state, context),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(BaseSettingsState state, BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         if (state.status != SettingsStatus.finalizing)
//           SecondaryBtn(
//             onPressed: () =>
//                 context.read<AuthBloc>().add(AuthLogoutRequested()),
//             label: "Logout",
//           ),
//         if (state.status == SettingsStatus.finalizing) ...[
//           HSpace.lg,
//           const StyledLoadSpinner()
//         ] else
//           PrimaryBtn(
//             key: const Key('setup_submit_button'),
//             onPressed: () =>
//                 context.read<SettingsBloc>().add(UpdateUserModulesEvent()),
//             label: "Start the Journey",
//           ),
//       ],
//     );
//   }
// }

// class _HeaderTitles extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
    
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             Text(
//               tAppName,
//               style: TextStyles.h2.copyWith(color: colorScheme.primary),
//             ),
//           ],
//         ),
//         VSpace(Insets.xl),
//         Text("Welcome!", textAlign: TextAlign.center, style: TextStyles.h1),
//         VSpace.med,
//         Text(
//           "Lets finalize few things...",
//           textAlign: TextAlign.center,
//           style: TextStyles.h3,
//         ),
//         Text(
//           "You can always change them later.",
//           style: TextStyles.body2.copyWith(
//             fontWeight: FontWeight.w400,
//             color: colorScheme.onInverseSurface,
//           ),
//         ),
//         VSpace.med,
//       ],
//     );
//   }
// }
