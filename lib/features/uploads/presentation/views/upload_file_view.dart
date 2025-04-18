import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/commands/files/pick_file_command.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/buttons/styled_buttons.dart';
import 'package:its_shared/widgets/styled_load_spinner.dart';

import '../../../../constants/responsive.dart';
import '../../../../core/core.dart';
import '../../../../presentation/account/shared/shared.dart';
import '../../../upload_progress/presentation/bloc/upload_progress_bloc.dart';
import '../bloc/uploads_bloc.dart';
import '../components/dl_table_header.dart';
import '../components/dl_table_row.dart';
import '../uploads_constants.dart';

class ColumnItem extends StatelessWidget {
  const ColumnItem({
    super.key,
    this.width,
    required this.child,
  });
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return width == null
        ? Expanded(child: child)
        : SizedBox(width: width, child: child);
  }
}

class TableText extends StatelessWidget {
  const TableText(
    this.text, {
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
    );
  }
}

class TableHeaderText extends StatelessWidget {
  const TableHeaderText(
    this.text, {
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyles.body3.copyWith(
          fontSize: FontSizes.s11,
          color: Theme.of(context).colorScheme.tertiary),
    );
  }
}

class UploadFileView extends StatefulWidget {
  const UploadFileView({super.key});

  @override
  State<UploadFileView> createState() => _UploadFileViewState();
}

class _UploadFileViewState extends State<UploadFileView> {
  @override
  void initState() {
    super.initState();
    context.read<UploadsBloc>().add(FetchDocuments());
  }

  @override
  Widget build(BuildContext context) {
    final double minTopBarHeight = kToolbarHeight + Insets.lg + 2;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return BlocConsumer<UploadsBloc, UploadsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is DocumentsInitial ||
            state is DocumentsLoading && state is! DocumentsLoaded) {
          return const Center(child: StyledLoadSpinner());
        }
        return CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverAppBar(
                  minTopBarHeight: minTopBarHeight,
                  maxTopBarHeight: minTopBarHeight,
                  title: "Uploads",
                  trailing: Row(
                    children: [
                      // IconButton.filled(
                      //   onPressed: () {},
                      //   icon: Icon(Ionicons.filter),
                      // ),
                      IconBtn(Ionicons.refresh,
                          padding: EdgeInsets.all(Insets.sm),
                          compact: true, onPressed: () {
                        BlocProvider.of<UploadsBloc>(context)
                            .add(FetchDocuments());
                      }),
                      HSpace.med,
                      PrimaryBtn(
                        label: "Uploads",
                        onPressed: () async {
                          await PickFileCommand()
                              .run(enableCamera: false)
                              .then((pickedFiles) {
                            if (pickedFiles.isNotEmpty) {
                              BlocProvider.of<UploadProgressBloc>(context)
                                  .add(UploadingFiles(pickedFiles));
                            }
                          });
                        },
                        // icon: Ionicons.cloud_upload_outline,
                      ),
                    ],
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context)
                        ? Insets.lg + Insets.sm
                        : Insets.xl + Insets.sm),
                child: Row(
                  children: [
                    const ViewTitle(
                      title: "Uploads",
                    ),
                    const Spacer(),
                    HSpace.lg
                  ],
                ),
              ),
            ),
            if (state is DocumentsError)
              SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${state.message}')))
            else if (state is DocumentsLoaded) ...[
              if (!Responsive.isMobile(context))
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    child: const PreferredSize(
                      preferredSize: Size.fromHeight(46),
                      child: SizedBox(
                        height: 46,
                        child: Row(
                          children: [
                            ColumnItem(
                              child: TableHeaderText("File Name"),
                            ),
                            ColumnItem(
                                width: TableColumnSizes.fileSize,
                                child: TableHeaderText("Size")),
                            ColumnItem(
                                width: TableColumnSizes.fileUploaded,
                                child: TableHeaderText("Rating")),
                            ColumnItem(
                                width: TableColumnSizes.fileStatus,
                                child: TableHeaderText("Status")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (Responsive.isMobile(context))
                SliverToBoxAdapter(child: VSpace.lg),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (BuildContext context, int index) {
              //       return ListTile(
              //         title: Text('Item #$index'),
              //       );
              //     },
              //     childCount: 15,
              //   ),
              // ),
              SliverList.separated(
                  itemBuilder: (context, index) {
                    final document = state.documents[index];
                    return Responsive.isMobile(context)
                        ? DLResourceListItem(document)
                        : DLTableRow(document);
                  },
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: Insets.xl),
                        child: const Divider(
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                  itemCount: state.documents.length)
            ],
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 500,
              ),
            )
          ],
        );
      },
    );
  }
}
