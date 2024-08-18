import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';

import '../../domain/usecases/get_uploads.dart';

part 'uploads_event.dart';
part 'uploads_state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  final GetUploads _getUploads;
  bool hasMore = true;

  UploadsBloc({required GetUploads getUploads})
      : _getUploads = getUploads,
        super(DocumentsInitial()) {
    // on<UploadsEvent>((event, emit) => emit(DocumentsLoading()));
    on<FetchDocuments>(_onFetchDocuments);
  }

  void _onFetchDocuments(
      FetchDocuments event, Emitter<UploadsState> emit) async {
    // if (state is DocumentsLoading) return;
    // emit(DocumentsLoading());
    final data = await _getUploads.call(NoParams());

    data.fold((onError) => emit(DocumentsError(onError.message)), (onSuccess) {
      for (var i = 0; i < onSuccess.docs!.length; i++) {
        log(onSuccess.docs![i].uid);
      }
      emit(DocumentsLoaded(
        onSuccess.docs ?? [],
        onSuccess.hasMore,
      ));
    });
  }
}
