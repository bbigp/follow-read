
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final bool isAdmin;
  final String theme;
  final String language;
  final String timezone;
  final String entrySortingDirection;
  final String entrySortingOrder;
  final String stylesheet;
  final String googleId;
  final String openidConnectId;
  final int entriesPerPage;
  final bool keyboardShortcuts;
  final bool showReadingTime;
  final bool entrySwipe;
  final String gestureNav;
  final String lastLoginAt;
  final String displayMode;
  final int defaultReadingSpeed;
  final int cjkReadingSpeed;
  final String defaultHomePage;
  final String categoriesSortingOrder;
  final bool markReadOnView;
  final bool markReadOnMediaPlayerCompletion;
  final double mediaPlaybackRate;
  final String blockFilterEntryRules;
  final String keepFilterEntryRules;

  User({
    required this.id,
    required this.username,
    required this.isAdmin,
    this.theme = "",
    this.language = "",
    this.timezone = "",
    this.entrySortingDirection = "",
    this.entrySortingOrder = "",
    this.stylesheet = "",
    this.googleId = "",
    this.openidConnectId = "",
    this.entriesPerPage = 0,
    this.keyboardShortcuts = false,
    this.showReadingTime = false,
    this.entrySwipe = false,
    this.gestureNav = "",
    this.lastLoginAt = "",
    this.displayMode = "",
    this.defaultReadingSpeed = 0,
    this.cjkReadingSpeed = 0,
    this.defaultHomePage = "",
    this.categoriesSortingOrder = "",
    this.markReadOnView = false,
    this.markReadOnMediaPlayerCompletion = false,
    this.mediaPlaybackRate = 0,
    this.blockFilterEntryRules = "",
    this.keepFilterEntryRules = "",
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}