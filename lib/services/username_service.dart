import 'package:pbp_django_auth/pbp_django_auth.dart';

class UsernameService {
  UsernameService._();

  static const String _baseApiUrl =
      'https://muhammad-faza44-footballpedia.pbp.cs.ui.ac.id';

  static final Map<int, String> _cache = {};
  static final Map<int, Future<String?>> _inFlight = {};

  static Future<String?> getUsername({
    required CookieRequest request,
    required int userId,
  }) {
    if (_cache.containsKey(userId)) {
      return Future.value(_cache[userId]);
    }

    final existingFuture = _inFlight[userId];
    if (existingFuture != null) {
      return existingFuture;
    }

    final future = _fetchUsername(request, userId);
    _inFlight[userId] = future;
    return future;
  }

  static void primeUsername(int userId, String username) {
    _cache[userId] = username;
  }

  static String? getCachedUsername(int userId) => _cache[userId];

  static Future<String?> _fetchUsername(
    CookieRequest request,
    int userId,
  ) async {
    try {
      final response = await request.get(
        '$_baseApiUrl/get-username/?user_id=$userId',
      );
      final username = _parseUsername(response);
      if (username != null && username.isNotEmpty) {
        _cache[userId] = username;
      }
      return username;
    } catch (_) {
      return null;
    } finally {
      _inFlight.remove(userId);
    }
  }

  static String? _parseUsername(dynamic response) {
    if (response == null) return null;
    if (response is Map && response['username'] != null) {
      return response['username'].toString();
    }
    if (response is List && response.isNotEmpty) {
      return _parseUsername(response.first);
    }
    final value = response.toString().trim();
    return value.isEmpty ? null : value;
  }
}
