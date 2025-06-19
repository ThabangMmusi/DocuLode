import 'package:equatable/equatable.dart';

class AppListItem<T> extends Equatable {
  final String title;
  final T value;
  const AppListItem(this.title, {required this.value});
  @override
  List<Object?> get props => [title, value];
}
