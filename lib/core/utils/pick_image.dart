import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    return xFile;
  } catch (e) {
    return null;
  }
}
