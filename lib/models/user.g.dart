// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      isAdmin: json['isAdmin'] as bool,
      theme: json['theme'] as String? ?? "",
      language: json['language'] as String? ?? "",
      timezone: json['timezone'] as String? ?? "",
      entrySortingDirection: json['entrySortingDirection'] as String? ?? "",
      entrySortingOrder: json['entrySortingOrder'] as String? ?? "",
      stylesheet: json['stylesheet'] as String? ?? "",
      googleId: json['googleId'] as String? ?? "",
      openidConnectId: json['openidConnectId'] as String? ?? "",
      entriesPerPage: (json['entriesPerPage'] as num?)?.toInt() ?? 0,
      keyboardShortcuts: json['keyboardShortcuts'] as bool? ?? false,
      showReadingTime: json['showReadingTime'] as bool? ?? false,
      entrySwipe: json['entrySwipe'] as bool? ?? false,
      gestureNav: json['gestureNav'] as String? ?? "",
      lastLoginAt: json['lastLoginAt'] as String? ?? "",
      displayMode: json['displayMode'] as String? ?? "",
      defaultReadingSpeed: (json['defaultReadingSpeed'] as num?)?.toInt() ?? 0,
      cjkReadingSpeed: (json['cjkReadingSpeed'] as num?)?.toInt() ?? 0,
      defaultHomePage: json['defaultHomePage'] as String? ?? "",
      categoriesSortingOrder: json['categoriesSortingOrder'] as String? ?? "",
      markReadOnView: json['markReadOnView'] as bool? ?? false,
      markReadOnMediaPlayerCompletion:
          json['markReadOnMediaPlayerCompletion'] as bool? ?? false,
      mediaPlaybackRate: (json['mediaPlaybackRate'] as num?)?.toDouble() ?? 0,
      blockFilterEntryRules: json['blockFilterEntryRules'] as String? ?? "",
      keepFilterEntryRules: json['keepFilterEntryRules'] as String? ?? "",
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'isAdmin': instance.isAdmin,
      'theme': instance.theme,
      'language': instance.language,
      'timezone': instance.timezone,
      'entrySortingDirection': instance.entrySortingDirection,
      'entrySortingOrder': instance.entrySortingOrder,
      'stylesheet': instance.stylesheet,
      'googleId': instance.googleId,
      'openidConnectId': instance.openidConnectId,
      'entriesPerPage': instance.entriesPerPage,
      'keyboardShortcuts': instance.keyboardShortcuts,
      'showReadingTime': instance.showReadingTime,
      'entrySwipe': instance.entrySwipe,
      'gestureNav': instance.gestureNav,
      'lastLoginAt': instance.lastLoginAt,
      'displayMode': instance.displayMode,
      'defaultReadingSpeed': instance.defaultReadingSpeed,
      'cjkReadingSpeed': instance.cjkReadingSpeed,
      'defaultHomePage': instance.defaultHomePage,
      'categoriesSortingOrder': instance.categoriesSortingOrder,
      'markReadOnView': instance.markReadOnView,
      'markReadOnMediaPlayerCompletion':
          instance.markReadOnMediaPlayerCompletion,
      'mediaPlaybackRate': instance.mediaPlaybackRate,
      'blockFilterEntryRules': instance.blockFilterEntryRules,
      'keepFilterEntryRules': instance.keepFilterEntryRules,
    };
