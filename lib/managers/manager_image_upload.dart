abstract class ImageUploadManager{
  void uploadDone({required String done});
  void uploadFail({required String fail});
  void uploadException();
}