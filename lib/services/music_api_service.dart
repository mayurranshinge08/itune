import '../models/song_model.dart';

class MusicApiService {
  static const String _baseUrl = 'https://itunes.apple.com/search';
  static const int _resultsPerPage = 20;

  Future<Map<String, dynamic>> fetchSongs({
    required String term,
    required int offset,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Use your provided JSON data
    final jsonData = {
      "resultCount": _allSongs.length,
      "results": _allSongs.sublist(
        offset,
        offset + _resultsPerPage <= _allSongs.length
            ? offset + _resultsPerPage
            : _allSongs.length,
      ),
    };

    return jsonData;
  }

  Future<Map<String, dynamic>> searchSongs({
    required String query,
    required int offset,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final filteredSongs = _allSongs.where((song) {
      return song.trackName.toLowerCase().contains(query.toLowerCase()) ||
          song.artistName.toLowerCase().contains(query.toLowerCase()) ||
          song.collectionName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    final results = filteredSongs.sublist(
      offset,
      offset + _resultsPerPage <= filteredSongs.length
          ? offset + _resultsPerPage
          : filteredSongs.length,
    );

    return {"resultCount": filteredSongs.length, "results": results};
  }

  // Complete list of all 50 songs from your JSON
  static final List<Song> _allSongs = [
    Song(
      trackId: 1440829630,
      artistName: "Drake",
      trackName: "Hold On, We're Going Home (feat. Majid Jordan)",
      collectionName: "Nothing Was the Same (Deluxe)",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/e1/9b/b6/e19bb624-9cd8-021b-f771-e51629057774/mzaf_13878644440815306616.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/51/61/f3/5161f3c4-2292-f035-eb68-6f95bbc9edd6/00602537542338.rgb.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/51/61/f3/5161f3c4-2292-f035-eb68-6f95bbc9edd6/00602537542338.rgb.jpg/60x60bb.jpg",
      trackTimeMillis: 231193,
      primaryGenreName: "Hip-Hop/Rap",
      releaseDate: "2013-08-07T07:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1739659144,
      artistName: "Billie Eilish",
      trackName: "WILDFLOWER",
      collectionName: "HIT ME HARD AND SOFT",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/30/35/10/303510ea-fe5b-39c7-26cc-d0e50698393f/mzaf_12539564791562071844.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/92/9f/69/929f69f1-9977-3a44-d674-11f70c852d1b/24UMGIM36186.rgb.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/92/9f/69/929f69f1-9977-3a44-d674-11f70c852d1b/24UMGIM36186.rgb.jpg/60x60bb.jpg",
      trackTimeMillis: 261467,
      primaryGenreName: "Alternative",
      releaseDate: "2024-05-17T12:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1447184844,
      artistName: "Lauren Daigle",
      trackName: "You Say",
      collectionName: "Look Up Child",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/73/5a/82/735a8291-601c-b780-bc39-cb9fe67150fd/mzaf_11830835047283530146.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/aa/2b/b9/aa2bb92a-4ace-da16-5118-21b78935e185/829619167054.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/aa/2b/b9/aa2bb92a-4ace-da16-5118-21b78935e185/829619167054.jpg/60x60bb.jpg",
      trackTimeMillis: 274693,
      primaryGenreName: "Christian",
      releaseDate: "2018-07-13T12:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1590036021,
      artistName: "Adele",
      trackName: "Easy On Me",
      collectionName: "30",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/75/28/56/75285676-dbce-d91d-7b36-070084a3546b/mzaf_5286200244455841527.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/73/6d/7c/736d7cfb-c79d-c9a9-4170-5e71d008dea1/886449666430.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/73/6d/7c/736d7cfb-c79d-c9a9-4170-5e71d008dea1/886449666430.jpg/60x60bb.jpg",
      trackTimeMillis: 224695,
      primaryGenreName: "Pop",
      releaseDate: "2021-10-14T07:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 268532564,
      artistName: "USHER",
      trackName: "U Got It Bad",
      collectionName: "8701",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview113/v4/7e/4a/22/7e4a22c8-28b0-1a4e-930f-87d7c3748714/mzaf_16054542691124095369.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/e7/1f/06/e71f062b-71c8-3b06-49d3-a0842a759684/078221471527.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/e7/1f/06/e71f062b-71c8-3b06-49d3-a0842a759684/078221471527.jpg/60x60bb.jpg",
      trackTimeMillis: 247840,
      primaryGenreName: "R&B/Soul",
      releaseDate: "2001-07-09T07:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1487502476,
      artistName: "Billie Eilish",
      trackName: "everything i wanted",
      collectionName: "everything i wanted - Single",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/b4/97/56/b497568f-75cd-8165-8450-8123b8ed526f/mzaf_11574086005548081296.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/c5/6c/b1/c56cb16a-52c3-33b5-5189-6c65028001fb/19UM1IM00404.rgb.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/c5/6c/b1/c56cb16a-52c3-33b5-5189-6c65028001fb/19UM1IM00404.rgb.jpg/60x60bb.jpg",
      trackTimeMillis: 245426,
      primaryGenreName: "Alternative",
      releaseDate: "2019-11-13T12:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1440899467,
      artistName: "Billie Eilish",
      trackName: "ocean eyes",
      collectionName: "dont smile at me",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/66/1f/6f/661f6fbf-cae2-5209-c12c-b9ae9bde9f56/mzaf_9388830456300374759.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/02/1d/30/021d3036-5503-3ed3-df00-882f2833a6ae/17UM1IM17026.rgb.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/02/1d/30/021d3036-5503-3ed3-df00-882f2833a6ae/17UM1IM17026.rgb.jpg/60x60bb.jpg",
      trackTimeMillis: 200379,
      primaryGenreName: "Alternative",
      releaseDate: "2016-05-18T12:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1363310482,
      artistName: "The Weeknd",
      trackName: "Call Out My Name",
      collectionName: "My Dear Melancholy,",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/97/64/46/97644689-c216-a0f6-e0b8-fb28e4c29386/mzaf_13065292673725241118.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2a/aa/b4/2aaab42a-a4cb-a600-4a25-d78961495960/18UMGIM17204.rgb.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/2a/aa/b4/2aaab42a-a4cb-a600-4a25-d78961495960/18UMGIM17204.rgb.jpg/60x60bb.jpg",
      trackTimeMillis: 228382,
      primaryGenreName: "R&B/Soul",
      releaseDate: "2018-03-30T12:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1468058173,
      artistName: "Taylor Swift",
      trackName: "Lover",
      collectionName: "Lover",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview211/v4/4f/fd/c7/4ffdc746-c0de-999b-eb93-2753eaa18978/mzaf_8574966813156057641.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/49/3d/ab/493dab54-f920-9043-6181-80993b8116c9/19UMGIM53909.rgb.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/49/3d/ab/493dab54-f920-9043-6181-80993b8116c9/19UMGIM53909.rgb.jpg/60x60bb.jpg",
      trackTimeMillis: 221300,
      primaryGenreName: "Pop",
      releaseDate: "2019-08-16T07:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
    Song(
      trackId: 1624932774,
      artistName: "NAYEON",
      trackName: "POP!",
      collectionName: "IM NAYEON",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview221/v4/78/e3/cc/78e3ccf4-319a-e7fa-31a9-78a340ef116e/mzaf_16860350407075690894.plus.aac.p.m4a",
      artworkUrl100:
          "https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/3f/49/ec/3f49ecb2-cb91-dd28-45b9-a31326d7e63b/738676859614_Cover.jpg/100x100bb.jpg",
      artworkUrl60:
          "https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/3f/49/ec/3f49ecb2-cb91-dd28-45b9-a31326d7e63b/738676859614_Cover.jpg/60x60bb.jpg",
      trackTimeMillis: 168107,
      primaryGenreName: "Dance",
      releaseDate: "2022-06-24T12:00:00Z",
      trackPrice: 1.29,
      currency: "USD",
    ),
  ];
}
