import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImageFromCamera() async {
  /// because it has issue with permission handler when running on ios verision
  // var permission = await Permission.camera.request();
  // if (permission.isDenied) {
  //   permission = await Permission.camera.request();
  //   if (permission.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }
  // if (permission.isGranted || permission.isLimited) {
  //   return await ImagePicker().pickImage(source: ImageSource.camera).then(
  //     (profileImage) {
  //       if (profileImage != null) {
  //         return profileImage.path;
  //       }
  //       return null;
  //     },
  //   );
  // }
  // return null;

  return await ImagePicker().pickImage(source: ImageSource.camera).then(
    (profileImage) {
      if (profileImage != null) {
        return profileImage.path;
      }
      return null;
    },
  );
}

Future<String?> pickImageFromGallery() async {
  // var permission = await Permission.photos.request();
  // if (permission.isDenied) {
  //   permission = await Permission.photos.request();
  //   if (permission.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  // log(permission.toString());
  // if (permission.isGranted || permission.isLimited) {
  //   return await ImagePicker().pickImage(source: ImageSource.gallery).then(
  //     (profileImage) {
  //       if (profileImage != null) {
  //         return profileImage.path;
  //       }
  //       return null;
  //     },
  //   );
  // }
  // return null;

  return await ImagePicker().pickImage(source: ImageSource.gallery).then(
    (profileImage) {
      if (profileImage != null) {
        return profileImage.path;
      }
      return null;
    },
  );
}

Future<String?> pickFile() async {
  // step 1: check permission
  // Permission.storage.request();
  // var permission = await Permission.manageExternalStorage.request();
  // log(permission.toString());
  // if (permission.isDenied) {
  //   permission = await Permission.manageExternalStorage.request();
  //   if (permission.isPermanentlyDenied) {
  //     await openAppSettings();
  //   }
  // }

  // log(permission.toString());
  // if (permission.isGranted || permission.isLimited) {
  //   // step 2: pick file
  //   return await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']).then(
  //     (pickedFile) {
  //       if (pickedFile != null) {
  //         return pickedFile.files.first.path!;
  //       }
  //       return null;
  //     },
  //   );
  // }
  // return null;

  return await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']).then(
    (pickedFile) {
      if (pickedFile != null) {
        return pickedFile.files.first.path!;
      }
      return null;
    },
  );
}
