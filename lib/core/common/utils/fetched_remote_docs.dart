import '../../core.dart';

class FetchedRemoteDocs {
  List<RemoteDocModel>? docs;
  bool hasMore;
  FetchedRemoteDocs({
    this.docs,
    this.hasMore = false,
  });
}
