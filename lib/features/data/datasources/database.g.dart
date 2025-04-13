// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FeedsTableTable extends FeedsTable
    with TableInfo<$FeedsTableTable, FeedEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
      'id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<BigInt> userId = GeneratedColumn<BigInt>(
      'user_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  static const VerificationMeta _feedUrlMeta =
      const VerificationMeta('feedUrl');
  @override
  late final GeneratedColumn<String> feedUrl = GeneratedColumn<String>(
      'feed_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _siteUrlMeta =
      const VerificationMeta('siteUrl');
  @override
  late final GeneratedColumn<String> siteUrl = GeneratedColumn<String>(
      'site_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unreadMeta = const VerificationMeta('unread');
  @override
  late final GeneratedColumn<int> unread = GeneratedColumn<int>(
      'unread', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _readMeta = const VerificationMeta('read');
  @override
  late final GeneratedColumn<int> read = GeneratedColumn<int>(
      'read', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _iconUrlMeta =
      const VerificationMeta('iconUrl');
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
      'icon_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _onlyShowUnreadMeta =
      const VerificationMeta('onlyShowUnread');
  @override
  late final GeneratedColumn<bool> onlyShowUnread = GeneratedColumn<bool>(
      'only_show_unread', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("only_show_unread" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _showReadingTimeMeta =
      const VerificationMeta('showReadingTime');
  @override
  late final GeneratedColumn<bool> showReadingTime = GeneratedColumn<bool>(
      'show_reading_time', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_reading_time" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _errorCountMeta =
      const VerificationMeta('errorCount');
  @override
  late final GeneratedColumn<int> errorCount = GeneratedColumn<int>(
      'error_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMsgMeta =
      const VerificationMeta('errorMsg');
  @override
  late final GeneratedColumn<String> errorMsg = GeneratedColumn<String>(
      'error_msg', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<BigInt> categoryId = GeneratedColumn<BigInt>(
      'category_id', aliasedName, false,
      type: DriftSqlType.bigInt,
      requiredDuringInsert: false,
      defaultValue: Constant(BigInt.zero));
  static const VerificationMeta _orderxMeta = const VerificationMeta('orderx');
  @override
  late final GeneratedColumn<String> orderx = GeneratedColumn<String>(
      'orderx', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant("published_at"));
  static const VerificationMeta _hideGloballyMeta =
      const VerificationMeta('hideGlobally');
  @override
  late final GeneratedColumn<bool> hideGlobally = GeneratedColumn<bool>(
      'hide_globally', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("hide_globally" IN (0, 1))'),
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        feedUrl,
        siteUrl,
        title,
        unread,
        read,
        iconUrl,
        onlyShowUnread,
        showReadingTime,
        errorCount,
        errorMsg,
        categoryId,
        orderx,
        hideGlobally
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeds';
  @override
  VerificationContext validateIntegrity(Insertable<FeedEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('feed_url')) {
      context.handle(_feedUrlMeta,
          feedUrl.isAcceptableOrUnknown(data['feed_url']!, _feedUrlMeta));
    } else if (isInserting) {
      context.missing(_feedUrlMeta);
    }
    if (data.containsKey('site_url')) {
      context.handle(_siteUrlMeta,
          siteUrl.isAcceptableOrUnknown(data['site_url']!, _siteUrlMeta));
    } else if (isInserting) {
      context.missing(_siteUrlMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('unread')) {
      context.handle(_unreadMeta,
          unread.isAcceptableOrUnknown(data['unread']!, _unreadMeta));
    }
    if (data.containsKey('read')) {
      context.handle(
          _readMeta, read.isAcceptableOrUnknown(data['read']!, _readMeta));
    }
    if (data.containsKey('icon_url')) {
      context.handle(_iconUrlMeta,
          iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta));
    }
    if (data.containsKey('only_show_unread')) {
      context.handle(
          _onlyShowUnreadMeta,
          onlyShowUnread.isAcceptableOrUnknown(
              data['only_show_unread']!, _onlyShowUnreadMeta));
    }
    if (data.containsKey('show_reading_time')) {
      context.handle(
          _showReadingTimeMeta,
          showReadingTime.isAcceptableOrUnknown(
              data['show_reading_time']!, _showReadingTimeMeta));
    }
    if (data.containsKey('error_count')) {
      context.handle(
          _errorCountMeta,
          errorCount.isAcceptableOrUnknown(
              data['error_count']!, _errorCountMeta));
    }
    if (data.containsKey('error_msg')) {
      context.handle(_errorMsgMeta,
          errorMsg.isAcceptableOrUnknown(data['error_msg']!, _errorMsgMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('orderx')) {
      context.handle(_orderxMeta,
          orderx.isAcceptableOrUnknown(data['orderx']!, _orderxMeta));
    }
    if (data.containsKey('hide_globally')) {
      context.handle(
          _hideGloballyMeta,
          hideGlobally.isAcceptableOrUnknown(
              data['hide_globally']!, _hideGloballyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
      feedUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feed_url'])!,
      siteUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}site_url'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      unread: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread'])!,
      read: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}read'])!,
      iconUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_url'])!,
      onlyShowUnread: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}only_show_unread'])!,
      showReadingTime: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_reading_time'])!,
      errorCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}error_count'])!,
      errorMsg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_msg'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}category_id'])!,
      orderx: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orderx'])!,
      hideGlobally: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hide_globally'])!,
    );
  }

  @override
  $FeedsTableTable createAlias(String alias) {
    return $FeedsTableTable(attachedDatabase, alias);
  }
}

class FeedEntity extends DataClass implements Insertable<FeedEntity> {
  final BigInt id;
  final BigInt userId;
  final String feedUrl;
  final String siteUrl;
  final String title;
  final int unread;
  final int read;
  final String iconUrl;
  final bool onlyShowUnread;
  final bool showReadingTime;
  final int errorCount;
  final String errorMsg;
  final BigInt categoryId;
  final String orderx;
  final bool hideGlobally;
  const FeedEntity(
      {required this.id,
      required this.userId,
      required this.feedUrl,
      required this.siteUrl,
      required this.title,
      required this.unread,
      required this.read,
      required this.iconUrl,
      required this.onlyShowUnread,
      required this.showReadingTime,
      required this.errorCount,
      required this.errorMsg,
      required this.categoryId,
      required this.orderx,
      required this.hideGlobally});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['user_id'] = Variable<BigInt>(userId);
    map['feed_url'] = Variable<String>(feedUrl);
    map['site_url'] = Variable<String>(siteUrl);
    map['title'] = Variable<String>(title);
    map['unread'] = Variable<int>(unread);
    map['read'] = Variable<int>(read);
    map['icon_url'] = Variable<String>(iconUrl);
    map['only_show_unread'] = Variable<bool>(onlyShowUnread);
    map['show_reading_time'] = Variable<bool>(showReadingTime);
    map['error_count'] = Variable<int>(errorCount);
    map['error_msg'] = Variable<String>(errorMsg);
    map['category_id'] = Variable<BigInt>(categoryId);
    map['orderx'] = Variable<String>(orderx);
    map['hide_globally'] = Variable<bool>(hideGlobally);
    return map;
  }

  FeedsTableCompanion toCompanion(bool nullToAbsent) {
    return FeedsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      feedUrl: Value(feedUrl),
      siteUrl: Value(siteUrl),
      title: Value(title),
      unread: Value(unread),
      read: Value(read),
      iconUrl: Value(iconUrl),
      onlyShowUnread: Value(onlyShowUnread),
      showReadingTime: Value(showReadingTime),
      errorCount: Value(errorCount),
      errorMsg: Value(errorMsg),
      categoryId: Value(categoryId),
      orderx: Value(orderx),
      hideGlobally: Value(hideGlobally),
    );
  }

  factory FeedEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedEntity(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      feedUrl: serializer.fromJson<String>(json['feedUrl']),
      siteUrl: serializer.fromJson<String>(json['siteUrl']),
      title: serializer.fromJson<String>(json['title']),
      unread: serializer.fromJson<int>(json['unread']),
      read: serializer.fromJson<int>(json['read']),
      iconUrl: serializer.fromJson<String>(json['iconUrl']),
      onlyShowUnread: serializer.fromJson<bool>(json['onlyShowUnread']),
      showReadingTime: serializer.fromJson<bool>(json['showReadingTime']),
      errorCount: serializer.fromJson<int>(json['errorCount']),
      errorMsg: serializer.fromJson<String>(json['errorMsg']),
      categoryId: serializer.fromJson<BigInt>(json['categoryId']),
      orderx: serializer.fromJson<String>(json['orderx']),
      hideGlobally: serializer.fromJson<bool>(json['hideGlobally']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'userId': serializer.toJson<BigInt>(userId),
      'feedUrl': serializer.toJson<String>(feedUrl),
      'siteUrl': serializer.toJson<String>(siteUrl),
      'title': serializer.toJson<String>(title),
      'unread': serializer.toJson<int>(unread),
      'read': serializer.toJson<int>(read),
      'iconUrl': serializer.toJson<String>(iconUrl),
      'onlyShowUnread': serializer.toJson<bool>(onlyShowUnread),
      'showReadingTime': serializer.toJson<bool>(showReadingTime),
      'errorCount': serializer.toJson<int>(errorCount),
      'errorMsg': serializer.toJson<String>(errorMsg),
      'categoryId': serializer.toJson<BigInt>(categoryId),
      'orderx': serializer.toJson<String>(orderx),
      'hideGlobally': serializer.toJson<bool>(hideGlobally),
    };
  }

  FeedEntity copyWith(
          {BigInt? id,
          BigInt? userId,
          String? feedUrl,
          String? siteUrl,
          String? title,
          int? unread,
          int? read,
          String? iconUrl,
          bool? onlyShowUnread,
          bool? showReadingTime,
          int? errorCount,
          String? errorMsg,
          BigInt? categoryId,
          String? orderx,
          bool? hideGlobally}) =>
      FeedEntity(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        feedUrl: feedUrl ?? this.feedUrl,
        siteUrl: siteUrl ?? this.siteUrl,
        title: title ?? this.title,
        unread: unread ?? this.unread,
        read: read ?? this.read,
        iconUrl: iconUrl ?? this.iconUrl,
        onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
        showReadingTime: showReadingTime ?? this.showReadingTime,
        errorCount: errorCount ?? this.errorCount,
        errorMsg: errorMsg ?? this.errorMsg,
        categoryId: categoryId ?? this.categoryId,
        orderx: orderx ?? this.orderx,
        hideGlobally: hideGlobally ?? this.hideGlobally,
      );
  FeedEntity copyWithCompanion(FeedsTableCompanion data) {
    return FeedEntity(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      feedUrl: data.feedUrl.present ? data.feedUrl.value : this.feedUrl,
      siteUrl: data.siteUrl.present ? data.siteUrl.value : this.siteUrl,
      title: data.title.present ? data.title.value : this.title,
      unread: data.unread.present ? data.unread.value : this.unread,
      read: data.read.present ? data.read.value : this.read,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      onlyShowUnread: data.onlyShowUnread.present
          ? data.onlyShowUnread.value
          : this.onlyShowUnread,
      showReadingTime: data.showReadingTime.present
          ? data.showReadingTime.value
          : this.showReadingTime,
      errorCount:
          data.errorCount.present ? data.errorCount.value : this.errorCount,
      errorMsg: data.errorMsg.present ? data.errorMsg.value : this.errorMsg,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      orderx: data.orderx.present ? data.orderx.value : this.orderx,
      hideGlobally: data.hideGlobally.present
          ? data.hideGlobally.value
          : this.hideGlobally,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedEntity(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedUrl: $feedUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('title: $title, ')
          ..write('unread: $unread, ')
          ..write('read: $read, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('showReadingTime: $showReadingTime, ')
          ..write('errorCount: $errorCount, ')
          ..write('errorMsg: $errorMsg, ')
          ..write('categoryId: $categoryId, ')
          ..write('orderx: $orderx, ')
          ..write('hideGlobally: $hideGlobally')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      feedUrl,
      siteUrl,
      title,
      unread,
      read,
      iconUrl,
      onlyShowUnread,
      showReadingTime,
      errorCount,
      errorMsg,
      categoryId,
      orderx,
      hideGlobally);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedEntity &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.feedUrl == this.feedUrl &&
          other.siteUrl == this.siteUrl &&
          other.title == this.title &&
          other.unread == this.unread &&
          other.read == this.read &&
          other.iconUrl == this.iconUrl &&
          other.onlyShowUnread == this.onlyShowUnread &&
          other.showReadingTime == this.showReadingTime &&
          other.errorCount == this.errorCount &&
          other.errorMsg == this.errorMsg &&
          other.categoryId == this.categoryId &&
          other.orderx == this.orderx &&
          other.hideGlobally == this.hideGlobally);
}

class FeedsTableCompanion extends UpdateCompanion<FeedEntity> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<String> feedUrl;
  final Value<String> siteUrl;
  final Value<String> title;
  final Value<int> unread;
  final Value<int> read;
  final Value<String> iconUrl;
  final Value<bool> onlyShowUnread;
  final Value<bool> showReadingTime;
  final Value<int> errorCount;
  final Value<String> errorMsg;
  final Value<BigInt> categoryId;
  final Value<String> orderx;
  final Value<bool> hideGlobally;
  const FeedsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.unread = const Value.absent(),
    this.read = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.showReadingTime = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.errorMsg = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.orderx = const Value.absent(),
    this.hideGlobally = const Value.absent(),
  });
  FeedsTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required String feedUrl,
    required String siteUrl,
    required String title,
    this.unread = const Value.absent(),
    this.read = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.showReadingTime = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.errorMsg = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.orderx = const Value.absent(),
    this.hideGlobally = const Value.absent(),
  })  : userId = Value(userId),
        feedUrl = Value(feedUrl),
        siteUrl = Value(siteUrl),
        title = Value(title);
  static Insertable<FeedEntity> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<String>? feedUrl,
    Expression<String>? siteUrl,
    Expression<String>? title,
    Expression<int>? unread,
    Expression<int>? read,
    Expression<String>? iconUrl,
    Expression<bool>? onlyShowUnread,
    Expression<bool>? showReadingTime,
    Expression<int>? errorCount,
    Expression<String>? errorMsg,
    Expression<BigInt>? categoryId,
    Expression<String>? orderx,
    Expression<bool>? hideGlobally,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (feedUrl != null) 'feed_url': feedUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (title != null) 'title': title,
      if (unread != null) 'unread': unread,
      if (read != null) 'read': read,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (onlyShowUnread != null) 'only_show_unread': onlyShowUnread,
      if (showReadingTime != null) 'show_reading_time': showReadingTime,
      if (errorCount != null) 'error_count': errorCount,
      if (errorMsg != null) 'error_msg': errorMsg,
      if (categoryId != null) 'category_id': categoryId,
      if (orderx != null) 'orderx': orderx,
      if (hideGlobally != null) 'hide_globally': hideGlobally,
    });
  }

  FeedsTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<String>? feedUrl,
      Value<String>? siteUrl,
      Value<String>? title,
      Value<int>? unread,
      Value<int>? read,
      Value<String>? iconUrl,
      Value<bool>? onlyShowUnread,
      Value<bool>? showReadingTime,
      Value<int>? errorCount,
      Value<String>? errorMsg,
      Value<BigInt>? categoryId,
      Value<String>? orderx,
      Value<bool>? hideGlobally}) {
    return FeedsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      unread: unread ?? this.unread,
      read: read ?? this.read,
      iconUrl: iconUrl ?? this.iconUrl,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      showReadingTime: showReadingTime ?? this.showReadingTime,
      errorCount: errorCount ?? this.errorCount,
      errorMsg: errorMsg ?? this.errorMsg,
      categoryId: categoryId ?? this.categoryId,
      orderx: orderx ?? this.orderx,
      hideGlobally: hideGlobally ?? this.hideGlobally,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<BigInt>(userId.value);
    }
    if (feedUrl.present) {
      map['feed_url'] = Variable<String>(feedUrl.value);
    }
    if (siteUrl.present) {
      map['site_url'] = Variable<String>(siteUrl.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (unread.present) {
      map['unread'] = Variable<int>(unread.value);
    }
    if (read.present) {
      map['read'] = Variable<int>(read.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (onlyShowUnread.present) {
      map['only_show_unread'] = Variable<bool>(onlyShowUnread.value);
    }
    if (showReadingTime.present) {
      map['show_reading_time'] = Variable<bool>(showReadingTime.value);
    }
    if (errorCount.present) {
      map['error_count'] = Variable<int>(errorCount.value);
    }
    if (errorMsg.present) {
      map['error_msg'] = Variable<String>(errorMsg.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<BigInt>(categoryId.value);
    }
    if (orderx.present) {
      map['orderx'] = Variable<String>(orderx.value);
    }
    if (hideGlobally.present) {
      map['hide_globally'] = Variable<bool>(hideGlobally.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedUrl: $feedUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('title: $title, ')
          ..write('unread: $unread, ')
          ..write('read: $read, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('showReadingTime: $showReadingTime, ')
          ..write('errorCount: $errorCount, ')
          ..write('errorMsg: $errorMsg, ')
          ..write('categoryId: $categoryId, ')
          ..write('orderx: $orderx, ')
          ..write('hideGlobally: $hideGlobally')
          ..write(')'))
        .toString();
  }
}

class $EntriesTableTable extends EntriesTable
    with TableInfo<$EntriesTableTable, EntryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
      'id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<BigInt> userId = GeneratedColumn<BigInt>(
      'user_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  static const VerificationMeta _feedIdMeta = const VerificationMeta('feedId');
  @override
  late final GeneratedColumn<BigInt> feedId = GeneratedColumn<BigInt>(
      'feed_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("unread"));
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
      'hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _changedAtMeta =
      const VerificationMeta('changedAt');
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
      'changed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _starredMeta =
      const VerificationMeta('starred');
  @override
  late final GeneratedColumn<bool> starred = GeneratedColumn<bool>(
      'starred', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("starred" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _readingTimeMeta =
      const VerificationMeta('readingTime');
  @override
  late final GeneratedColumn<int> readingTime = GeneratedColumn<int>(
      'reading_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        feedId,
        status,
        hash,
        title,
        url,
        publishedAt,
        createdAt,
        changedAt,
        summary,
        content,
        author,
        starred,
        readingTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(Insertable<EntryEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('feed_id')) {
      context.handle(_feedIdMeta,
          feedId.isAcceptableOrUnknown(data['feed_id']!, _feedIdMeta));
    } else if (isInserting) {
      context.missing(_feedIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('starred')) {
      context.handle(_starredMeta,
          starred.isAcceptableOrUnknown(data['starred']!, _starredMeta));
    }
    if (data.containsKey('reading_time')) {
      context.handle(
          _readingTimeMeta,
          readingTime.isAcceptableOrUnknown(
              data['reading_time']!, _readingTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
      feedId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}feed_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hash'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      starred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}starred'])!,
      readingTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_time'])!,
    );
  }

  @override
  $EntriesTableTable createAlias(String alias) {
    return $EntriesTableTable(attachedDatabase, alias);
  }
}

class EntryEntity extends DataClass implements Insertable<EntryEntity> {
  final BigInt id;
  final BigInt userId;
  final BigInt feedId;
  final String status;
  final String hash;
  final String title;
  final String url;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime changedAt;
  final String summary;
  final String content;
  final String author;
  final bool starred;
  final int readingTime;
  const EntryEntity(
      {required this.id,
      required this.userId,
      required this.feedId,
      required this.status,
      required this.hash,
      required this.title,
      required this.url,
      required this.publishedAt,
      required this.createdAt,
      required this.changedAt,
      required this.summary,
      required this.content,
      required this.author,
      required this.starred,
      required this.readingTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['user_id'] = Variable<BigInt>(userId);
    map['feed_id'] = Variable<BigInt>(feedId);
    map['status'] = Variable<String>(status);
    map['hash'] = Variable<String>(hash);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['changed_at'] = Variable<DateTime>(changedAt);
    map['summary'] = Variable<String>(summary);
    map['content'] = Variable<String>(content);
    map['author'] = Variable<String>(author);
    map['starred'] = Variable<bool>(starred);
    map['reading_time'] = Variable<int>(readingTime);
    return map;
  }

  EntriesTableCompanion toCompanion(bool nullToAbsent) {
    return EntriesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      feedId: Value(feedId),
      status: Value(status),
      hash: Value(hash),
      title: Value(title),
      url: Value(url),
      publishedAt: Value(publishedAt),
      createdAt: Value(createdAt),
      changedAt: Value(changedAt),
      summary: Value(summary),
      content: Value(content),
      author: Value(author),
      starred: Value(starred),
      readingTime: Value(readingTime),
    );
  }

  factory EntryEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryEntity(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      feedId: serializer.fromJson<BigInt>(json['feedId']),
      status: serializer.fromJson<String>(json['status']),
      hash: serializer.fromJson<String>(json['hash']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      summary: serializer.fromJson<String>(json['summary']),
      content: serializer.fromJson<String>(json['content']),
      author: serializer.fromJson<String>(json['author']),
      starred: serializer.fromJson<bool>(json['starred']),
      readingTime: serializer.fromJson<int>(json['readingTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'userId': serializer.toJson<BigInt>(userId),
      'feedId': serializer.toJson<BigInt>(feedId),
      'status': serializer.toJson<String>(status),
      'hash': serializer.toJson<String>(hash),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'summary': serializer.toJson<String>(summary),
      'content': serializer.toJson<String>(content),
      'author': serializer.toJson<String>(author),
      'starred': serializer.toJson<bool>(starred),
      'readingTime': serializer.toJson<int>(readingTime),
    };
  }

  EntryEntity copyWith(
          {BigInt? id,
          BigInt? userId,
          BigInt? feedId,
          String? status,
          String? hash,
          String? title,
          String? url,
          DateTime? publishedAt,
          DateTime? createdAt,
          DateTime? changedAt,
          String? summary,
          String? content,
          String? author,
          bool? starred,
          int? readingTime}) =>
      EntryEntity(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        feedId: feedId ?? this.feedId,
        status: status ?? this.status,
        hash: hash ?? this.hash,
        title: title ?? this.title,
        url: url ?? this.url,
        publishedAt: publishedAt ?? this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        summary: summary ?? this.summary,
        content: content ?? this.content,
        author: author ?? this.author,
        starred: starred ?? this.starred,
        readingTime: readingTime ?? this.readingTime,
      );
  EntryEntity copyWithCompanion(EntriesTableCompanion data) {
    return EntryEntity(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      feedId: data.feedId.present ? data.feedId.value : this.feedId,
      status: data.status.present ? data.status.value : this.status,
      hash: data.hash.present ? data.hash.value : this.hash,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      summary: data.summary.present ? data.summary.value : this.summary,
      content: data.content.present ? data.content.value : this.content,
      author: data.author.present ? data.author.value : this.author,
      starred: data.starred.present ? data.starred.value : this.starred,
      readingTime:
          data.readingTime.present ? data.readingTime.value : this.readingTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryEntity(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedId: $feedId, ')
          ..write('status: $status, ')
          ..write('hash: $hash, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('starred: $starred, ')
          ..write('readingTime: $readingTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      feedId,
      status,
      hash,
      title,
      url,
      publishedAt,
      createdAt,
      changedAt,
      summary,
      content,
      author,
      starred,
      readingTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryEntity &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.feedId == this.feedId &&
          other.status == this.status &&
          other.hash == this.hash &&
          other.title == this.title &&
          other.url == this.url &&
          other.publishedAt == this.publishedAt &&
          other.createdAt == this.createdAt &&
          other.changedAt == this.changedAt &&
          other.summary == this.summary &&
          other.content == this.content &&
          other.author == this.author &&
          other.starred == this.starred &&
          other.readingTime == this.readingTime);
}

class EntriesTableCompanion extends UpdateCompanion<EntryEntity> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<BigInt> feedId;
  final Value<String> status;
  final Value<String> hash;
  final Value<String> title;
  final Value<String> url;
  final Value<DateTime> publishedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> changedAt;
  final Value<String> summary;
  final Value<String> content;
  final Value<String> author;
  final Value<bool> starred;
  final Value<int> readingTime;
  const EntriesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedId = const Value.absent(),
    this.status = const Value.absent(),
    this.hash = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.summary = const Value.absent(),
    this.content = const Value.absent(),
    this.author = const Value.absent(),
    this.starred = const Value.absent(),
    this.readingTime = const Value.absent(),
  });
  EntriesTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required BigInt feedId,
    this.status = const Value.absent(),
    required String hash,
    required String title,
    required String url,
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.summary = const Value.absent(),
    this.content = const Value.absent(),
    this.author = const Value.absent(),
    this.starred = const Value.absent(),
    this.readingTime = const Value.absent(),
  })  : userId = Value(userId),
        feedId = Value(feedId),
        hash = Value(hash),
        title = Value(title),
        url = Value(url);
  static Insertable<EntryEntity> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<BigInt>? feedId,
    Expression<String>? status,
    Expression<String>? hash,
    Expression<String>? title,
    Expression<String>? url,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? changedAt,
    Expression<String>? summary,
    Expression<String>? content,
    Expression<String>? author,
    Expression<bool>? starred,
    Expression<int>? readingTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (feedId != null) 'feed_id': feedId,
      if (status != null) 'status': status,
      if (hash != null) 'hash': hash,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (publishedAt != null) 'published_at': publishedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (changedAt != null) 'changed_at': changedAt,
      if (summary != null) 'summary': summary,
      if (content != null) 'content': content,
      if (author != null) 'author': author,
      if (starred != null) 'starred': starred,
      if (readingTime != null) 'reading_time': readingTime,
    });
  }

  EntriesTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<BigInt>? feedId,
      Value<String>? status,
      Value<String>? hash,
      Value<String>? title,
      Value<String>? url,
      Value<DateTime>? publishedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? changedAt,
      Value<String>? summary,
      Value<String>? content,
      Value<String>? author,
      Value<bool>? starred,
      Value<int>? readingTime}) {
    return EntriesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedId: feedId ?? this.feedId,
      status: status ?? this.status,
      hash: hash ?? this.hash,
      title: title ?? this.title,
      url: url ?? this.url,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      author: author ?? this.author,
      starred: starred ?? this.starred,
      readingTime: readingTime ?? this.readingTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<BigInt>(userId.value);
    }
    if (feedId.present) {
      map['feed_id'] = Variable<BigInt>(feedId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (starred.present) {
      map['starred'] = Variable<bool>(starred.value);
    }
    if (readingTime.present) {
      map['reading_time'] = Variable<int>(readingTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedId: $feedId, ')
          ..write('status: $status, ')
          ..write('hash: $hash, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('summary: $summary, ')
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('starred: $starred, ')
          ..write('readingTime: $readingTime')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
      'id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<BigInt> userId = GeneratedColumn<BigInt>(
      'user_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  static const VerificationMeta _hideGloballyMeta =
      const VerificationMeta('hideGlobally');
  @override
  late final GeneratedColumn<bool> hideGlobally = GeneratedColumn<bool>(
      'hide_globally', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("hide_globally" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _onlyShowUnreadMeta =
      const VerificationMeta('onlyShowUnread');
  @override
  late final GeneratedColumn<bool> onlyShowUnread = GeneratedColumn<bool>(
      'only_show_unread', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("only_show_unread" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _showReadingTimeMeta =
      const VerificationMeta('showReadingTime');
  @override
  late final GeneratedColumn<bool> showReadingTime = GeneratedColumn<bool>(
      'show_reading_time', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_reading_time" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _orderxMeta = const VerificationMeta('orderx');
  @override
  late final GeneratedColumn<String> orderx = GeneratedColumn<String>(
      'orderx', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant("published_at"));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        userId,
        hideGlobally,
        onlyShowUnread,
        showReadingTime,
        orderx
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('hide_globally')) {
      context.handle(
          _hideGloballyMeta,
          hideGlobally.isAcceptableOrUnknown(
              data['hide_globally']!, _hideGloballyMeta));
    }
    if (data.containsKey('only_show_unread')) {
      context.handle(
          _onlyShowUnreadMeta,
          onlyShowUnread.isAcceptableOrUnknown(
              data['only_show_unread']!, _onlyShowUnreadMeta));
    }
    if (data.containsKey('show_reading_time')) {
      context.handle(
          _showReadingTimeMeta,
          showReadingTime.isAcceptableOrUnknown(
              data['show_reading_time']!, _showReadingTimeMeta));
    }
    if (data.containsKey('orderx')) {
      context.handle(_orderxMeta,
          orderx.isAcceptableOrUnknown(data['orderx']!, _orderxMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
      hideGlobally: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hide_globally'])!,
      onlyShowUnread: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}only_show_unread'])!,
      showReadingTime: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_reading_time'])!,
      orderx: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orderx'])!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoryEntity extends DataClass implements Insertable<CategoryEntity> {
  final BigInt id;
  final String title;
  final BigInt userId;
  final bool hideGlobally;
  final bool onlyShowUnread;
  final bool showReadingTime;
  final String orderx;
  const CategoryEntity(
      {required this.id,
      required this.title,
      required this.userId,
      required this.hideGlobally,
      required this.onlyShowUnread,
      required this.showReadingTime,
      required this.orderx});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['title'] = Variable<String>(title);
    map['user_id'] = Variable<BigInt>(userId);
    map['hide_globally'] = Variable<bool>(hideGlobally);
    map['only_show_unread'] = Variable<bool>(onlyShowUnread);
    map['show_reading_time'] = Variable<bool>(showReadingTime);
    map['orderx'] = Variable<String>(orderx);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      title: Value(title),
      userId: Value(userId),
      hideGlobally: Value(hideGlobally),
      onlyShowUnread: Value(onlyShowUnread),
      showReadingTime: Value(showReadingTime),
      orderx: Value(orderx),
    );
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntity(
      id: serializer.fromJson<BigInt>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      hideGlobally: serializer.fromJson<bool>(json['hideGlobally']),
      onlyShowUnread: serializer.fromJson<bool>(json['onlyShowUnread']),
      showReadingTime: serializer.fromJson<bool>(json['showReadingTime']),
      orderx: serializer.fromJson<String>(json['orderx']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'title': serializer.toJson<String>(title),
      'userId': serializer.toJson<BigInt>(userId),
      'hideGlobally': serializer.toJson<bool>(hideGlobally),
      'onlyShowUnread': serializer.toJson<bool>(onlyShowUnread),
      'showReadingTime': serializer.toJson<bool>(showReadingTime),
      'orderx': serializer.toJson<String>(orderx),
    };
  }

  CategoryEntity copyWith(
          {BigInt? id,
          String? title,
          BigInt? userId,
          bool? hideGlobally,
          bool? onlyShowUnread,
          bool? showReadingTime,
          String? orderx}) =>
      CategoryEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        userId: userId ?? this.userId,
        hideGlobally: hideGlobally ?? this.hideGlobally,
        onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
        showReadingTime: showReadingTime ?? this.showReadingTime,
        orderx: orderx ?? this.orderx,
      );
  CategoryEntity copyWithCompanion(CategoriesTableCompanion data) {
    return CategoryEntity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      userId: data.userId.present ? data.userId.value : this.userId,
      hideGlobally: data.hideGlobally.present
          ? data.hideGlobally.value
          : this.hideGlobally,
      onlyShowUnread: data.onlyShowUnread.present
          ? data.onlyShowUnread.value
          : this.onlyShowUnread,
      showReadingTime: data.showReadingTime.present
          ? data.showReadingTime.value
          : this.showReadingTime,
      orderx: data.orderx.present ? data.orderx.value : this.orderx,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('userId: $userId, ')
          ..write('hideGlobally: $hideGlobally, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('showReadingTime: $showReadingTime, ')
          ..write('orderx: $orderx')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, userId, hideGlobally, onlyShowUnread, showReadingTime, orderx);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.userId == this.userId &&
          other.hideGlobally == this.hideGlobally &&
          other.onlyShowUnread == this.onlyShowUnread &&
          other.showReadingTime == this.showReadingTime &&
          other.orderx == this.orderx);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoryEntity> {
  final Value<BigInt> id;
  final Value<String> title;
  final Value<BigInt> userId;
  final Value<bool> hideGlobally;
  final Value<bool> onlyShowUnread;
  final Value<bool> showReadingTime;
  final Value<String> orderx;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.userId = const Value.absent(),
    this.hideGlobally = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.showReadingTime = const Value.absent(),
    this.orderx = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required BigInt userId,
    this.hideGlobally = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.showReadingTime = const Value.absent(),
    this.orderx = const Value.absent(),
  })  : title = Value(title),
        userId = Value(userId);
  static Insertable<CategoryEntity> custom({
    Expression<BigInt>? id,
    Expression<String>? title,
    Expression<BigInt>? userId,
    Expression<bool>? hideGlobally,
    Expression<bool>? onlyShowUnread,
    Expression<bool>? showReadingTime,
    Expression<String>? orderx,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (userId != null) 'user_id': userId,
      if (hideGlobally != null) 'hide_globally': hideGlobally,
      if (onlyShowUnread != null) 'only_show_unread': onlyShowUnread,
      if (showReadingTime != null) 'show_reading_time': showReadingTime,
      if (orderx != null) 'orderx': orderx,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<String>? title,
      Value<BigInt>? userId,
      Value<bool>? hideGlobally,
      Value<bool>? onlyShowUnread,
      Value<bool>? showReadingTime,
      Value<String>? orderx}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      showReadingTime: showReadingTime ?? this.showReadingTime,
      orderx: orderx ?? this.orderx,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<BigInt>(userId.value);
    }
    if (hideGlobally.present) {
      map['hide_globally'] = Variable<bool>(hideGlobally.value);
    }
    if (onlyShowUnread.present) {
      map['only_show_unread'] = Variable<bool>(onlyShowUnread.value);
    }
    if (showReadingTime.present) {
      map['show_reading_time'] = Variable<bool>(showReadingTime.value);
    }
    if (orderx.present) {
      map['orderx'] = Variable<String>(orderx.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('userId: $userId, ')
          ..write('hideGlobally: $hideGlobally, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('showReadingTime: $showReadingTime, ')
          ..write('orderx: $orderx')
          ..write(')'))
        .toString();
  }
}

class $ConfTableTable extends ConfTable
    with TableInfo<$ConfTableTable, ConfEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<BigInt> userId = GeneratedColumn<BigInt>(
      'user_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, value, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conf';
  @override
  VerificationContext validateIntegrity(Insertable<ConfEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $ConfTableTable createAlias(String alias) {
    return $ConfTableTable(attachedDatabase, alias);
  }
}

class ConfEntity extends DataClass implements Insertable<ConfEntity> {
  final int id;
  final String name;
  final String value;
  final BigInt userId;
  const ConfEntity(
      {required this.id,
      required this.name,
      required this.value,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    map['user_id'] = Variable<BigInt>(userId);
    return map;
  }

  ConfTableCompanion toCompanion(bool nullToAbsent) {
    return ConfTableCompanion(
      id: Value(id),
      name: Value(name),
      value: Value(value),
      userId: Value(userId),
    );
  }

  factory ConfEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
      userId: serializer.fromJson<BigInt>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
      'userId': serializer.toJson<BigInt>(userId),
    };
  }

  ConfEntity copyWith({int? id, String? name, String? value, BigInt? userId}) =>
      ConfEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        userId: userId ?? this.userId,
      );
  ConfEntity copyWithCompanion(ConfTableCompanion data) {
    return ConfEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      value: data.value.present ? data.value.value : this.value,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, value, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value &&
          other.userId == this.userId);
}

class ConfTableCompanion extends UpdateCompanion<ConfEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> value;
  final Value<BigInt> userId;
  const ConfTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.userId = const Value.absent(),
  });
  ConfTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    required BigInt userId,
  }) : userId = Value(userId);
  static Insertable<ConfEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? value,
    Expression<BigInt>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (userId != null) 'user_id': userId,
    });
  }

  ConfTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? value,
      Value<BigInt>? userId}) {
    return ConfTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<BigInt>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $SearchTableTable extends SearchTable
    with TableInfo<$SearchTableTable, SearchEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [id, word, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search';
  @override
  VerificationContext validateIntegrity(Insertable<SearchEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SearchTableTable createAlias(String alias) {
    return $SearchTableTable(attachedDatabase, alias);
  }
}

class SearchEntity extends DataClass implements Insertable<SearchEntity> {
  final int id;
  final String word;
  final DateTime createdAt;
  const SearchEntity(
      {required this.id, required this.word, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SearchTableCompanion toCompanion(bool nullToAbsent) {
    return SearchTableCompanion(
      id: Value(id),
      word: Value(word),
      createdAt: Value(createdAt),
    );
  }

  factory SearchEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchEntity(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SearchEntity copyWith({int? id, String? word, DateTime? createdAt}) =>
      SearchEntity(
        id: id ?? this.id,
        word: word ?? this.word,
        createdAt: createdAt ?? this.createdAt,
      );
  SearchEntity copyWithCompanion(SearchTableCompanion data) {
    return SearchEntity(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchEntity(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, word, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchEntity &&
          other.id == this.id &&
          other.word == this.word &&
          other.createdAt == this.createdAt);
}

class SearchTableCompanion extends UpdateCompanion<SearchEntity> {
  final Value<int> id;
  final Value<String> word;
  final Value<DateTime> createdAt;
  const SearchTableCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SearchTableCompanion.insert({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<SearchEntity> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SearchTableCompanion copyWith(
      {Value<int>? id, Value<String>? word, Value<DateTime>? createdAt}) {
    return SearchTableCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchTableCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ClustersTableTable extends ClustersTable
    with TableInfo<$ClustersTableTable, ClusterEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClustersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _feedIdsMeta =
      const VerificationMeta('feedIds');
  @override
  late final GeneratedColumn<String> feedIds = GeneratedColumn<String>(
      'feed_ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recentTimeMeta =
      const VerificationMeta('recentTime');
  @override
  late final GeneratedColumn<int> recentTime = GeneratedColumn<int>(
      'recent_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  static const VerificationMeta _deletedMeta =
      const VerificationMeta('deleted');
  @override
  late final GeneratedColumn<int> deleted = GeneratedColumn<int>(
      'deleted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _changedAtMeta =
      const VerificationMeta('changedAt');
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
      'changed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        icon,
        feedIds,
        recentTime,
        status,
        deleted,
        createdAt,
        changedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clusters';
  @override
  VerificationContext validateIntegrity(Insertable<ClusterEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('feed_ids')) {
      context.handle(_feedIdsMeta,
          feedIds.isAcceptableOrUnknown(data['feed_ids']!, _feedIdsMeta));
    } else if (isInserting) {
      context.missing(_feedIdsMeta);
    }
    if (data.containsKey('recent_time')) {
      context.handle(
          _recentTimeMeta,
          recentTime.isAcceptableOrUnknown(
              data['recent_time']!, _recentTimeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClusterEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClusterEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      feedIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feed_ids'])!,
      recentTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}recent_time'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
    );
  }

  @override
  $ClustersTableTable createAlias(String alias) {
    return $ClustersTableTable(attachedDatabase, alias);
  }
}

class ClusterEntity extends DataClass implements Insertable<ClusterEntity> {
  final int id;
  final String name;
  final String icon;
  final String feedIds;
  final int recentTime;
  final String status;
  final int deleted;
  final DateTime createdAt;
  final DateTime changedAt;
  const ClusterEntity(
      {required this.id,
      required this.name,
      required this.icon,
      required this.feedIds,
      required this.recentTime,
      required this.status,
      required this.deleted,
      required this.createdAt,
      required this.changedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['feed_ids'] = Variable<String>(feedIds);
    map['recent_time'] = Variable<int>(recentTime);
    map['status'] = Variable<String>(status);
    map['deleted'] = Variable<int>(deleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['changed_at'] = Variable<DateTime>(changedAt);
    return map;
  }

  ClustersTableCompanion toCompanion(bool nullToAbsent) {
    return ClustersTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      feedIds: Value(feedIds),
      recentTime: Value(recentTime),
      status: Value(status),
      deleted: Value(deleted),
      createdAt: Value(createdAt),
      changedAt: Value(changedAt),
    );
  }

  factory ClusterEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClusterEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      feedIds: serializer.fromJson<String>(json['feedIds']),
      recentTime: serializer.fromJson<int>(json['recentTime']),
      status: serializer.fromJson<String>(json['status']),
      deleted: serializer.fromJson<int>(json['deleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'feedIds': serializer.toJson<String>(feedIds),
      'recentTime': serializer.toJson<int>(recentTime),
      'status': serializer.toJson<String>(status),
      'deleted': serializer.toJson<int>(deleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changedAt': serializer.toJson<DateTime>(changedAt),
    };
  }

  ClusterEntity copyWith(
          {int? id,
          String? name,
          String? icon,
          String? feedIds,
          int? recentTime,
          String? status,
          int? deleted,
          DateTime? createdAt,
          DateTime? changedAt}) =>
      ClusterEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        feedIds: feedIds ?? this.feedIds,
        recentTime: recentTime ?? this.recentTime,
        status: status ?? this.status,
        deleted: deleted ?? this.deleted,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
      );
  ClusterEntity copyWithCompanion(ClustersTableCompanion data) {
    return ClusterEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      feedIds: data.feedIds.present ? data.feedIds.value : this.feedIds,
      recentTime:
          data.recentTime.present ? data.recentTime.value : this.recentTime,
      status: data.status.present ? data.status.value : this.status,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClusterEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('feedIds: $feedIds, ')
          ..write('recentTime: $recentTime, ')
          ..write('status: $status, ')
          ..write('deleted: $deleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, feedIds, recentTime, status,
      deleted, createdAt, changedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClusterEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.feedIds == this.feedIds &&
          other.recentTime == this.recentTime &&
          other.status == this.status &&
          other.deleted == this.deleted &&
          other.createdAt == this.createdAt &&
          other.changedAt == this.changedAt);
}

class ClustersTableCompanion extends UpdateCompanion<ClusterEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> feedIds;
  final Value<int> recentTime;
  final Value<String> status;
  final Value<int> deleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> changedAt;
  const ClustersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.feedIds = const Value.absent(),
    this.recentTime = const Value.absent(),
    this.status = const Value.absent(),
    this.deleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
  });
  ClustersTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    required String feedIds,
    this.recentTime = const Value.absent(),
    this.status = const Value.absent(),
    this.deleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
  })  : name = Value(name),
        icon = Value(icon),
        feedIds = Value(feedIds);
  static Insertable<ClusterEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? feedIds,
    Expression<int>? recentTime,
    Expression<String>? status,
    Expression<int>? deleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? changedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (feedIds != null) 'feed_ids': feedIds,
      if (recentTime != null) 'recent_time': recentTime,
      if (status != null) 'status': status,
      if (deleted != null) 'deleted': deleted,
      if (createdAt != null) 'created_at': createdAt,
      if (changedAt != null) 'changed_at': changedAt,
    });
  }

  ClustersTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? icon,
      Value<String>? feedIds,
      Value<int>? recentTime,
      Value<String>? status,
      Value<int>? deleted,
      Value<DateTime>? createdAt,
      Value<DateTime>? changedAt}) {
    return ClustersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      feedIds: feedIds ?? this.feedIds,
      recentTime: recentTime ?? this.recentTime,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (feedIds.present) {
      map['feed_ids'] = Variable<String>(feedIds.value);
    }
    if (recentTime.present) {
      map['recent_time'] = Variable<int>(recentTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<int>(deleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClustersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('feedIds: $feedIds, ')
          ..write('recentTime: $recentTime, ')
          ..write('status: $status, ')
          ..write('deleted: $deleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsTableTable feedsTable = $FeedsTableTable(this);
  late final $EntriesTableTable entriesTable = $EntriesTableTable(this);
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $ConfTableTable confTable = $ConfTableTable(this);
  late final $SearchTableTable searchTable = $SearchTableTable(this);
  late final $ClustersTableTable clustersTable = $ClustersTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        feedsTable,
        entriesTable,
        categoriesTable,
        confTable,
        searchTable,
        clustersTable
      ];
}

typedef $$FeedsTableTableCreateCompanionBuilder = FeedsTableCompanion Function({
  Value<BigInt> id,
  required BigInt userId,
  required String feedUrl,
  required String siteUrl,
  required String title,
  Value<int> unread,
  Value<int> read,
  Value<String> iconUrl,
  Value<bool> onlyShowUnread,
  Value<bool> showReadingTime,
  Value<int> errorCount,
  Value<String> errorMsg,
  Value<BigInt> categoryId,
  Value<String> orderx,
  Value<bool> hideGlobally,
});
typedef $$FeedsTableTableUpdateCompanionBuilder = FeedsTableCompanion Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<String> feedUrl,
  Value<String> siteUrl,
  Value<String> title,
  Value<int> unread,
  Value<int> read,
  Value<String> iconUrl,
  Value<bool> onlyShowUnread,
  Value<bool> showReadingTime,
  Value<int> errorCount,
  Value<String> errorMsg,
  Value<BigInt> categoryId,
  Value<String> orderx,
  Value<bool> hideGlobally,
});

class $$FeedsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FeedsTableTable> {
  $$FeedsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedUrl => $composableBuilder(
      column: $table.feedUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get siteUrl => $composableBuilder(
      column: $table.siteUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unread => $composableBuilder(
      column: $table.unread, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get read => $composableBuilder(
      column: $table.read, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showReadingTime => $composableBuilder(
      column: $table.showReadingTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get errorCount => $composableBuilder(
      column: $table.errorCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMsg => $composableBuilder(
      column: $table.errorMsg, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => ColumnFilters(column));
}

class $$FeedsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedsTableTable> {
  $$FeedsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedUrl => $composableBuilder(
      column: $table.feedUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get siteUrl => $composableBuilder(
      column: $table.siteUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unread => $composableBuilder(
      column: $table.unread, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get read => $composableBuilder(
      column: $table.read, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showReadingTime => $composableBuilder(
      column: $table.showReadingTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get errorCount => $composableBuilder(
      column: $table.errorCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMsg => $composableBuilder(
      column: $table.errorMsg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally,
      builder: (column) => ColumnOrderings(column));
}

class $$FeedsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedsTableTable> {
  $$FeedsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<BigInt> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get feedUrl =>
      $composableBuilder(column: $table.feedUrl, builder: (column) => column);

  GeneratedColumn<String> get siteUrl =>
      $composableBuilder(column: $table.siteUrl, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get unread =>
      $composableBuilder(column: $table.unread, builder: (column) => column);

  GeneratedColumn<int> get read =>
      $composableBuilder(column: $table.read, builder: (column) => column);

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread, builder: (column) => column);

  GeneratedColumn<bool> get showReadingTime => $composableBuilder(
      column: $table.showReadingTime, builder: (column) => column);

  GeneratedColumn<int> get errorCount => $composableBuilder(
      column: $table.errorCount, builder: (column) => column);

  GeneratedColumn<String> get errorMsg =>
      $composableBuilder(column: $table.errorMsg, builder: (column) => column);

  GeneratedColumn<BigInt> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get orderx =>
      $composableBuilder(column: $table.orderx, builder: (column) => column);

  GeneratedColumn<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => column);
}

class $$FeedsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedsTableTable,
    FeedEntity,
    $$FeedsTableTableFilterComposer,
    $$FeedsTableTableOrderingComposer,
    $$FeedsTableTableAnnotationComposer,
    $$FeedsTableTableCreateCompanionBuilder,
    $$FeedsTableTableUpdateCompanionBuilder,
    (FeedEntity, BaseReferences<_$AppDatabase, $FeedsTableTable, FeedEntity>),
    FeedEntity,
    PrefetchHooks Function()> {
  $$FeedsTableTableTableManager(_$AppDatabase db, $FeedsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
            Value<String> feedUrl = const Value.absent(),
            Value<String> siteUrl = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> unread = const Value.absent(),
            Value<int> read = const Value.absent(),
            Value<String> iconUrl = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<bool> showReadingTime = const Value.absent(),
            Value<int> errorCount = const Value.absent(),
            Value<String> errorMsg = const Value.absent(),
            Value<BigInt> categoryId = const Value.absent(),
            Value<String> orderx = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
          }) =>
              FeedsTableCompanion(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            unread: unread,
            read: read,
            iconUrl: iconUrl,
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
            errorCount: errorCount,
            errorMsg: errorMsg,
            categoryId: categoryId,
            orderx: orderx,
            hideGlobally: hideGlobally,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required String feedUrl,
            required String siteUrl,
            required String title,
            Value<int> unread = const Value.absent(),
            Value<int> read = const Value.absent(),
            Value<String> iconUrl = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<bool> showReadingTime = const Value.absent(),
            Value<int> errorCount = const Value.absent(),
            Value<String> errorMsg = const Value.absent(),
            Value<BigInt> categoryId = const Value.absent(),
            Value<String> orderx = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
          }) =>
              FeedsTableCompanion.insert(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            unread: unread,
            read: read,
            iconUrl: iconUrl,
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
            errorCount: errorCount,
            errorMsg: errorMsg,
            categoryId: categoryId,
            orderx: orderx,
            hideGlobally: hideGlobally,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FeedsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeedsTableTable,
    FeedEntity,
    $$FeedsTableTableFilterComposer,
    $$FeedsTableTableOrderingComposer,
    $$FeedsTableTableAnnotationComposer,
    $$FeedsTableTableCreateCompanionBuilder,
    $$FeedsTableTableUpdateCompanionBuilder,
    (FeedEntity, BaseReferences<_$AppDatabase, $FeedsTableTable, FeedEntity>),
    FeedEntity,
    PrefetchHooks Function()>;
typedef $$EntriesTableTableCreateCompanionBuilder = EntriesTableCompanion
    Function({
  Value<BigInt> id,
  required BigInt userId,
  required BigInt feedId,
  Value<String> status,
  required String hash,
  required String title,
  required String url,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
  Value<String> summary,
  Value<String> content,
  Value<String> author,
  Value<bool> starred,
  Value<int> readingTime,
});
typedef $$EntriesTableTableUpdateCompanionBuilder = EntriesTableCompanion
    Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<BigInt> feedId,
  Value<String> status,
  Value<String> hash,
  Value<String> title,
  Value<String> url,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
  Value<String> summary,
  Value<String> content,
  Value<String> author,
  Value<bool> starred,
  Value<int> readingTime,
});

class $$EntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EntriesTableTable> {
  $$EntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get feedId => $composableBuilder(
      column: $table.feedId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hash => $composableBuilder(
      column: $table.hash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get starred => $composableBuilder(
      column: $table.starred, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get readingTime => $composableBuilder(
      column: $table.readingTime, builder: (column) => ColumnFilters(column));
}

class $$EntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EntriesTableTable> {
  $$EntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get feedId => $composableBuilder(
      column: $table.feedId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hash => $composableBuilder(
      column: $table.hash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get starred => $composableBuilder(
      column: $table.starred, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get readingTime => $composableBuilder(
      column: $table.readingTime, builder: (column) => ColumnOrderings(column));
}

class $$EntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntriesTableTable> {
  $$EntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<BigInt> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<BigInt> get feedId =>
      $composableBuilder(column: $table.feedId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<bool> get starred =>
      $composableBuilder(column: $table.starred, builder: (column) => column);

  GeneratedColumn<int> get readingTime => $composableBuilder(
      column: $table.readingTime, builder: (column) => column);
}

class $$EntriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntriesTableTable,
    EntryEntity,
    $$EntriesTableTableFilterComposer,
    $$EntriesTableTableOrderingComposer,
    $$EntriesTableTableAnnotationComposer,
    $$EntriesTableTableCreateCompanionBuilder,
    $$EntriesTableTableUpdateCompanionBuilder,
    (
      EntryEntity,
      BaseReferences<_$AppDatabase, $EntriesTableTable, EntryEntity>
    ),
    EntryEntity,
    PrefetchHooks Function()> {
  $$EntriesTableTableTableManager(_$AppDatabase db, $EntriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
            Value<BigInt> feedId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> hash = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<int> readingTime = const Value.absent(),
          }) =>
              EntriesTableCompanion(
            id: id,
            userId: userId,
            feedId: feedId,
            status: status,
            hash: hash,
            title: title,
            url: url,
            publishedAt: publishedAt,
            createdAt: createdAt,
            changedAt: changedAt,
            summary: summary,
            content: content,
            author: author,
            starred: starred,
            readingTime: readingTime,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required BigInt feedId,
            Value<String> status = const Value.absent(),
            required String hash,
            required String title,
            required String url,
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<int> readingTime = const Value.absent(),
          }) =>
              EntriesTableCompanion.insert(
            id: id,
            userId: userId,
            feedId: feedId,
            status: status,
            hash: hash,
            title: title,
            url: url,
            publishedAt: publishedAt,
            createdAt: createdAt,
            changedAt: changedAt,
            summary: summary,
            content: content,
            author: author,
            starred: starred,
            readingTime: readingTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EntriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntriesTableTable,
    EntryEntity,
    $$EntriesTableTableFilterComposer,
    $$EntriesTableTableOrderingComposer,
    $$EntriesTableTableAnnotationComposer,
    $$EntriesTableTableCreateCompanionBuilder,
    $$EntriesTableTableUpdateCompanionBuilder,
    (
      EntryEntity,
      BaseReferences<_$AppDatabase, $EntriesTableTable, EntryEntity>
    ),
    EntryEntity,
    PrefetchHooks Function()>;
typedef $$CategoriesTableTableCreateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<BigInt> id,
  required String title,
  required BigInt userId,
  Value<bool> hideGlobally,
  Value<bool> onlyShowUnread,
  Value<bool> showReadingTime,
  Value<String> orderx,
});
typedef $$CategoriesTableTableUpdateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<BigInt> id,
  Value<String> title,
  Value<BigInt> userId,
  Value<bool> hideGlobally,
  Value<bool> onlyShowUnread,
  Value<bool> showReadingTime,
  Value<String> orderx,
});

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showReadingTime => $composableBuilder(
      column: $table.showReadingTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showReadingTime => $composableBuilder(
      column: $table.showReadingTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<BigInt> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => column);

  GeneratedColumn<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread, builder: (column) => column);

  GeneratedColumn<bool> get showReadingTime => $composableBuilder(
      column: $table.showReadingTime, builder: (column) => column);

  GeneratedColumn<String> get orderx =>
      $composableBuilder(column: $table.orderx, builder: (column) => column);
}

class $$CategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoryEntity,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (
      CategoryEntity,
      BaseReferences<_$AppDatabase, $CategoriesTableTable, CategoryEntity>
    ),
    CategoryEntity,
    PrefetchHooks Function()> {
  $$CategoriesTableTableTableManager(
      _$AppDatabase db, $CategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<bool> showReadingTime = const Value.absent(),
            Value<String> orderx = const Value.absent(),
          }) =>
              CategoriesTableCompanion(
            id: id,
            title: title,
            userId: userId,
            hideGlobally: hideGlobally,
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
            orderx: orderx,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required String title,
            required BigInt userId,
            Value<bool> hideGlobally = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<bool> showReadingTime = const Value.absent(),
            Value<String> orderx = const Value.absent(),
          }) =>
              CategoriesTableCompanion.insert(
            id: id,
            title: title,
            userId: userId,
            hideGlobally: hideGlobally,
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
            orderx: orderx,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoryEntity,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (
      CategoryEntity,
      BaseReferences<_$AppDatabase, $CategoriesTableTable, CategoryEntity>
    ),
    CategoryEntity,
    PrefetchHooks Function()>;
typedef $$ConfTableTableCreateCompanionBuilder = ConfTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> value,
  required BigInt userId,
});
typedef $$ConfTableTableUpdateCompanionBuilder = ConfTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> value,
  Value<BigInt> userId,
});

class $$ConfTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConfTableTable> {
  $$ConfTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$ConfTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfTableTable> {
  $$ConfTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$ConfTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfTableTable> {
  $$ConfTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<BigInt> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$ConfTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConfTableTable,
    ConfEntity,
    $$ConfTableTableFilterComposer,
    $$ConfTableTableOrderingComposer,
    $$ConfTableTableAnnotationComposer,
    $$ConfTableTableCreateCompanionBuilder,
    $$ConfTableTableUpdateCompanionBuilder,
    (ConfEntity, BaseReferences<_$AppDatabase, $ConfTableTable, ConfEntity>),
    ConfEntity,
    PrefetchHooks Function()> {
  $$ConfTableTableTableManager(_$AppDatabase db, $ConfTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
          }) =>
              ConfTableCompanion(
            id: id,
            name: name,
            value: value,
            userId: userId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> value = const Value.absent(),
            required BigInt userId,
          }) =>
              ConfTableCompanion.insert(
            id: id,
            name: name,
            value: value,
            userId: userId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConfTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConfTableTable,
    ConfEntity,
    $$ConfTableTableFilterComposer,
    $$ConfTableTableOrderingComposer,
    $$ConfTableTableAnnotationComposer,
    $$ConfTableTableCreateCompanionBuilder,
    $$ConfTableTableUpdateCompanionBuilder,
    (ConfEntity, BaseReferences<_$AppDatabase, $ConfTableTable, ConfEntity>),
    ConfEntity,
    PrefetchHooks Function()>;
typedef $$SearchTableTableCreateCompanionBuilder = SearchTableCompanion
    Function({
  Value<int> id,
  Value<String> word,
  Value<DateTime> createdAt,
});
typedef $$SearchTableTableUpdateCompanionBuilder = SearchTableCompanion
    Function({
  Value<int> id,
  Value<String> word,
  Value<DateTime> createdAt,
});

class $$SearchTableTableFilterComposer
    extends Composer<_$AppDatabase, $SearchTableTable> {
  $$SearchTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SearchTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchTableTable> {
  $$SearchTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SearchTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchTableTable> {
  $$SearchTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SearchTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SearchTableTable,
    SearchEntity,
    $$SearchTableTableFilterComposer,
    $$SearchTableTableOrderingComposer,
    $$SearchTableTableAnnotationComposer,
    $$SearchTableTableCreateCompanionBuilder,
    $$SearchTableTableUpdateCompanionBuilder,
    (
      SearchEntity,
      BaseReferences<_$AppDatabase, $SearchTableTable, SearchEntity>
    ),
    SearchEntity,
    PrefetchHooks Function()> {
  $$SearchTableTableTableManager(_$AppDatabase db, $SearchTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SearchTableCompanion(
            id: id,
            word: word,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SearchTableCompanion.insert(
            id: id,
            word: word,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SearchTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SearchTableTable,
    SearchEntity,
    $$SearchTableTableFilterComposer,
    $$SearchTableTableOrderingComposer,
    $$SearchTableTableAnnotationComposer,
    $$SearchTableTableCreateCompanionBuilder,
    $$SearchTableTableUpdateCompanionBuilder,
    (
      SearchEntity,
      BaseReferences<_$AppDatabase, $SearchTableTable, SearchEntity>
    ),
    SearchEntity,
    PrefetchHooks Function()>;
typedef $$ClustersTableTableCreateCompanionBuilder = ClustersTableCompanion
    Function({
  Value<int> id,
  required String name,
  required String icon,
  required String feedIds,
  Value<int> recentTime,
  Value<String> status,
  Value<int> deleted,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
});
typedef $$ClustersTableTableUpdateCompanionBuilder = ClustersTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> icon,
  Value<String> feedIds,
  Value<int> recentTime,
  Value<String> status,
  Value<int> deleted,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
});

class $$ClustersTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClustersTableTable> {
  $$ClustersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedIds => $composableBuilder(
      column: $table.feedIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recentTime => $composableBuilder(
      column: $table.recentTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));
}

class $$ClustersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClustersTableTable> {
  $$ClustersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedIds => $composableBuilder(
      column: $table.feedIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recentTime => $composableBuilder(
      column: $table.recentTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));
}

class $$ClustersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClustersTableTable> {
  $$ClustersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get feedIds =>
      $composableBuilder(column: $table.feedIds, builder: (column) => column);

  GeneratedColumn<int> get recentTime => $composableBuilder(
      column: $table.recentTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $$ClustersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClustersTableTable,
    ClusterEntity,
    $$ClustersTableTableFilterComposer,
    $$ClustersTableTableOrderingComposer,
    $$ClustersTableTableAnnotationComposer,
    $$ClustersTableTableCreateCompanionBuilder,
    $$ClustersTableTableUpdateCompanionBuilder,
    (
      ClusterEntity,
      BaseReferences<_$AppDatabase, $ClustersTableTable, ClusterEntity>
    ),
    ClusterEntity,
    PrefetchHooks Function()> {
  $$ClustersTableTableTableManager(_$AppDatabase db, $ClustersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClustersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClustersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClustersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> feedIds = const Value.absent(),
            Value<int> recentTime = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> deleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              ClustersTableCompanion(
            id: id,
            name: name,
            icon: icon,
            feedIds: feedIds,
            recentTime: recentTime,
            status: status,
            deleted: deleted,
            createdAt: createdAt,
            changedAt: changedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String icon,
            required String feedIds,
            Value<int> recentTime = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> deleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              ClustersTableCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            feedIds: feedIds,
            recentTime: recentTime,
            status: status,
            deleted: deleted,
            createdAt: createdAt,
            changedAt: changedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClustersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClustersTableTable,
    ClusterEntity,
    $$ClustersTableTableFilterComposer,
    $$ClustersTableTableOrderingComposer,
    $$ClustersTableTableAnnotationComposer,
    $$ClustersTableTableCreateCompanionBuilder,
    $$ClustersTableTableUpdateCompanionBuilder,
    (
      ClusterEntity,
      BaseReferences<_$AppDatabase, $ClustersTableTable, ClusterEntity>
    ),
    ClusterEntity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsTableTableTableManager get feedsTable =>
      $$FeedsTableTableTableManager(_db, _db.feedsTable);
  $$EntriesTableTableTableManager get entriesTable =>
      $$EntriesTableTableTableManager(_db, _db.entriesTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$ConfTableTableTableManager get confTable =>
      $$ConfTableTableTableManager(_db, _db.confTable);
  $$SearchTableTableTableManager get searchTable =>
      $$SearchTableTableTableManager(_db, _db.searchTable);
  $$ClustersTableTableTableManager get clustersTable =>
      $$ClustersTableTableTableManager(_db, _db.clustersTable);
}
