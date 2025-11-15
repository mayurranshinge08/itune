import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/song_model.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  Future<void> addFavorite(Song song) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    // Check if already exists
    if (!favorites.any((s) => s.trackId == song.trackId)) {
      favorites.add(song);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(int trackId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((song) => song.trackId == trackId);
    await _saveFavorites(favorites);
  }

  Future<bool> isFavorite(int trackId) async {
    final favorites = await getFavorites();
    return favorites.any((song) => song.trackId == trackId);
  }

  Future<List<Song>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);

    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Song.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _saveFavorites(List<Song> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((song) => song.toJson()).toList();
    await prefs.setString(_favoritesKey, json.encode(jsonList));
  }
}
