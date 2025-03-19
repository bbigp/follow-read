// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'feed_response.dart';

class FeedResponseMapper extends ClassMapperBase<FeedResponse> {
  FeedResponseMapper._();

  static FeedResponseMapper? _instance;
  static FeedResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedResponseMapper._());
      CategoryResponseMapper.ensureInitialized();
      FeedIconResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FeedResponse';

  static int _$id(FeedResponse v) => v.id;
  static const Field<FeedResponse, int> _f$id = Field('id', _$id);
  static int _$userId(FeedResponse v) => v.userId;
  static const Field<FeedResponse, int> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String _$feedUrl(FeedResponse v) => v.feedUrl;
  static const Field<FeedResponse, String> _f$feedUrl =
      Field('feedUrl', _$feedUrl, key: r'feed_url');
  static String _$siteUrl(FeedResponse v) => v.siteUrl;
  static const Field<FeedResponse, String> _f$siteUrl =
      Field('siteUrl', _$siteUrl, key: r'site_url');
  static String _$title(FeedResponse v) => v.title;
  static const Field<FeedResponse, String> _f$title = Field('title', _$title);
  static String? _$description(FeedResponse v) => v.description;
  static const Field<FeedResponse, String> _f$description =
      Field('description', _$description, opt: true);
  static DateTime? _$checkedAt(FeedResponse v) => v.checkedAt;
  static const Field<FeedResponse, DateTime> _f$checkedAt =
      Field('checkedAt', _$checkedAt, key: r'checked_at', opt: true);
  static DateTime? _$nextCheckAt(FeedResponse v) => v.nextCheckAt;
  static const Field<FeedResponse, DateTime> _f$nextCheckAt =
      Field('nextCheckAt', _$nextCheckAt, key: r'next_check_at', opt: true);
  static String? _$etagHeader(FeedResponse v) => v.etagHeader;
  static const Field<FeedResponse, String> _f$etagHeader =
      Field('etagHeader', _$etagHeader, key: r'etag_header', opt: true);
  static String? _$lastModifiedHeader(FeedResponse v) => v.lastModifiedHeader;
  static const Field<FeedResponse, String> _f$lastModifiedHeader = Field(
      'lastModifiedHeader', _$lastModifiedHeader,
      key: r'last_modified_header', opt: true);
  static String? _$parsingErrorMessage(FeedResponse v) => v.parsingErrorMessage;
  static const Field<FeedResponse, String> _f$parsingErrorMessage = Field(
      'parsingErrorMessage', _$parsingErrorMessage,
      key: r'parsing_error_message', opt: true);
  static int? _$parsingErrorCount(FeedResponse v) => v.parsingErrorCount;
  static const Field<FeedResponse, int> _f$parsingErrorCount = Field(
      'parsingErrorCount', _$parsingErrorCount,
      key: r'parsing_error_count', opt: true);
  static String? _$scraperRules(FeedResponse v) => v.scraperRules;
  static const Field<FeedResponse, String> _f$scraperRules =
      Field('scraperRules', _$scraperRules, key: r'scraper_rules', opt: true);
  static String? _$rewriteRules(FeedResponse v) => v.rewriteRules;
  static const Field<FeedResponse, String> _f$rewriteRules =
      Field('rewriteRules', _$rewriteRules, key: r'rewrite_rules', opt: true);
  static bool? _$crawler(FeedResponse v) => v.crawler;
  static const Field<FeedResponse, bool> _f$crawler =
      Field('crawler', _$crawler, opt: true);
  static String? _$blocklistRules(FeedResponse v) => v.blocklistRules;
  static const Field<FeedResponse, String> _f$blocklistRules = Field(
      'blocklistRules', _$blocklistRules,
      key: r'blocklist_rules', opt: true);
  static String? _$keeplistRules(FeedResponse v) => v.keeplistRules;
  static const Field<FeedResponse, String> _f$keeplistRules = Field(
      'keeplistRules', _$keeplistRules,
      key: r'keeplist_rules', opt: true);
  static String? _$urlrewriteRules(FeedResponse v) => v.urlrewriteRules;
  static const Field<FeedResponse, String> _f$urlrewriteRules = Field(
      'urlrewriteRules', _$urlrewriteRules,
      key: r'urlrewrite_rules', opt: true);
  static String? _$userAgent(FeedResponse v) => v.userAgent;
  static const Field<FeedResponse, String> _f$userAgent =
      Field('userAgent', _$userAgent, key: r'user_agent', opt: true);
  static String? _$cookie(FeedResponse v) => v.cookie;
  static const Field<FeedResponse, String> _f$cookie =
      Field('cookie', _$cookie, opt: true);
  static String? _$username(FeedResponse v) => v.username;
  static const Field<FeedResponse, String> _f$username =
      Field('username', _$username, opt: true);
  static String? _$password(FeedResponse v) => v.password;
  static const Field<FeedResponse, String> _f$password =
      Field('password', _$password, opt: true);
  static bool? _$disabled(FeedResponse v) => v.disabled;
  static const Field<FeedResponse, bool> _f$disabled =
      Field('disabled', _$disabled, opt: true);
  static bool? _$noMediaPlayer(FeedResponse v) => v.noMediaPlayer;
  static const Field<FeedResponse, bool> _f$noMediaPlayer = Field(
      'noMediaPlayer', _$noMediaPlayer,
      key: r'no_media_player', opt: true);
  static bool? _$ignoreHttpCache(FeedResponse v) => v.ignoreHttpCache;
  static const Field<FeedResponse, bool> _f$ignoreHttpCache = Field(
      'ignoreHttpCache', _$ignoreHttpCache,
      key: r'ignore_http_cache', opt: true);
  static bool? _$allowSelfSignedCertificates(FeedResponse v) =>
      v.allowSelfSignedCertificates;
  static const Field<FeedResponse, bool> _f$allowSelfSignedCertificates = Field(
      'allowSelfSignedCertificates', _$allowSelfSignedCertificates,
      key: r'allow_self_signed_certificates', opt: true);
  static bool? _$fetchViaProxy(FeedResponse v) => v.fetchViaProxy;
  static const Field<FeedResponse, bool> _f$fetchViaProxy = Field(
      'fetchViaProxy', _$fetchViaProxy,
      key: r'fetch_via_proxy', opt: true);
  static bool? _$hideGlobally(FeedResponse v) => v.hideGlobally;
  static const Field<FeedResponse, bool> _f$hideGlobally =
      Field('hideGlobally', _$hideGlobally, key: r'hide_globally', opt: true);
  static bool? _$disableHttp2(FeedResponse v) => v.disableHttp2;
  static const Field<FeedResponse, bool> _f$disableHttp2 =
      Field('disableHttp2', _$disableHttp2, key: r'disable_http2', opt: true);
  static String? _$appriseServiceUrls(FeedResponse v) => v.appriseServiceUrls;
  static const Field<FeedResponse, String> _f$appriseServiceUrls = Field(
      'appriseServiceUrls', _$appriseServiceUrls,
      key: r'apprise_service_urls', opt: true);
  static bool? _$ntfyEnabled(FeedResponse v) => v.ntfyEnabled;
  static const Field<FeedResponse, bool> _f$ntfyEnabled =
      Field('ntfyEnabled', _$ntfyEnabled, key: r'ntfy_enabled', opt: true);
  static int? _$ntfyPriority(FeedResponse v) => v.ntfyPriority;
  static const Field<FeedResponse, int> _f$ntfyPriority =
      Field('ntfyPriority', _$ntfyPriority, key: r'ntfy_priority', opt: true);
  static CategoryResponse? _$category(FeedResponse v) => v.category;
  static const Field<FeedResponse, CategoryResponse> _f$category =
      Field('category', _$category, opt: true);
  static FeedIconResponse? _$icon(FeedResponse v) => v.icon;
  static const Field<FeedResponse, FeedIconResponse> _f$icon =
      Field('icon', _$icon, opt: true);

  @override
  final MappableFields<FeedResponse> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #feedUrl: _f$feedUrl,
    #siteUrl: _f$siteUrl,
    #title: _f$title,
    #description: _f$description,
    #checkedAt: _f$checkedAt,
    #nextCheckAt: _f$nextCheckAt,
    #etagHeader: _f$etagHeader,
    #lastModifiedHeader: _f$lastModifiedHeader,
    #parsingErrorMessage: _f$parsingErrorMessage,
    #parsingErrorCount: _f$parsingErrorCount,
    #scraperRules: _f$scraperRules,
    #rewriteRules: _f$rewriteRules,
    #crawler: _f$crawler,
    #blocklistRules: _f$blocklistRules,
    #keeplistRules: _f$keeplistRules,
    #urlrewriteRules: _f$urlrewriteRules,
    #userAgent: _f$userAgent,
    #cookie: _f$cookie,
    #username: _f$username,
    #password: _f$password,
    #disabled: _f$disabled,
    #noMediaPlayer: _f$noMediaPlayer,
    #ignoreHttpCache: _f$ignoreHttpCache,
    #allowSelfSignedCertificates: _f$allowSelfSignedCertificates,
    #fetchViaProxy: _f$fetchViaProxy,
    #hideGlobally: _f$hideGlobally,
    #disableHttp2: _f$disableHttp2,
    #appriseServiceUrls: _f$appriseServiceUrls,
    #ntfyEnabled: _f$ntfyEnabled,
    #ntfyPriority: _f$ntfyPriority,
    #category: _f$category,
    #icon: _f$icon,
  };

  static FeedResponse _instantiate(DecodingData data) {
    return FeedResponse(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        feedUrl: data.dec(_f$feedUrl),
        siteUrl: data.dec(_f$siteUrl),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        checkedAt: data.dec(_f$checkedAt),
        nextCheckAt: data.dec(_f$nextCheckAt),
        etagHeader: data.dec(_f$etagHeader),
        lastModifiedHeader: data.dec(_f$lastModifiedHeader),
        parsingErrorMessage: data.dec(_f$parsingErrorMessage),
        parsingErrorCount: data.dec(_f$parsingErrorCount),
        scraperRules: data.dec(_f$scraperRules),
        rewriteRules: data.dec(_f$rewriteRules),
        crawler: data.dec(_f$crawler),
        blocklistRules: data.dec(_f$blocklistRules),
        keeplistRules: data.dec(_f$keeplistRules),
        urlrewriteRules: data.dec(_f$urlrewriteRules),
        userAgent: data.dec(_f$userAgent),
        cookie: data.dec(_f$cookie),
        username: data.dec(_f$username),
        password: data.dec(_f$password),
        disabled: data.dec(_f$disabled),
        noMediaPlayer: data.dec(_f$noMediaPlayer),
        ignoreHttpCache: data.dec(_f$ignoreHttpCache),
        allowSelfSignedCertificates: data.dec(_f$allowSelfSignedCertificates),
        fetchViaProxy: data.dec(_f$fetchViaProxy),
        hideGlobally: data.dec(_f$hideGlobally),
        disableHttp2: data.dec(_f$disableHttp2),
        appriseServiceUrls: data.dec(_f$appriseServiceUrls),
        ntfyEnabled: data.dec(_f$ntfyEnabled),
        ntfyPriority: data.dec(_f$ntfyPriority),
        category: data.dec(_f$category),
        icon: data.dec(_f$icon));
  }

  @override
  final Function instantiate = _instantiate;

  static FeedResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeedResponse>(map);
  }

  static FeedResponse fromJson(String json) {
    return ensureInitialized().decodeJson<FeedResponse>(json);
  }
}

mixin FeedResponseMappable {
  String toJson() {
    return FeedResponseMapper.ensureInitialized()
        .encodeJson<FeedResponse>(this as FeedResponse);
  }

  Map<String, dynamic> toMap() {
    return FeedResponseMapper.ensureInitialized()
        .encodeMap<FeedResponse>(this as FeedResponse);
  }

  FeedResponseCopyWith<FeedResponse, FeedResponse, FeedResponse> get copyWith =>
      _FeedResponseCopyWithImpl<FeedResponse, FeedResponse>(
          this as FeedResponse, $identity, $identity);
  @override
  String toString() {
    return FeedResponseMapper.ensureInitialized()
        .stringifyValue(this as FeedResponse);
  }

  @override
  bool operator ==(Object other) {
    return FeedResponseMapper.ensureInitialized()
        .equalsValue(this as FeedResponse, other);
  }

  @override
  int get hashCode {
    return FeedResponseMapper.ensureInitialized()
        .hashValue(this as FeedResponse);
  }
}

extension FeedResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeedResponse, $Out> {
  FeedResponseCopyWith<$R, FeedResponse, $Out> get $asFeedResponse =>
      $base.as((v, t, t2) => _FeedResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeedResponseCopyWith<$R, $In extends FeedResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CategoryResponseCopyWith<$R, CategoryResponse, CategoryResponse>?
      get category;
  FeedIconResponseCopyWith<$R, FeedIconResponse, FeedIconResponse>? get icon;
  $R call(
      {int? id,
      int? userId,
      String? feedUrl,
      String? siteUrl,
      String? title,
      String? description,
      DateTime? checkedAt,
      DateTime? nextCheckAt,
      String? etagHeader,
      String? lastModifiedHeader,
      String? parsingErrorMessage,
      int? parsingErrorCount,
      String? scraperRules,
      String? rewriteRules,
      bool? crawler,
      String? blocklistRules,
      String? keeplistRules,
      String? urlrewriteRules,
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
      CategoryResponse? category,
      FeedIconResponse? icon});
  FeedResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeedResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeedResponse, $Out>
    implements FeedResponseCopyWith<$R, FeedResponse, $Out> {
  _FeedResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeedResponse> $mapper =
      FeedResponseMapper.ensureInitialized();
  @override
  CategoryResponseCopyWith<$R, CategoryResponse, CategoryResponse>?
      get category =>
          $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  FeedIconResponseCopyWith<$R, FeedIconResponse, FeedIconResponse>? get icon =>
      $value.icon?.copyWith.$chain((v) => call(icon: v));
  @override
  $R call(
          {int? id,
          int? userId,
          String? feedUrl,
          String? siteUrl,
          String? title,
          Object? description = $none,
          Object? checkedAt = $none,
          Object? nextCheckAt = $none,
          Object? etagHeader = $none,
          Object? lastModifiedHeader = $none,
          Object? parsingErrorMessage = $none,
          Object? parsingErrorCount = $none,
          Object? scraperRules = $none,
          Object? rewriteRules = $none,
          Object? crawler = $none,
          Object? blocklistRules = $none,
          Object? keeplistRules = $none,
          Object? urlrewriteRules = $none,
          Object? userAgent = $none,
          Object? cookie = $none,
          Object? username = $none,
          Object? password = $none,
          Object? disabled = $none,
          Object? noMediaPlayer = $none,
          Object? ignoreHttpCache = $none,
          Object? allowSelfSignedCertificates = $none,
          Object? fetchViaProxy = $none,
          Object? hideGlobally = $none,
          Object? disableHttp2 = $none,
          Object? appriseServiceUrls = $none,
          Object? ntfyEnabled = $none,
          Object? ntfyPriority = $none,
          Object? category = $none,
          Object? icon = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (feedUrl != null) #feedUrl: feedUrl,
        if (siteUrl != null) #siteUrl: siteUrl,
        if (title != null) #title: title,
        if (description != $none) #description: description,
        if (checkedAt != $none) #checkedAt: checkedAt,
        if (nextCheckAt != $none) #nextCheckAt: nextCheckAt,
        if (etagHeader != $none) #etagHeader: etagHeader,
        if (lastModifiedHeader != $none)
          #lastModifiedHeader: lastModifiedHeader,
        if (parsingErrorMessage != $none)
          #parsingErrorMessage: parsingErrorMessage,
        if (parsingErrorCount != $none) #parsingErrorCount: parsingErrorCount,
        if (scraperRules != $none) #scraperRules: scraperRules,
        if (rewriteRules != $none) #rewriteRules: rewriteRules,
        if (crawler != $none) #crawler: crawler,
        if (blocklistRules != $none) #blocklistRules: blocklistRules,
        if (keeplistRules != $none) #keeplistRules: keeplistRules,
        if (urlrewriteRules != $none) #urlrewriteRules: urlrewriteRules,
        if (userAgent != $none) #userAgent: userAgent,
        if (cookie != $none) #cookie: cookie,
        if (username != $none) #username: username,
        if (password != $none) #password: password,
        if (disabled != $none) #disabled: disabled,
        if (noMediaPlayer != $none) #noMediaPlayer: noMediaPlayer,
        if (ignoreHttpCache != $none) #ignoreHttpCache: ignoreHttpCache,
        if (allowSelfSignedCertificates != $none)
          #allowSelfSignedCertificates: allowSelfSignedCertificates,
        if (fetchViaProxy != $none) #fetchViaProxy: fetchViaProxy,
        if (hideGlobally != $none) #hideGlobally: hideGlobally,
        if (disableHttp2 != $none) #disableHttp2: disableHttp2,
        if (appriseServiceUrls != $none)
          #appriseServiceUrls: appriseServiceUrls,
        if (ntfyEnabled != $none) #ntfyEnabled: ntfyEnabled,
        if (ntfyPriority != $none) #ntfyPriority: ntfyPriority,
        if (category != $none) #category: category,
        if (icon != $none) #icon: icon
      }));
  @override
  FeedResponse $make(CopyWithData data) => FeedResponse(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      feedUrl: data.get(#feedUrl, or: $value.feedUrl),
      siteUrl: data.get(#siteUrl, or: $value.siteUrl),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      checkedAt: data.get(#checkedAt, or: $value.checkedAt),
      nextCheckAt: data.get(#nextCheckAt, or: $value.nextCheckAt),
      etagHeader: data.get(#etagHeader, or: $value.etagHeader),
      lastModifiedHeader:
          data.get(#lastModifiedHeader, or: $value.lastModifiedHeader),
      parsingErrorMessage:
          data.get(#parsingErrorMessage, or: $value.parsingErrorMessage),
      parsingErrorCount:
          data.get(#parsingErrorCount, or: $value.parsingErrorCount),
      scraperRules: data.get(#scraperRules, or: $value.scraperRules),
      rewriteRules: data.get(#rewriteRules, or: $value.rewriteRules),
      crawler: data.get(#crawler, or: $value.crawler),
      blocklistRules: data.get(#blocklistRules, or: $value.blocklistRules),
      keeplistRules: data.get(#keeplistRules, or: $value.keeplistRules),
      urlrewriteRules: data.get(#urlrewriteRules, or: $value.urlrewriteRules),
      userAgent: data.get(#userAgent, or: $value.userAgent),
      cookie: data.get(#cookie, or: $value.cookie),
      username: data.get(#username, or: $value.username),
      password: data.get(#password, or: $value.password),
      disabled: data.get(#disabled, or: $value.disabled),
      noMediaPlayer: data.get(#noMediaPlayer, or: $value.noMediaPlayer),
      ignoreHttpCache: data.get(#ignoreHttpCache, or: $value.ignoreHttpCache),
      allowSelfSignedCertificates: data.get(#allowSelfSignedCertificates,
          or: $value.allowSelfSignedCertificates),
      fetchViaProxy: data.get(#fetchViaProxy, or: $value.fetchViaProxy),
      hideGlobally: data.get(#hideGlobally, or: $value.hideGlobally),
      disableHttp2: data.get(#disableHttp2, or: $value.disableHttp2),
      appriseServiceUrls:
          data.get(#appriseServiceUrls, or: $value.appriseServiceUrls),
      ntfyEnabled: data.get(#ntfyEnabled, or: $value.ntfyEnabled),
      ntfyPriority: data.get(#ntfyPriority, or: $value.ntfyPriority),
      category: data.get(#category, or: $value.category),
      icon: data.get(#icon, or: $value.icon));

  @override
  FeedResponseCopyWith<$R2, FeedResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FeedResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CategoryResponseMapper extends ClassMapperBase<CategoryResponse> {
  CategoryResponseMapper._();

  static CategoryResponseMapper? _instance;
  static CategoryResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CategoryResponse';

  @override
  final MappableFields<CategoryResponse> fields = const {};

  static CategoryResponse _instantiate(DecodingData data) {
    return CategoryResponse();
  }

  @override
  final Function instantiate = _instantiate;

  static CategoryResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CategoryResponse>(map);
  }

  static CategoryResponse fromJson(String json) {
    return ensureInitialized().decodeJson<CategoryResponse>(json);
  }
}

mixin CategoryResponseMappable {
  String toJson() {
    return CategoryResponseMapper.ensureInitialized()
        .encodeJson<CategoryResponse>(this as CategoryResponse);
  }

  Map<String, dynamic> toMap() {
    return CategoryResponseMapper.ensureInitialized()
        .encodeMap<CategoryResponse>(this as CategoryResponse);
  }

  CategoryResponseCopyWith<CategoryResponse, CategoryResponse, CategoryResponse>
      get copyWith =>
          _CategoryResponseCopyWithImpl<CategoryResponse, CategoryResponse>(
              this as CategoryResponse, $identity, $identity);
  @override
  String toString() {
    return CategoryResponseMapper.ensureInitialized()
        .stringifyValue(this as CategoryResponse);
  }

  @override
  bool operator ==(Object other) {
    return CategoryResponseMapper.ensureInitialized()
        .equalsValue(this as CategoryResponse, other);
  }

  @override
  int get hashCode {
    return CategoryResponseMapper.ensureInitialized()
        .hashValue(this as CategoryResponse);
  }
}

extension CategoryResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CategoryResponse, $Out> {
  CategoryResponseCopyWith<$R, CategoryResponse, $Out>
      get $asCategoryResponse => $base
          .as((v, t, t2) => _CategoryResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CategoryResponseCopyWith<$R, $In extends CategoryResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  CategoryResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CategoryResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CategoryResponse, $Out>
    implements CategoryResponseCopyWith<$R, CategoryResponse, $Out> {
  _CategoryResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CategoryResponse> $mapper =
      CategoryResponseMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CategoryResponse $make(CopyWithData data) => CategoryResponse();

  @override
  CategoryResponseCopyWith<$R2, CategoryResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CategoryResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FeedIconResponseMapper extends ClassMapperBase<FeedIconResponse> {
  FeedIconResponseMapper._();

  static FeedIconResponseMapper? _instance;
  static FeedIconResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedIconResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FeedIconResponse';

  static int _$feedId(FeedIconResponse v) => v.feedId;
  static const Field<FeedIconResponse, int> _f$feedId =
      Field('feedId', _$feedId, key: r'feed_id');
  static int _$iconId(FeedIconResponse v) => v.iconId;
  static const Field<FeedIconResponse, int> _f$iconId =
      Field('iconId', _$iconId, key: r'icon_id');

  @override
  final MappableFields<FeedIconResponse> fields = const {
    #feedId: _f$feedId,
    #iconId: _f$iconId,
  };

  static FeedIconResponse _instantiate(DecodingData data) {
    return FeedIconResponse(
        feedId: data.dec(_f$feedId), iconId: data.dec(_f$iconId));
  }

  @override
  final Function instantiate = _instantiate;

  static FeedIconResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeedIconResponse>(map);
  }

  static FeedIconResponse fromJson(String json) {
    return ensureInitialized().decodeJson<FeedIconResponse>(json);
  }
}

mixin FeedIconResponseMappable {
  String toJson() {
    return FeedIconResponseMapper.ensureInitialized()
        .encodeJson<FeedIconResponse>(this as FeedIconResponse);
  }

  Map<String, dynamic> toMap() {
    return FeedIconResponseMapper.ensureInitialized()
        .encodeMap<FeedIconResponse>(this as FeedIconResponse);
  }

  FeedIconResponseCopyWith<FeedIconResponse, FeedIconResponse, FeedIconResponse>
      get copyWith =>
          _FeedIconResponseCopyWithImpl<FeedIconResponse, FeedIconResponse>(
              this as FeedIconResponse, $identity, $identity);
  @override
  String toString() {
    return FeedIconResponseMapper.ensureInitialized()
        .stringifyValue(this as FeedIconResponse);
  }

  @override
  bool operator ==(Object other) {
    return FeedIconResponseMapper.ensureInitialized()
        .equalsValue(this as FeedIconResponse, other);
  }

  @override
  int get hashCode {
    return FeedIconResponseMapper.ensureInitialized()
        .hashValue(this as FeedIconResponse);
  }
}

extension FeedIconResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeedIconResponse, $Out> {
  FeedIconResponseCopyWith<$R, FeedIconResponse, $Out>
      get $asFeedIconResponse => $base
          .as((v, t, t2) => _FeedIconResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeedIconResponseCopyWith<$R, $In extends FeedIconResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? feedId, int? iconId});
  FeedIconResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FeedIconResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeedIconResponse, $Out>
    implements FeedIconResponseCopyWith<$R, FeedIconResponse, $Out> {
  _FeedIconResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeedIconResponse> $mapper =
      FeedIconResponseMapper.ensureInitialized();
  @override
  $R call({int? feedId, int? iconId}) => $apply(FieldCopyWithData({
        if (feedId != null) #feedId: feedId,
        if (iconId != null) #iconId: iconId
      }));
  @override
  FeedIconResponse $make(CopyWithData data) => FeedIconResponse(
      feedId: data.get(#feedId, or: $value.feedId),
      iconId: data.get(#iconId, or: $value.iconId));

  @override
  FeedIconResponseCopyWith<$R2, FeedIconResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FeedIconResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
