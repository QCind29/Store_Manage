import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// Get File image from Uint8List
Future<File> getImageFile(Uint8List imageData) async {
  File imageFile;

  if(imageData != Uint8List(0) && imageData != null && imageData.isNotEmpty)
  {
    // Generate a unique file name using current timestamp
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName =
          'image_$timestamp.png'; // You can change the file extension as needed

      // Get the app's temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      // Create a new File in the app's temporary directory
      imageFile = File('$tempPath/$fileName');

      // Write the image data to the file
      await imageFile.writeAsBytes(imageData);
    } on Exception catch (e) {
      print(e);
      return Future.error('Failed to create image file');
    }
  } else{
    print(" Image is empty");
    imageFile = File('');
  }

  return imageFile;


}
// get Unit8List from Image file
Future<Uint8List> getImageBytes(File? imagePath) async {
  if (imagePath != null) {
    try {
      // File imageFile = File(imagePath);
      if (await imagePath.exists()) {
        List<int> imageBytes = await imagePath.readAsBytes();
        return Uint8List.fromList(imageBytes);
      } else {
        print("Error: Image not found");
        return Uint8List(0); // Return an empty Uint8List if image not found
      }
    } catch (error) {
      print("Error: $error");
      return Uint8List(0); // Return an empty Uint8List on error
    }
  } else {
    List<int> emptyList =[];
    print(" Line 60 :   Error: Image path is null");
    return Uint8List(0); // Return an empty Uint8List if image path is null
  }
  }
menhgia(number) {
  final formatCurrency = NumberFormat("#,##0");
  return formatCurrency.format(number);
}

