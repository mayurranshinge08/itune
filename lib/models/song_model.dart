class Song {
  final int trackId;
  final String artistName;
  final String trackName;
  final String collectionName;
  final String previewUrl;
  final String artworkUrl100;
  final String artworkUrl60;
  final int trackTimeMillis;
  final String primaryGenreName;
  final String releaseDate;
  final double trackPrice;
  final String currency;

  Song({
    required this.trackId,
    required this.artistName,
    required this.trackName,
    required this.collectionName,
    required this.previewUrl,
    required this.artworkUrl100,
    required this.artworkUrl60,
    required this.trackTimeMillis,
    required this.primaryGenreName,
    required this.releaseDate,
    required this.trackPrice,
    required this.currency,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      trackId: json['trackId'],
      artistName: json['artistName'] ?? 'Unknown Artist',
      trackName: json['trackName'] ?? 'Unknown Track',
      collectionName: json['collectionName'] ?? 'Unknown Album',
      previewUrl: json['previewUrl'] ?? '',
      artworkUrl100: json['artworkUrl100'] ?? '',
      artworkUrl60: json['artworkUrl60'] ?? '',
      trackTimeMillis: json['trackTimeMillis'] ?? 0,
      primaryGenreName: json['primaryGenreName'] ?? 'Unknown Genre',
      releaseDate: json['releaseDate'] ?? '',
      trackPrice: (json['trackPrice'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'USD',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'artistName': artistName,
      'trackName': trackName,
      'collectionName': collectionName,
      'previewUrl': previewUrl,
      'artworkUrl100': artworkUrl100,
      'artworkUrl60': artworkUrl60,
      'trackTimeMillis': trackTimeMillis,
      'primaryGenreName': primaryGenreName,
      'releaseDate': releaseDate,
      'trackPrice': trackPrice,
      'currency': currency,
    };
  }

  String get duration {
    if (trackTimeMillis == 0) return 'Unknown';
    final duration = Duration(milliseconds: trackTimeMillis);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedReleaseDate {
    if (releaseDate.isEmpty) return 'Unknown';
    try {
      final date = DateTime.parse(releaseDate);
      return '${date.year}';
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song &&
          runtimeType == other.runtimeType &&
          trackId == other.trackId;

  @override
  int get hashCode => trackId.hashCode;
}
