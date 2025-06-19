import 'package:doculode/core/domain/entities/app_list_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/styled_dropdown.dart';
import '../../widgets/styled_dropdown_textfield.dart';
import '../../widgets/styled_load_spinner.dart';
import '../domain/entities/entities.dart';
import 'package:doculode/config/styles.dart';
import '../../widgets/styled_text_input.dart';

// To pass module on press
typedef ModuleCallback = void Function(Module module);

// Private constant for list item height
const double _listItemHeight = 42.0;

class ModuleWidget extends StatelessWidget {
  const ModuleWidget(
    this.module, {
    super.key,
    required this.onPress,
    this.isSelected = false,
  });
  final ModuleCallback onPress;
  final Module module;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPress(module),
        child: Container(
          height: _listItemHeight, // Use the private constant here
          padding:
              EdgeInsets.symmetric(horizontal: Insets.med).copyWith(left: 0),
          child: Row(
            children: [
              _buildIcon(context, module),
              HSpace.med,
              Text(module.name ?? ""),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, Module module) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Color primary = colors.primary;
    Color onSurface = colors.onSurface;

    final currentIcon =
        isSelected ? Ionicons.checkbox : Ionicons.checkbox_outline;

    return Icon(
      currentIcon,
      color: isSelected ? primary : onSurface,
    );
  }
}

class ModuleSelector extends StatefulWidget {
  const ModuleSelector({
    super.key,
    required this.modules,
    required this.onModulePress,
    required this.selectedModules,
    required this.listItems,
    required this.label,
    this.value,
    this.onChange,
    this.fieldValidator,
    this.isLoadingModules = false,
  });
  final List<Module> modules;
  final List<Module> selectedModules;
  final ModuleCallback onModulePress;
  final List<AppListItem<dynamic>> listItems;
  final String label;
  final dynamic value;
  final ValueChanged<dynamic>? onChange;
  final FormFieldValidator<dynamic>? fieldValidator;
  final bool isLoadingModules;
  @override
  State<ModuleSelector> createState() => _ModuleSelectorState();
}

class _ModuleSelectorState extends State<ModuleSelector> {
  List<Module> _suggestions = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StyledTextInput(
                label: "Modules",
                hintText: "Search for module",
                controller: controller,
                onChanged: _onSearchChanged,
              ),
            ),
            HSpace(Insets.med),
            SizedBox(
              width: 180,
              child: StyledDropDown(
                label: widget.label,
                value: widget.value,
                listItems: widget.listItems,
                onChange: widget.onChange,
              ),
            ),
          ],
        ),
        VSpace(Insets.med + 3),
        _buildChips(controller.text.isEmpty ? widget.modules : _suggestions),
      ],
    );
  }

  Widget _buildChips(List<Module> modules) {
    final double listHeight = (modules.length * _listItemHeight) +
        modules.length -
        1; // Calculate height based on item count

    return SizedBox(
      height: listHeight, // Dynamically calculate height based on item count
      child: widget.isLoadingModules
          ? const Center(
              child:
                  SizedBox(width: 25, height: 25, child: StyledLoadSpinner()))
          : ListView.separated(
              itemBuilder: (context, index) => ModuleWidget(
                modules[index],
                onPress: widget.onModulePress,
                isSelected: widget.selectedModules.contains(modules[index]),
              ),
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                height: 1,
              ),
              itemCount: modules.length,
            ),
    );
  }

  void _onSearchChanged(String value) {
    List<Module> tempList = [];
    for (Module item in widget.modules) {
      if (item.name!.toLowerCase().contains(value.toLowerCase())) {
        tempList.add(item);
      }
    }
    setState(() {
      _suggestions = tempList;
    });
  }
}
