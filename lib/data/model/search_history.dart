


import 'package:follow_read/data/repositories/app_database.dart';

class SearchHistory {
  final int id;
  final BigInt userId;
  final String word;
  final String metaId;
  final DateTime createdAt;

  SearchHistory({
    int? id,
    BigInt? userId,
    String? word,
    String? metaId,
    DateTime? createdAt,
  })  : id = id ?? 0,
        userId = userId ?? BigInt.zero,
        word = word ?? "",
        metaId = metaId ?? "",
        createdAt = createdAt ?? DateTime.now();

  SearchHistory copyWith({
    int? id,
    BigInt? userId,
    String? word,
    String? metaId,
    DateTime? createdAt,
  }) {
    return SearchHistory(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      word: word ?? this.word,
      metaId: metaId ?? this.metaId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

extension SearchHistoryRowExtension on SearchHistoryRow {
  SearchHistory to() {
    return SearchHistory(
      id: id, userId: userId, word: word, metaId: metaId,
      createdAt: createdAt,
    );
  }
}

