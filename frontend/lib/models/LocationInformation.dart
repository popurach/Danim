import 'dart:typed_data';

class LocationInformation {
  final String country;
  final String city;
  final String district;
  final String suburb;
  late final Uint8List? flag;

  LocationInformation({
      required this.country,
      required this.city,
      required this.district,
      required this.suburb,
      this.flag
  });
}