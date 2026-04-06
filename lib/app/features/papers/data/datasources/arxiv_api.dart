import 'package:dio/dio.dart';

class ArxivApi {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30), // 🔥 FIX
      receiveTimeout: const Duration(seconds: 30), // 🔥 FIX
    ),
  );

  final Map<String, String> _cache = {};

  Future<String> fetchPapers(String category, String query) async {
    final cleanQuery = query.trim();

    /// ✅ Better query handling
    final searchQuery = cleanQuery.isEmpty
        ? "cat:$category"
        : "cat:$category AND all:$cleanQuery";

    final cacheKey = "$category-$searchQuery";

    /// ✅ Cache (instant response if already loaded)
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final response = await dio.get(
        "https://export.arxiv.org/api/query",
        queryParameters: {
          "search_query": searchQuery,
          "start": 0,
          "max_results": 15, // 🔥 reduce = faster response
          "sortBy": "lastUpdatedDate",
          "sortOrder": "descending",
        },
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        final data = response.data.toString();
        _cache[cacheKey] = data;
        return data;
      } else {
        throw Exception("API Error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      /// 🔥 Better error handling
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout. Please try again.");
      }

      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Server is slow. Try again.");
      }

      if (e.response?.statusCode == 429) {
        throw Exception("Too many requests. Wait a moment 🙏");
      }

      throw Exception("Network error: ${e.message}");
    }
  }
}