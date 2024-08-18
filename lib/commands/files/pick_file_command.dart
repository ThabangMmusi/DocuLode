import 'package:file_selector/file_selector.dart';

import '../../_utils/device_info.dart';
import '../commands.dart';

class PickedFile {
  PickedFile({
    this.path,
    required this.name,
    // required this.extension,
    this.asset,
  });
  String? path;
  String name;

  ///retuns the file extension
  String get ext => name.split(".").last;
  // String? moduleId;
  // String? type;
  XFile? asset;
  // String get nameWithExt => path.split(pattern);
  // String get location => path ?? asset?.identifier ?? "";
}

/// Due to differences in platforms, this Command will return either a list of plain string paths
/// or, when multi-picking images it returns a list of [Asset]s. This is due to implementation details
/// on modern phones, where you may not get a true path to the file, rather you get some sort of promise.
class PickFileCommand extends BaseAppCommand {
  Future<List<PickedFile>> run(
      {bool allowMultiple = false, bool enableCamera = true}) async {
    List<PickedFile> files = [];
    if (DeviceOS.isDesktopOrWeb) {
      const typeGroup1 =
          XTypeGroup(label: 'Image File', extensions: ['jpg', 'jpeg', 'png']);
      const typeGroup2 = XTypeGroup(label: 'Adobe Pdf', extensions: ['pdf']);
      const typeGroup3 =
          XTypeGroup(label: 'Word Document', extensions: ['docx']);
      const typeGroup4 = XTypeGroup(label: 'All', extensions: ['*']);
      const typeGroups = [typeGroup1, typeGroup2, typeGroup3, typeGroup4];
      files = (await openFiles(acceptedTypeGroups: typeGroups))
          .map((file) =>
              PickedFile(path: file.path, asset: file, name: file.name))
          .toList();

      // (await openFile(acceptedTypeGroups: [typeGroup])).path => PickedImage()..path = file.path);
      // await openFiles(acceptedTypeGroups: typeGroups).then((value) {
      //   return value != null
      //       ? PickedFile(
      //           path: value.path,
      //           name: value.name.split(".")[0],
      //           extension: value.name.split(".")[1],
      //           asset: value)
      //       : null;
      // }); //todo loop snd replace any file extension
    } else {
      // if (enableCamera) {
      //   final picker = ImagePicker();
      //   images = [PickedImage()..path = (await picker.pickImage(source: ImageSource.camera))?.path];
      // } else {
      //   int maxImages = 24; // Need to pick some limit
      //   // Get assets
      //   List<Asset> assets = await MultiImagePicker.pickImages(
      //       materialOptions: MaterialOptions(
      //         actionBarColor: "#${appTheme.accent1.value.toRadixString(16).substring(2, 8)}",
      //         actionBarTitle: "Pick Scraps",
      //         statusBarColor: "#${appTheme.accent1.value.toRadixString(16).substring(2, 8)}",
      //         allViewTitle: "All Photos",
      //         useDetailsView: false,
      //         selectCircleStrokeColor: "#000000",
      //       ),
      //       enableCamera: true,
      //       maxImages: allowMultiple ? maxImages : 1);
      //   for (var asset in assets) {
      //     images.add(PickedImage()..asset = asset);
      //   }
      // }
    }
    return files;
  }
}

// class PickFileCommand extends BaseAppCommand {
//   Future<List<PickedFile>> run(
//       {bool allowMultiple = false, bool enableCamera = true}) async {
//     List<PickedFile> files = [];
//     const typeGroup1 =
//         XTypeGroup(label: 'Image File', extensions: ['jpg', 'jpeg', 'png']);
//     const typeGroup2 = XTypeGroup(label: 'Adobe Pdf', extensions: ['pdf']);
//     const typeGroup3 = XTypeGroup(label: 'Word Document', extensions: ['docx']);
//     const typeGroup4 = XTypeGroup(label: 'All', extensions: ['*']);
//     const typeGroups = [typeGroup1, typeGroup2, typeGroup3, typeGroup4];
//     List<PlatformFile>? paths = (await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'pdf', 'doc'],
//     ))
//         ?.files;
//     if (paths != null) {
//       paths
//           .map((file) => PickedFile(path: file.path, name: file.name))
//           .toList();
//     }

//     return files;
//   }
// }
