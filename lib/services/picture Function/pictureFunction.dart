import 'package:image_picker/image_picker.dart';


final ImagePicker picker = ImagePicker();
XFile? image;

Future<void> pickImageFromGallery() async {
  image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    print('Selected image path: ${image?.path}');
  } else {
    print('No image selected.');
  }
}


