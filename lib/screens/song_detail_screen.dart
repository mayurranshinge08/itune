import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song_model.dart';
import '../services/favorites_service.dart';
import '../services/theme_service.dart';

class SongDetailScreen extends StatefulWidget {
  final Song song;
  final List<Song> allSongs;

  const SongDetailScreen({Key? key, required this.song, required this.allSongs})
    : super(key: key);

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isFavorite = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  int _currentSongIndex = 0;

  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _currentSongIndex = widget.allSongs.indexWhere(
      (song) => song.trackId == widget.song.trackId,
    );
    _checkIfFavorite();
    _setupAudioPlayer();
  }

  Song get _currentSong => widget.allSongs[_currentSongIndex];

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
      // Auto-play next song when current finishes
      _playNextSong();
    });
  }

  void _checkIfFavorite() async {
    final isFav = await _favoritesService.isFavorite(_currentSong.trackId);
    setState(() {
      _isFavorite = isFav;
    });
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _playCurrentSong();
    }
  }

  Future<void> _playCurrentSong() async {
    if (_currentSong.previewUrl.isNotEmpty) {
      await _audioPlayer.play(UrlSource(_currentSong.previewUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No preview available for this song')),
      );
    }
  }

  void _playNextSong() {
    if (_currentSongIndex < widget.allSongs.length - 1) {
      setState(() {
        _currentSongIndex++;
        _position = Duration.zero;
        _isPlaying = false;
      });
      _checkIfFavorite();
      // Auto-play the next song
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playCurrentSong();
      });
    } else {
      // If it's the last song, just reset
      setState(() {
        _position = Duration.zero;
        _isPlaying = false;
      });
    }
  }

  void _playPreviousSong() {
    if (_currentSongIndex > 0) {
      setState(() {
        _currentSongIndex--;
        _position = Duration.zero;
        _isPlaying = false;
      });
      _checkIfFavorite();
      // Auto-play the previous song
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _playCurrentSong();
      });
    }
  }

  void _toggleFavorite() async {
    if (_isFavorite) {
      await _favoritesService.removeFavorite(_currentSong.trackId);
    } else {
      await _favoritesService.addFavorite(_currentSong);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to Favorites' : 'Removed from Favorites',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDarkMode = themeService.isDarkMode;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            snap: false,
            stretch: true,
            backgroundColor: isDarkMode
                ? Colors.grey[900]
                : Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Song Details',
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black.withOpacity(0.75),
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
            actions: [
              // Theme Toggle Button
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  themeService.toggleTheme();
                },
              ),
              // Song counter
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    '${_currentSongIndex + 1}/${widget.allSongs.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _currentSong.artworkUrl100.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          _currentSong.artworkUrl100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[300],
                              child: Icon(
                                Icons.music_note,
                                size: 100,
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey,
                              ),
                            );
                          },
                        ),
                        // Gradient overlay for better text readability
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      child: Icon(
                        Icons.music_note,
                        size: 100,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Song Title
                  Text(
                    _currentSong.trackName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Artist Name
                  Text(
                    _currentSong.artistName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Album Info
                  _buildInfoRow(
                    'Album',
                    _currentSong.collectionName,
                    isDarkMode,
                  ),
                  const SizedBox(height: 8),

                  // Genre
                  _buildInfoRow(
                    'Genre',
                    _currentSong.primaryGenreName,
                    isDarkMode,
                  ),
                  const SizedBox(height: 8),

                  // Duration
                  _buildInfoRow('Duration', _currentSong.duration, isDarkMode),
                  const SizedBox(height: 8),

                  // Release Year
                  _buildInfoRow(
                    'Released',
                    _currentSong.formattedReleaseDate,
                    isDarkMode,
                  ),
                  const SizedBox(height: 8),

                  // Price
                  _buildInfoRow(
                    'Price',
                    '${_currentSong.trackPrice} ${_currentSong.currency}',
                    isDarkMode,
                  ),
                  const SizedBox(height: 24),

                  // Audio Player Section
                  _buildAudioPlayer(isDarkMode),
                  const SizedBox(height: 24),

                  // Action Buttons
                  _buildActionButtons(isDarkMode),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAudioPlayer(bool isDarkMode) {
    return Column(
      children: [
        // Progress Bar
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: isDarkMode
                ? Colors.grey[600]
                : Colors.grey[300],
            thumbColor: Colors.blue,
            overlayColor: Colors.blue.withAlpha(32),
            valueIndicatorColor: Colors.blue,
          ),
          child: Slider(
            value: _position.inSeconds.toDouble(),
            min: 0,
            max: _duration.inSeconds.toDouble(),
            onChanged: (value) async {
              await _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
        ),

        // Time Indicators
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(_position),
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              Text(
                _formatDuration(_duration),
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Player Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Button
            IconButton(
              icon: const Icon(Icons.skip_previous),
              iconSize: 40,
              onPressed: _currentSongIndex > 0 ? _playPreviousSong : null,
              color: _currentSongIndex > 0 ? Colors.blue : Colors.grey,
            ),

            const SizedBox(width: 20),

            // Play/Pause Button
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: _togglePlayPause,
              ),
            ),

            const SizedBox(width: 20),

            // Next Button
            IconButton(
              icon: const Icon(Icons.skip_next),
              iconSize: 40,
              onPressed: _currentSongIndex < widget.allSongs.length - 1
                  ? _playNextSong
                  : null,
              color: _currentSongIndex < widget.allSongs.length - 1
                  ? Colors.blue
                  : Colors.grey,
            ),
          ],
        ),

        // Next Song Preview
        if (_currentSongIndex < widget.allSongs.length - 1) ...[
          const SizedBox(height: 24),
          _buildNextSongPreview(isDarkMode),
        ],
      ],
    );
  }

  Widget _buildNextSongPreview(bool isDarkMode) {
    final nextSong = widget.allSongs[_currentSongIndex + 1];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          // Next Icon
          const Icon(Icons.skip_next, color: Colors.blue),
          const SizedBox(width: 12),

          // Next Song Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next:',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nextSong.trackName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  nextSong.artistName,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Play Next Button
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.blue),
            onPressed: _playNextSong,
            tooltip: 'Play next song',
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            label: Text(_isFavorite ? 'Remove Favorite' : 'Add to Favorites'),
            onPressed: _toggleFavorite,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: _isFavorite
                  ? Colors.red
                  : (isDarkMode ? Colors.grey[800] : null),
              foregroundColor: _isFavorite
                  ? Colors.white
                  : (isDarkMode ? Colors.white : null),
            ),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // Share functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Share feature coming soon!'),
                backgroundColor: isDarkMode ? Colors.grey[800] : null,
              ),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            foregroundColor: isDarkMode ? Colors.white : Colors.black,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
