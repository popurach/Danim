import 'package:dio/dio.dart';

class PostForUpload {
  final List<MultipartFile>? imageSources;
  final MultipartFile? audioSource;
  final Object? locationInfo;
  final MultipartFile? flag;

  PostForUpload({
    this.audioSource,
    this.imageSources,
    this.flag,
    this.locationInfo
  });
}