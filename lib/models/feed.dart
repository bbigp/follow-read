import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'icon.dart';

part 'feed.g.dart';

@JsonSerializable()
class Feed {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'feed_url')
  final String feedUrl;
  @JsonKey(name: 'site_url')
  final String siteUrl;
  final String title;
  final String description;
  @JsonKey(name: 'checked_at')
  final DateTime checkedAt;
  @JsonKey(name: 'next_check_at')
  final DateTime nextCheckAt;
  @JsonKey(name: 'etag_header')
  final String etagHeader;
  @JsonKey(name: 'last_modified_header')
  final String lastModifiedHeader;
  @JsonKey(name: 'parsing_error_message')
  final String parsingErrorMsg;
  @JsonKey(name: 'parsing_error_count')
  final int parsingErrorCount;
  @JsonKey(name: 'scraper_rules')
  final String scraperRules;
  @JsonKey(name: 'rewrite_rules')
  final String rewriteRules;
  final bool crawler;
  @JsonKey(name: 'blocklist_rules')
  final String blocklistRules;
  @JsonKey(name: 'keeplist_rules')
  final String keeplistRules;
  @JsonKey(name: 'urlrewrite_rules')
  final String urlRewriteRules;
  @JsonKey(name: 'user_agent')
  final String userAgent;
  final String cookie;
  final String username;
  final String password;
  final bool disabled;
  @JsonKey(name: 'no_media_player')
  final bool noMediaPlayer;
  @JsonKey(name: 'ignore_http_cache')
  final bool ignoreHttpCache;
  @JsonKey(name: 'allow_self_signed_certificates')
  final bool allowSelfSignedCertificates;
  @JsonKey(name: 'fetch_via_proxy')
  final bool fetchViaProxy;
  @JsonKey(name: 'hide_globally')
  final bool hideGlobally;
  @JsonKey(name: 'disable_http2')
  final bool disableHttp2;
  @JsonKey(name: 'apprise_service_urls')
  final String appriseServiceUrls;
  @JsonKey(name: 'ntfy_enabled')
  final bool ntfyEnabled;
  @JsonKey(name: 'ntfy_priority')
  final int ntfyPriority;

  // Internal attributes (not exposed in API)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int ttl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String iconUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int unreadCount;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int readCount;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int numberOfVisibleEntries;

  @JsonKey(name: 'icon')
  final FeedIcon? icon;

  @JsonKey(name: 'category')
  final Category? category;

  Feed({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    required this.description,
    required this.checkedAt,
    required this.nextCheckAt,
    this.etagHeader = '',
    this.lastModifiedHeader = '',
    this.parsingErrorMsg = '',
    this.parsingErrorCount = 0,
    this.scraperRules = '',
    this.rewriteRules = '',
    this.crawler = false,
    this.blocklistRules = '',
    this.keeplistRules = '',
    this.urlRewriteRules = '',
    this.userAgent = '',
    this.cookie = '',
    this.username = '',
    this.password = '',
    this.disabled = false,
    this.noMediaPlayer = false,
    this.ignoreHttpCache = false,
    this.allowSelfSignedCertificates = false,
    this.fetchViaProxy = false,
    this.hideGlobally = false,
    this.disableHttp2 = false,
    this.appriseServiceUrls = '',
    this.ntfyEnabled = false,
    this.ntfyPriority = 0,
    this.ttl = 0,
    this.iconUrl = '',
    this.unreadCount = 0,
    this.readCount = 0,
    this.numberOfVisibleEntries = 0,
    this.icon,
    this.category,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

  Map<String, dynamic> toJson() => _$FeedToJson(this);

  Feed copyWith({
    int? id,
    int? userId,
    String? feedUrl,
    String? siteUrl,
    String? title,
    String? description,
    DateTime? checkedAt,
    DateTime? nextCheckAt,
    String? etagHeader,
    String? lastModifiedHeader,
    String? parsingErrorMsg,
    int? parsingErrorCount,
    String? scraperRules,
    String? rewriteRules,
    bool? crawler,
    String? blocklistRules,
    String? keeplistRules,
    String? urlRewriteRules,
    String? userAgent,
    String? cookie,
    String? username,
    String? password,
    bool? disabled,
    bool? noMediaPlayer,
    bool? ignoreHttpCache,
    bool? allowSelfSignedCertificates,
    bool? fetchViaProxy,
    bool? hideGlobally,
    bool? disableHttp2,
    String? appriseServiceUrls,
    bool? ntfyEnabled,
    int? ntfyPriority,
    FeedIcon? icon,
    Category? category,
  }) {
    return Feed(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      checkedAt: checkedAt ?? this.checkedAt,
      nextCheckAt: nextCheckAt ?? this.nextCheckAt,
      etagHeader: etagHeader ?? this.etagHeader,
      lastModifiedHeader: lastModifiedHeader ?? this.lastModifiedHeader,
      parsingErrorMsg: parsingErrorMsg ?? this.parsingErrorMsg,
      parsingErrorCount: parsingErrorCount ?? this.parsingErrorCount,
      scraperRules: scraperRules ?? this.scraperRules,
      rewriteRules: rewriteRules ?? this.rewriteRules,
      crawler: crawler ?? this.crawler,
      blocklistRules: blocklistRules ?? this.blocklistRules,
      keeplistRules: keeplistRules ?? this.keeplistRules,
      urlRewriteRules: urlRewriteRules ?? this.urlRewriteRules,
      userAgent: userAgent ?? this.userAgent,
      cookie: cookie ?? this.cookie,
      username: username ?? this.username,
      password: password ?? this.password,
      disabled: disabled ?? this.disabled,
      noMediaPlayer: noMediaPlayer ?? this.noMediaPlayer,
      ignoreHttpCache: ignoreHttpCache ?? this.ignoreHttpCache,
      allowSelfSignedCertificates:
          allowSelfSignedCertificates ?? this.allowSelfSignedCertificates,
      fetchViaProxy: fetchViaProxy ?? this.fetchViaProxy,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      disableHttp2: disableHttp2 ?? this.disableHttp2,
      appriseServiceUrls: appriseServiceUrls ?? this.appriseServiceUrls,
      ntfyEnabled: ntfyEnabled ?? this.ntfyEnabled,
      ntfyPriority: ntfyPriority ?? this.ntfyPriority,
      icon: icon ?? this.icon,
      category: category ?? this.category,
    );
  }
}
