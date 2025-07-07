

import 'package:dart_mappable/dart_mappable.dart';

import 'category_response.dart';
import 'icon_response.dart';

part 'feed_response.mapper.dart';

@MappableClass()
class FeedResponse with FeedResponseMappable {
  final BigInt id;
  @MappableField(key: 'user_id')
  final BigInt userId;
  @MappableField(key: 'feed_url')
  final String feedUrl;
  @MappableField(key: 'site_url')
  final String siteUrl;
  final String title;
  final String? description;
  @MappableField(key: 'checked_at')
  final DateTime? checkedAt;
  @MappableField(key: 'next_check_at')
  final DateTime? nextCheckAt;
  @MappableField(key: 'etag_header')
  final String? etagHeader;
  @MappableField(key: 'last_modified_header')
  final String? lastModifiedHeader;
  @MappableField(key: 'parsing_error_message')
  final String parsingErrorMessage;
  @MappableField(key: 'parsing_error_count')
  final int parsingErrorCount;
  @MappableField(key: 'scraper_rules')
  final String? scraperRules;
  @MappableField(key: 'rewrite_rules')
  final String? rewriteRules;
  final bool? crawler;
  @MappableField(key: 'blocklist_rules')
  final String? blocklistRules;
  @MappableField(key: 'keeplist_rules')
  final String? keeplistRules;
  @MappableField(key: 'urlrewrite_rules')
  final String? urlrewriteRules;
  @MappableField(key: 'user_agent')
  final String? userAgent;
  final String? cookie;
  final String? username;
  final String? password;
  final bool? disabled;
  @MappableField(key: 'no_media_player')
  final bool? noMediaPlayer;
  @MappableField(key: 'ignore_http_cache')
  final bool? ignoreHttpCache;
  @MappableField(key: 'allow_self_signed_certificates')
  final bool? allowSelfSignedCertificates;
  @MappableField(key: 'fetch_via_proxy')
  final bool? fetchViaProxy;
  @MappableField(key: 'hide_globally')
  final bool? hideGlobally;
  @MappableField(key: 'disable_http2')
  final bool? disableHttp2;
  @MappableField(key: 'apprise_service_urls')
  final String? appriseServiceUrls;
  @MappableField(key: 'ntfy_enabled')
  final bool? ntfyEnabled;
  @MappableField(key: 'ntfy_priority')
  final int? ntfyPriority;
  final CategoryResponse? category;
  final IconResponse? icon;

  FeedResponse({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    this.category,
    this.description,
    this.checkedAt,
    this.nextCheckAt,
    this.etagHeader,
    this.lastModifiedHeader,
    this.parsingErrorMessage = "",
    this.parsingErrorCount = 0,
    this.scraperRules,
    this.rewriteRules,
    this.crawler,
    this.blocklistRules,
    this.keeplistRules,
    this.urlrewriteRules,
    this.userAgent,
    this.cookie,
    this.username,
    this.password,
    this.disabled,
    this.noMediaPlayer,
    this.ignoreHttpCache,
    this.allowSelfSignedCertificates,
    this.fetchViaProxy,
    this.hideGlobally,
    this.disableHttp2,
    this.appriseServiceUrls,
    this.ntfyEnabled,
    this.ntfyPriority,
    this.icon,
  });

}
