import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/styled_dropdown.dart';
import '../../widgets/styled_dropdown_textfield.dart';
import '../common/entities/entities.dart';
import '../../styles.dart';
import '../../widgets/labeled_text_input.dart';

//to pass module on press
typedef ModuleCallback = void Function(Module module);

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
  // final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPress(module),
        child: Container(
            height: 42,
            padding:
                EdgeInsets.symmetric(horizontal: Insets.med).copyWith(left: 0),
            child: Row(
              children: [
                _buildIcon(context, module),
                HSpace.med,
                Text(module.name ?? ""),
              ],
            )),
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
  });
  final List<Module> modules;
  final List<Module> selectedModules;
  final ModuleCallback onModulePress;
  final List<AppListItem<dynamic>> listItems;
  final String label;
  final dynamic value;
  final ValueChanged<dynamic>? onChange;
  final FormFieldValidator<dynamic>? fieldValidator;
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
              child: LabeledTextInput(
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
                )),
          ],
        ),
        VSpace(Insets.med + 3),
        _buildChips(controller.text.isEmpty ? widget.modules : _suggestions),
      ],
    );
  }

  Widget _buildChips(List<Module> modules) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => ModuleWidget(
                modules[index],
                onPress: widget.onModulePress,
                isSelected: widget.selectedModules.contains(modules[index]),
              ),
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                height: 1,
              ),
          itemCount: modules.length),
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
