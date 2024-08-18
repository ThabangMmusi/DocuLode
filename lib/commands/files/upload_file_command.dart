
import '../commands.dart';
import 'pick_file_command.dart';

class UploadFileCommand extends BaseAppCommand {
  Future<bool> run({required List<PickedFile> files}) async {
    // firebase.uploadFile(files);
    // Upload images and get a public Url
    // List<CloudinaryResponse> uploads =
    //     await cloudStorage.multiUpload(images: files);
    // for (final u in uploads) {
    //   log(u.secureUrl);
    // }
    return false;
  }
}
