import 'package:doculode/core/constants/responsive.dart';
import 'package:doculode/widgets/buttons/buttons.dart';
import 'package:doculode/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:doculode/core/common/settings/settings.dart';
import 'package:doculode/core/core.dart';
import 'package:doculode/presentation/account/shared/view_title.dart';
import 'package:doculode/features/settings/settings.dart';
import 'package:doculode/config/styles.dart';
import 'profile_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _tabs = const ['Profile', 'Features', 'Subscriptions', 'Integrations'];
  final _tabViews = const [
    ProfileView(),
    Center(child: Text('Feature coming soon')),
    Center(child: Text('Subscriptions coming soon')),
    Center(child: Text('Integrations coming soon')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    // context.read<SettingsBloc>().add(SettingsInitialize());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (_, state) {
          if (state.status == SettingsStatus.deleted) context.go('/login');
        },
        builder: (context, state) {
          return CustomScrollView(slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverAppBar(
                title: "Settings",
                trailing: PrimaryBtn(
                  label: "Uploads",
                  onPressed: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context)
                      ? Insets.lg + Insets.sm
                      : Insets.xl + Insets.sm - 1,
                ),
                child: Row(
                  children: [
                    const ViewTitle(title: "Settings"),
                    const Spacer(),
                    HSpace.lg,
                  ],
                ),
              ),
            ),
            // if (state.status == SettingsStatus.failure)
            //   SliverToBoxAdapter(
            //     child: Center(child: Text('Error: ${state.errorMsg}')),
            //   )
            if (state.status == SettingsStatus.initial)
              SliverToBoxAdapter(
                child: SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 132,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            height: 25, width: 25, child: StyledLoadSpinner()),
                        HSpace.sm,
                        UiText(
                          text: "Loading...",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (state.status != SettingsStatus.initial)
              // else
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context)
                        ? Insets.lg + Insets.sm
                        : Insets.xl + Insets.sm,
                  ),
                  child: const ProfileView(),
                ),
              )

            // SliverToBoxAdapter(
            //   child: Container(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: Responsive.isMobile(context)
            //         ? Insets.lg + Insets.sm
            //         : Insets.xl + Insets.sm,
            //   ),
            //     constraints: BoxConstraints(
            //       minHeight: 0,
            //       maxHeight: MediaQuery.of(context).size.height - kToolbarHeight + Insets.lg + 2, // Adjust as needed
            //     ),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.symmetric(
            //               vertical: Insets.med),
            //           child: Row(
            //             children: [
            //               for (var i = 0; i < _tabs.length; i++) ...[
            //                 _SelectableBtn(
            //                   text: _tabs[i],
            //                   selected: _tabController.index == i,
            //                   onPressed: () => _tabController.animateTo(i),
            //                 ),
            //                 if (i < _tabs.length - 1) HSpace.sm,
            //               ],
            //             ],
            //           ),
            //         ),
            //         Expanded(
            //           child: TabBarView(
            //             controller: _tabController,
            //             children: _tabViews,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            ,
            //add space at the bottom of the contect to maintaine the look
            SliverToBoxAdapter(
              child: VSpace(Insets.xl + Insets.sm),
            ),
          ]);
        },
      ),
    );
  }
}
