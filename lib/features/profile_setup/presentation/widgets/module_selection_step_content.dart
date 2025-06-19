import 'package:doculode/config/index.dart';
import 'package:doculode/core/constants/index.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/utils/index.dart';
import 'package:doculode/features/profile_setup/presentation/bloc/profile_setup_bloc.dart';
import 'package:doculode/widgets/buttons/buttons.dart';
import 'package:doculode/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doculode/widgets/index.dart';

import 'checkable_dropdown_button.dart';

class ModuleSelectionStepContent extends StatefulWidget {
  final ProfileSetupState state;
  const ModuleSelectionStepContent({super.key, required this.state});

  @override
  State<ModuleSelectionStepContent> createState() =>
      _ModuleSelectionStepContentState();
}

class _ModuleSelectionStepContentState
    extends State<ModuleSelectionStepContent> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // By default, select the current year
    if (widget.state.selectedYear != null) {
      context
          .read<ProfileSetupBloc>()
          .add(SelectedYearsChanged({widget.state.selectedYear!}));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = widget.state;
    final bool isLoadingModules =
        state.activeOperation == ProfileSetupOperation.loadingModules &&
            state.operationStatus == OperationStatus.inProgress;
    final bool isSubmitting =
        state.activeOperation == ProfileSetupOperation.submittingProfile &&
            state.operationStatus == OperationStatus.inProgress;
    final bool canSubmit =
        state.isModulesValid && !isSubmitting && !isLoadingModules;

    final List<int> yearsWithModules = state.availableModulesByYear.keys
        .toList()
      ..sort((a, b) =>
          b.compareTo(a)); // Filter modules by selected years and search query
    Map<int, List<ModuleModel>> filteredModulesByYear = {
      for (var year in yearsWithModules)
        if (state.selectedYears.contains(year))
          year: (state.availableModulesByYear[year] ?? [])
              .where((m) =>
                  m.name != null &&
                  m.name!.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList(),
    };

    return Column(
        key: const ValueKey('module_selection_content_widget'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLoadingModules && yearsWithModules.isEmpty)
            SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator()))
          else if (yearsWithModules.isEmpty && !isLoadingModules)
            Container(
              height: 250,
              alignment: Alignment.center,
              padding: EdgeInsets.all(Insets.med),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                  borderRadius: Corners.medBorder),
              child: Text(tNoModulesAvailable,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: StyledTextInput(
                    hintText: 'Search modules...',
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                if (state.selectedYear! > 1) ...[
                  HSpace.sm,
                  CheckableDropdownButton<int>(
                    options: List.generate(state.selectedYear!,
                            (index) => state.selectedYear! - index)
                        .map((year) => DropdownOption(
                            year == state.selectedYear
                                ? 'Current Year'
                                : '$year${StringUtils.getOrdinal(year)} Year',
                            year))
                        .toList(),
                    selectedValues: state.selectedYears,
                    onChanged: (newYears) {
                      context
                          .read<ProfileSetupBloc>()
                          .add(SelectedYearsChanged(Set.from(newYears)));
                    },
                    hintText: 'Filter',
                    width: 220,
                  ),
                ]
              ],
            ),
            VSpace.med,
            SizedBox(
              height: 200, // Maintain fixed height for the scroll area + loader
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.5),
                  ),
                  borderRadius: Corners.medBorder,
                ),
                child: ClipRRect(
                    borderRadius:
                        Corners.medBorder, // Clip content to rounded border
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  filteredModulesByYear.entries.expand((entry) {
                                final year = entry.key;
                                final modules = entry.value;
                                final selectedModules =
                                    state.selectedModulesByYear[year] ?? [];
                                if (modules.isEmpty &&
                                    !state.isLoadingAdditionalModules) {
                                  return <Widget>[];
                                }
                                return [
                                  _YearlyModuleSection(
                                    key: ValueKey(
                                        'year_section_$year'), // Key for animation
                                    year: year,
                                    showHeader: year != state.selectedYear &&
                                        state.selectedYears.length != 1,
                                    selectedYear: state.selectedYear!,
                                    modules: modules,
                                    selectedModules: selectedModules,
                                    onModuleToggled: (module) => context
                                        .read<ProfileSetupBloc>()
                                        .add(ModuleToggled(module, year)),
                                  ),
                                ];
                              }).toList(),
                            ),
                          ),
                        ),
                        // Animated Loading Indicator
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(
                                        0.0, 0.5), // Slide up from bottom
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOutCubic)),
                                  child: child,
                                ),
                              );
                            },
                            child: state.isLoadingAdditionalModules
                                ? ShaderMask(
                                    key: const ValueKey(
                                        'loading_indicator_content'), // Key for AnimatedSwitcher
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black, // Opaque
                                          Colors.black.withOpacity(0.8),
                                          Colors
                                              .transparent, // Fades out at bottom
                                        ],
                                        stops: const [0.0, 0.6, 1.0],
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Container(
                                      width:
                                          double.infinity, // Takes full width
                                      color: theme.colorScheme.surfaceVariant
                                          .withOpacity(
                                              0.9), // Background for loader
                                      padding: EdgeInsets.symmetric(
                                          vertical: Insets.sm + 2,
                                          horizontal: Insets.med),
                                      child:
                                          _buildLoadingIndicatorContent(theme),
                                    ),
                                  )
                                : const SizedBox.shrink(
                                    key: ValueKey(
                                        'no_loading_indicator')), // Key for AnimatedSwitcher
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            VSpace.lg,
            PrimaryBtn(
              label: tCompleteAcademicsButton.toUpperCase(),
              isLoading: isSubmitting,
              onPressed: canSubmit
                  ? () => context
                      .read<ProfileSetupBloc>()
                      .add(const SubmitRegistration())
                  : null,
            ),
           ],
        ]);
  }

  Widget _buildLoadingIndicatorContent(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: IconSizes.sm - 4,
          height: IconSizes.sm - 4,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.onSurfaceVariant),
          ),
        ),
        HSpace.sm,
        Text(
          "Loading additional modules...",
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _YearlyModuleSection extends StatefulWidget {
  final int year;
  final int selectedYear;
  final bool showHeader;
  final List<ModuleModel> modules;
  final List<ModuleModel> selectedModules;
  final Function(ModuleModel) onModuleToggled;

  const _YearlyModuleSection({
    super.key, // Ensure key is passed
    required this.year,
    required this.selectedYear,
    required this.modules,
    required this.selectedModules,
    required this.onModuleToggled,
    required this.showHeader,
  });

  @override
  State<_YearlyModuleSection> createState() => _YearlyModuleSectionState();
}

class _YearlyModuleSectionState extends State<_YearlyModuleSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.15), // Slide up from bottom slightly
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isCurrentYear = widget.year == widget.selectedYear;
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showHeader)
              Container(
                width: double.infinity, // Ensure header spans width
                color: theme.colorScheme.tertiaryContainer.withOpacity(0.7),
                padding: EdgeInsets.symmetric(
                    horizontal: Insets.med, vertical: Insets.xs + 2),
                child: Text(
                  '${isCurrentYear ? "Current" : "${widget.year}${StringUtils.getOrdinal(widget.year)}"} Year Modules',
                  style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w600),
                ),
              ),
            if (widget.modules
                .isEmpty) // Handle case where modules for a year might be empty after filtering
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Insets.med, horizontal: Insets.med),
                child: Text(
                  "No modules match your search for this year.",
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.modules.length,
                itemBuilder: (ctx, index) {
                  final module = widget.modules[index];
                  final bool isSelected =
                      widget.selectedModules.any((m) => m.id == module.id);
                  return ModuleWidget(
                    module,
                    isSelected: isSelected,
                    onPress: widget.onModuleToggled,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ModuleWidget extends StatelessWidget {
  final ModuleModel module;
  final bool isSelected;
  final Function(ModuleModel) onPress;
  const ModuleWidget(this.module,
      {required this.isSelected, required this.onPress, super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CheckboxListTile(
      title: Text(module.name ?? "Unnamed Module",
          style: theme.textTheme.bodyMedium),
      value: isSelected,
      onChanged: (_) => onPress(module),
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding:
          EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs / 2),
      activeColor: theme.colorScheme.primary,
    );
  }
}
