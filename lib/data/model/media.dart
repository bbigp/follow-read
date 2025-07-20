


import 'package:follow_read/data/providers/miniflux/media.dart';
import 'package:follow_read/data/repositories/app_database.dart';

class Media {

  final BigInt id;
  final BigInt userId;
  final BigInt entryId;
  final String url;
  final String mimeType;
  final int size;

  const Media({required this.url, required this.mimeType,
    required this.id, required this.userId,
    required this.entryId, this.size = 0,
  });

  static final Media empty = Media(url: "", mimeType: "", id: BigInt.zero, userId: BigInt.zero, entryId: BigInt.zero);

  bool get isImage => mimeType.contains("image");

  bool get isVideo => mimeType.contains("video");

}


extension MediaRowExtension on MediaRow {
  Media toMedia() {
    return Media(
      id: id, userId: userId, entryId: entryId,
      url: url, mimeType: mimeType,
      size: size,
    );
  }
}


extension MediaResponseExtension on MediaResponse {
  Media toMedia(){
    return Media(
      url: url, mimeType: mimeType, id: id, entryId: entryId, userId: userId,
      size: size,
    );
  }
}