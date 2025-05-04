import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../domain/usecases/get_uploads.dart';

part 'uploads_event.dart';
part 'uploads_state.dart';

class UploadsBloc extends Bloc<UploadsEvent, UploadsState> {
  final FirebaseService _repository = serviceLocator<FirebaseService>();
  final GetUploads _getUploads;
  bool _hasMore = true;
  late List<RemoteDocModel> _files;
  StreamSubscription<RemoteDocModel>? _editSubscription;
  StreamSubscription<int>? _uploadsSubscription;
  UploadsBloc({required GetUploads getUploads})
      : _getUploads = getUploads,
        super(DocumentsInitial()) {
    // on<UploadsEvent>((event, emit) => emit(DocumentsLoading()));
    on<FetchDocuments>(_onFetchDocuments);
    on<UpdateDocuments>(_onUpdateDocuments);

    _editSubscription =
        _repository.uploadEditStream.asBroadcastStream().listen((updatedFile) {
      add(UpdateDocuments([updatedFile]));
    });

    _uploadsSubscription = _repository.uploadsStream.listen((file) async {
      // List<RemoteDocModel> files = [];
      // for (var element in fileMap) {
      //   files.add(RemoteDocModel.fromJson(element));
      // }
      add(FetchDocuments());
    });
  }
  @override
  Future<void> close() {
    _editSubscription?.cancel();
    _uploadsSubscription?.cancel();
    return super.close();
  }

  void _onFetchDocuments(FetchDocuments event, emit) async {
    if (state is DocumentsLoading) return;
    emit(DocumentsLoading());
    final data = await _getUploads.call(NoParams());

    data.fold((onError) => emit(DocumentsError(onError.message)), (onSuccess) {
      for (var i = 0; i < onSuccess.docs!.length; i++) {
        log(onSuccess.docs![i].uid);
      }
      _files = onSuccess.docs ?? [];
      _hasMore = onSuccess.hasMore;
      emit(DocumentsLoaded(_files, _hasMore));
    });
  }

  void _onUpdateDocuments(UpdateDocuments event, emit) async {
    // if (state is DocumentsLoading) return;
    // emit(DocumentsLoading());
    // List<RemoteDocModel> data = event.files;
    // Create a map from the original list for easier lookup by id
    // Map<String?, RemoteDocModel> originalMap = {
    //   for (var model in _files) model.id: model
    // };

    // // Iterate through the new list to either replace or add new models
    // for (var newModel in event.files) {
    //   if (originalMap.containsKey(newModel.id)) {
    //     // Replace the existing model with the modified
    //     int index = _files.indexWhere((model) => model.id == newModel.id);
    //     _files[index] = _files[index].copyWith(
    //       access: newModel.access,
    //       name: newModel.name,
    //       modules: newModel.modules,
    //       type: newModel.type,
    //     );
    //   } else {
    //     // If the model doesn't exist, add it to the list
    //     _files.add(newModel);
    //   }
    // }
    if (event.files.isEmpty) return;
    RemoteDocModel updatedDocument = event.files.first;

    // Find the index of the existing document to update
    int index = _files.indexWhere((file) => file.id == updatedDocument.id);
    if (index != -1) {
      // Update the existing document
      _files[index] = _files[index].copyWith(
        access: updatedDocument.access,
        name: updatedDocument.name,
        modules: updatedDocument.modules,
        type: updatedDocument.type,
      );
    } else {
      // If the document is new, add it to the list
      _files.addAll(event.files);
    }
    emit(DocumentsLoaded(_files, _hasMore));
  }
}
