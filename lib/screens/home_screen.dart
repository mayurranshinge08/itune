import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song_model.dart';
import '../services/theme_service.dart';
import 'song_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Song> _allSongs = [];
  List<Song> _displayedSongs = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  void _loadSongs() {
    // Directly create song objects - no API calls
    setState(() {
      _allSongs = [
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
      ];
      _displayedSongs = _allSongs;
    });
  }

  void _searchSongs(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _displayedSongs = _allSongs;
      } else {
        _displayedSongs = _allSongs.where((song) {
          return song.trackName.toLowerCase().contains(query.toLowerCase()) ||
              song.artistName.toLowerCase().contains(query.toLowerCase()) ||
              song.collectionName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _displayedSongs = _allSongs;
    });
  }

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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search songs, artists, albums...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
              ),
              onChanged: _searchSongs,
            ),
          ),

          // Results Count
          if (_searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                '${_displayedSongs.length} results for "$_searchQuery"',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),

          // Songs List
          Expanded(child: _buildSongsList(isDarkMode)),
        ],
      ),
    );
  }

  Widget _buildSongsList(bool isDarkMode) {
    if (_displayedSongs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note,
              size: 64,
              color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No songs available'
                  : 'No results for "$_searchQuery"',
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontSize: 16,
              ),
            ),
            if (_searchQuery.isNotEmpty)
              TextButton(
                onPressed: _clearSearch,
                child: const Text('Clear search'),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _displayedSongs.length,
      itemBuilder: (context, index) {
        final song = _displayedSongs[index];
        return _buildSongItem(song, isDarkMode);
      },
    );
  }

  Widget _buildSongItem(Song song, bool isDarkMode) {
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
                    return _buildPlaceholderArtwork(isDarkMode);
                  },
                ),
              )
            : _buildPlaceholderArtwork(isDarkMode),
        title: Text(
          song.trackName,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.artistName,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${song.collectionName} • ${song.duration}',
              style: TextStyle(
                color: isDarkMode ? Colors.grey[500] : Colors.grey[500],
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
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
                  SongDetailScreen(song: song, allSongs: _displayedSongs),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholderArtwork(bool isDarkMode) {
    return Container(
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
    );
  }
}
