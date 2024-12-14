// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map<String, dynamic> json) => Feed(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      feedUrl: json['feed_url'] as String,
      siteUrl: json['site_url'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      checkedAt: DateTime.parse(json['checked_at'] as String),
      nextCheckAt: DateTime.parse(json['next_check_at'] as String),
      etagHeader: json['etag_header'] as String? ?? '',
      lastModifiedHeader: json['last_modified_header'] as String? ?? '',
      parsingErrorMsg: json['parsing_error_message'] as String? ?? '',
      parsingErrorCount: (json['parsing_error_count'] as num?)?.toInt() ?? 0,
      scraperRules: json['scraper_rules'] as String? ?? '',
      rewriteRules: json['rewrite_rules'] as String? ?? '',
      crawler: json['crawler'] as bool? ?? false,
      blocklistRules: json['blocklist_rules'] as String? ?? '',
      keeplistRules: json['keeplist_rules'] as String? ?? '',
      urlRewriteRules: json['urlrewrite_rules'] as String? ?? '',
      userAgent: json['user_agent'] as String? ?? '',
      cookie: json['cookie'] as String? ?? '',
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      disabled: json['disabled'] as bool? ?? false,
      noMediaPlayer: json['no_media_player'] as bool? ?? false,
      ignoreHttpCache: json['ignore_http_cache'] as bool? ?? false,
      allowSelfSignedCertificates:
          json['allow_self_signed_certificates'] as bool? ?? false,
      fetchViaProxy: json['fetch_via_proxy'] as bool? ?? false,
      hideGlobally: json['hide_globally'] as bool? ?? false,
      disableHttp2: json['disable_http2'] as bool? ?? false,
      appriseServiceUrls: json['apprise_service_urls'] as String? ?? '',
      ntfyEnabled: json['ntfy_enabled'] as bool? ?? false,
      ntfyPriority: (json['ntfy_priority'] as num?)?.toInt() ?? 0,
      icon: json['icon'] == null
          ? null
          : FeedIcon.fromJson(json['icon'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'feed_url': instance.feedUrl,
      'site_url': instance.siteUrl,
      'title': instance.title,
      'description': instance.description,
      'checked_at': instance.checkedAt.toIso8601String(),
      'next_check_at': instance.nextCheckAt.toIso8601String(),
      'etag_header': instance.etagHeader,
      'last_modified_header': instance.lastModifiedHeader,
      'parsing_error_message': instance.parsingErrorMsg,
      'parsing_error_count': instance.parsingErrorCount,
      'scraper_rules': instance.scraperRules,
      'rewrite_rules': instance.rewriteRules,
      'crawler': instance.crawler,
      'blocklist_rules': instance.blocklistRules,
      'keeplist_rules': instance.keeplistRules,
      'urlrewrite_rules': instance.urlRewriteRules,
      'user_agent': instance.userAgent,
      'cookie': instance.cookie,
      'username': instance.username,
      'password': instance.password,
      'disabled': instance.disabled,
      'no_media_player': instance.noMediaPlayer,
      'ignore_http_cache': instance.ignoreHttpCache,
      'allow_self_signed_certificates': instance.allowSelfSignedCertificates,
      'fetch_via_proxy': instance.fetchViaProxy,
      'hide_globally': instance.hideGlobally,
      'disable_http2': instance.disableHttp2,
      'apprise_service_urls': instance.appriseServiceUrls,
      'ntfy_enabled': instance.ntfyEnabled,
      'ntfy_priority': instance.ntfyPriority,
      'icon': instance.icon,
      'category': instance.category,
    };
