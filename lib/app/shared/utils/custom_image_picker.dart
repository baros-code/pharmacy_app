import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  final ImagePicker _picker = ImagePicker();

  Future<Result<String, Failure>> pickImage() async {
    try {
      final file = await _picker.pickImage(source: ImageSource.gallery);
      return Result.success(value: file?.path);
    } catch (e) {
      return Result.failure(Failure(e.toString()));
    }
  }

  Future<Result<List<String>, Failure>> pickMultipleImages() async {
    try {
      final files = await _picker.pickMultiImage();

      // Extract paths from XFile objects
      final imagePaths = files.map((file) => file.path).toList();

      return Result.success(value: imagePaths);
    } catch (e) {
      return Result.failure(Failure(e.toString()));
    }
  }

  Future<Result<String, Failure>> takePhoto() async {
    try {
      final file = await _picker.pickImage(source: ImageSource.camera);
      return Result.success(value: file?.path);
    } catch (e) {
      return Result.failure(Failure(e.toString()));
    }
  }
}

class Result<TValue extends Object, TError extends Failure> {
  const Result.internal({this.value, this.error})
    : assert(
        value == null || error == null,
        'Both value and error cannot be provided!',
      ),
      isSuccessful = error == null;

  factory Result.success({TValue? value}) => Result.internal(value: value);

  factory Result.failure(TError? error) => Result.internal(error: error);

  final bool isSuccessful;
  final TValue? value;
  final TError? error;
}

class Failure {
  const Failure(this.message);

  final String message;
}
