class ZoneModel {
  final int id;
  final String name;
  final String slug;
  final GeoLocation geoLocation;

  ZoneModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.geoLocation,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      geoLocation: GeoLocation.fromJson(json['geo_location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'geo_location': geoLocation.toJson(),
    };
  }
}

class GeoLocation {
  final double? lat;
  final double? long;

  GeoLocation({
    this.lat,
    this.long,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
      long: json['long'] != null ? (json['long'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}
