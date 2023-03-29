import 'dart:typed_data';

class LocationInformation {
  final String country;
  final String city;
  final String district;
  final String suburb;
  late final Uint8List flag;

  LocationInformation(
      this.country,
      this.city,
      this.district,
      this.suburb,
      this.flag
      );
}