import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/song_model.dart';
import 'screens/song_detail_screen.dart';
import 'services/theme_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Music Explorer',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[900],
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            themeMode: themeService.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sample songs list from your JSON data
  List<Song> get sampleSongs => [
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
  ];

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkMode = themeService.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Explorer'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        actions: [
          // Theme toggle button in home screen
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              themeService.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sampleSongs.length,
        itemBuilder: (context, index) {
          final song = sampleSongs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            color: isDarkMode ? Colors.grey[800] : Colors.white,
            elevation: 1,
            child: ListTile(
              leading: song.artworkUrl60.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        song.artworkUrl60,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.music_note,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.music_note,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
              title: Text(
                song.trackName,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                song.artistName,
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SongDetailScreen(song: song, allSongs: sampleSongs),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
