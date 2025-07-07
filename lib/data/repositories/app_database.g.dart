// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FeedsTableTable extends FeedsTable
    with TableInfo<$FeedsTableTable, FeedRow> {
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
  static const VerificationMeta _iconUrlMeta =
      const VerificationMeta('iconUrl');
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
      'icon_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
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
  static const VerificationMeta _folderIdMeta =
      const VerificationMeta('folderId');
  @override
  late final GeneratedColumn<BigInt> folderId = GeneratedColumn<BigInt>(
      'folder_id', aliasedName, false,
      type: DriftSqlType.bigInt,
      requiredDuringInsert: false,
      defaultValue: Constant(BigInt.zero));
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
  static const VerificationMeta _deletedMeta =
      const VerificationMeta('deleted');
  @override
  late final GeneratedColumn<int> deleted = GeneratedColumn<int>(
      'deleted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        feedUrl,
        siteUrl,
        title,
        iconUrl,
        errorCount,
        errorMsg,
        folderId,
        onlyShowUnread,
        orderx,
        hideGlobally,
        deleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeds';
  @override
  VerificationContext validateIntegrity(Insertable<FeedRow> instance,
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
    if (data.containsKey('icon_url')) {
      context.handle(_iconUrlMeta,
          iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta));
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
    if (data.containsKey('folder_id')) {
      context.handle(_folderIdMeta,
          folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta));
    }
    if (data.containsKey('only_show_unread')) {
      context.handle(
          _onlyShowUnreadMeta,
          onlyShowUnread.isAcceptableOrUnknown(
              data['only_show_unread']!, _onlyShowUnreadMeta));
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
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta,
          deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedRow(
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
      iconUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_url'])!,
      errorCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}error_count'])!,
      errorMsg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_msg'])!,
      folderId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}folder_id'])!,
      onlyShowUnread: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}only_show_unread'])!,
      orderx: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orderx'])!,
      hideGlobally: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hide_globally'])!,
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted'])!,
    );
  }

  @override
  $FeedsTableTable createAlias(String alias) {
    return $FeedsTableTable(attachedDatabase, alias);
  }
}

class FeedRow extends DataClass implements Insertable<FeedRow> {
  final BigInt id;
  final BigInt userId;
  final String feedUrl;
  final String siteUrl;
  final String title;
  final String iconUrl;
  final int errorCount;
  final String errorMsg;
  final BigInt folderId;
  final bool onlyShowUnread;
  final String orderx;
  final bool hideGlobally;
  final int deleted;
  const FeedRow(
      {required this.id,
      required this.userId,
      required this.feedUrl,
      required this.siteUrl,
      required this.title,
      required this.iconUrl,
      required this.errorCount,
      required this.errorMsg,
      required this.folderId,
      required this.onlyShowUnread,
      required this.orderx,
      required this.hideGlobally,
      required this.deleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['user_id'] = Variable<BigInt>(userId);
    map['feed_url'] = Variable<String>(feedUrl);
    map['site_url'] = Variable<String>(siteUrl);
    map['title'] = Variable<String>(title);
    map['icon_url'] = Variable<String>(iconUrl);
    map['error_count'] = Variable<int>(errorCount);
    map['error_msg'] = Variable<String>(errorMsg);
    map['folder_id'] = Variable<BigInt>(folderId);
    map['only_show_unread'] = Variable<bool>(onlyShowUnread);
    map['orderx'] = Variable<String>(orderx);
    map['hide_globally'] = Variable<bool>(hideGlobally);
    map['deleted'] = Variable<int>(deleted);
    return map;
  }

  FeedsTableCompanion toCompanion(bool nullToAbsent) {
    return FeedsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      feedUrl: Value(feedUrl),
      siteUrl: Value(siteUrl),
      title: Value(title),
      iconUrl: Value(iconUrl),
      errorCount: Value(errorCount),
      errorMsg: Value(errorMsg),
      folderId: Value(folderId),
      onlyShowUnread: Value(onlyShowUnread),
      orderx: Value(orderx),
      hideGlobally: Value(hideGlobally),
      deleted: Value(deleted),
    );
  }

  factory FeedRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedRow(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      feedUrl: serializer.fromJson<String>(json['feedUrl']),
      siteUrl: serializer.fromJson<String>(json['siteUrl']),
      title: serializer.fromJson<String>(json['title']),
      iconUrl: serializer.fromJson<String>(json['iconUrl']),
      errorCount: serializer.fromJson<int>(json['errorCount']),
      errorMsg: serializer.fromJson<String>(json['errorMsg']),
      folderId: serializer.fromJson<BigInt>(json['folderId']),
      onlyShowUnread: serializer.fromJson<bool>(json['onlyShowUnread']),
      orderx: serializer.fromJson<String>(json['orderx']),
      hideGlobally: serializer.fromJson<bool>(json['hideGlobally']),
      deleted: serializer.fromJson<int>(json['deleted']),
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
      'iconUrl': serializer.toJson<String>(iconUrl),
      'errorCount': serializer.toJson<int>(errorCount),
      'errorMsg': serializer.toJson<String>(errorMsg),
      'folderId': serializer.toJson<BigInt>(folderId),
      'onlyShowUnread': serializer.toJson<bool>(onlyShowUnread),
      'orderx': serializer.toJson<String>(orderx),
      'hideGlobally': serializer.toJson<bool>(hideGlobally),
      'deleted': serializer.toJson<int>(deleted),
    };
  }

  FeedRow copyWith(
          {BigInt? id,
          BigInt? userId,
          String? feedUrl,
          String? siteUrl,
          String? title,
          String? iconUrl,
          int? errorCount,
          String? errorMsg,
          BigInt? folderId,
          bool? onlyShowUnread,
          String? orderx,
          bool? hideGlobally,
          int? deleted}) =>
      FeedRow(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        feedUrl: feedUrl ?? this.feedUrl,
        siteUrl: siteUrl ?? this.siteUrl,
        title: title ?? this.title,
        iconUrl: iconUrl ?? this.iconUrl,
        errorCount: errorCount ?? this.errorCount,
        errorMsg: errorMsg ?? this.errorMsg,
        folderId: folderId ?? this.folderId,
        onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
        orderx: orderx ?? this.orderx,
        hideGlobally: hideGlobally ?? this.hideGlobally,
        deleted: deleted ?? this.deleted,
      );
  FeedRow copyWithCompanion(FeedsTableCompanion data) {
    return FeedRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      feedUrl: data.feedUrl.present ? data.feedUrl.value : this.feedUrl,
      siteUrl: data.siteUrl.present ? data.siteUrl.value : this.siteUrl,
      title: data.title.present ? data.title.value : this.title,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      errorCount:
          data.errorCount.present ? data.errorCount.value : this.errorCount,
      errorMsg: data.errorMsg.present ? data.errorMsg.value : this.errorMsg,
      folderId: data.folderId.present ? data.folderId.value : this.folderId,
      onlyShowUnread: data.onlyShowUnread.present
          ? data.onlyShowUnread.value
          : this.onlyShowUnread,
      orderx: data.orderx.present ? data.orderx.value : this.orderx,
      hideGlobally: data.hideGlobally.present
          ? data.hideGlobally.value
          : this.hideGlobally,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedUrl: $feedUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('title: $title, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('errorCount: $errorCount, ')
          ..write('errorMsg: $errorMsg, ')
          ..write('folderId: $folderId, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('orderx: $orderx, ')
          ..write('hideGlobally: $hideGlobally, ')
          ..write('deleted: $deleted')
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
      iconUrl,
      errorCount,
      errorMsg,
      folderId,
      onlyShowUnread,
      orderx,
      hideGlobally,
      deleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.feedUrl == this.feedUrl &&
          other.siteUrl == this.siteUrl &&
          other.title == this.title &&
          other.iconUrl == this.iconUrl &&
          other.errorCount == this.errorCount &&
          other.errorMsg == this.errorMsg &&
          other.folderId == this.folderId &&
          other.onlyShowUnread == this.onlyShowUnread &&
          other.orderx == this.orderx &&
          other.hideGlobally == this.hideGlobally &&
          other.deleted == this.deleted);
}

class FeedsTableCompanion extends UpdateCompanion<FeedRow> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<String> feedUrl;
  final Value<String> siteUrl;
  final Value<String> title;
  final Value<String> iconUrl;
  final Value<int> errorCount;
  final Value<String> errorMsg;
  final Value<BigInt> folderId;
  final Value<bool> onlyShowUnread;
  final Value<String> orderx;
  final Value<bool> hideGlobally;
  final Value<int> deleted;
  const FeedsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.errorMsg = const Value.absent(),
    this.folderId = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.orderx = const Value.absent(),
    this.hideGlobally = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  FeedsTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required String feedUrl,
    required String siteUrl,
    required String title,
    this.iconUrl = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.errorMsg = const Value.absent(),
    this.folderId = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.orderx = const Value.absent(),
    this.hideGlobally = const Value.absent(),
    this.deleted = const Value.absent(),
  })  : userId = Value(userId),
        feedUrl = Value(feedUrl),
        siteUrl = Value(siteUrl),
        title = Value(title);
  static Insertable<FeedRow> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<String>? feedUrl,
    Expression<String>? siteUrl,
    Expression<String>? title,
    Expression<String>? iconUrl,
    Expression<int>? errorCount,
    Expression<String>? errorMsg,
    Expression<BigInt>? folderId,
    Expression<bool>? onlyShowUnread,
    Expression<String>? orderx,
    Expression<bool>? hideGlobally,
    Expression<int>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (feedUrl != null) 'feed_url': feedUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (title != null) 'title': title,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (errorCount != null) 'error_count': errorCount,
      if (errorMsg != null) 'error_msg': errorMsg,
      if (folderId != null) 'folder_id': folderId,
      if (onlyShowUnread != null) 'only_show_unread': onlyShowUnread,
      if (orderx != null) 'orderx': orderx,
      if (hideGlobally != null) 'hide_globally': hideGlobally,
      if (deleted != null) 'deleted': deleted,
    });
  }

  FeedsTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<String>? feedUrl,
      Value<String>? siteUrl,
      Value<String>? title,
      Value<String>? iconUrl,
      Value<int>? errorCount,
      Value<String>? errorMsg,
      Value<BigInt>? folderId,
      Value<bool>? onlyShowUnread,
      Value<String>? orderx,
      Value<bool>? hideGlobally,
      Value<int>? deleted}) {
    return FeedsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      iconUrl: iconUrl ?? this.iconUrl,
      errorCount: errorCount ?? this.errorCount,
      errorMsg: errorMsg ?? this.errorMsg,
      folderId: folderId ?? this.folderId,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      orderx: orderx ?? this.orderx,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      deleted: deleted ?? this.deleted,
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
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (errorCount.present) {
      map['error_count'] = Variable<int>(errorCount.value);
    }
    if (errorMsg.present) {
      map['error_msg'] = Variable<String>(errorMsg.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<BigInt>(folderId.value);
    }
    if (onlyShowUnread.present) {
      map['only_show_unread'] = Variable<bool>(onlyShowUnread.value);
    }
    if (orderx.present) {
      map['orderx'] = Variable<String>(orderx.value);
    }
    if (hideGlobally.present) {
      map['hide_globally'] = Variable<bool>(hideGlobally.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<int>(deleted.value);
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
          ..write('iconUrl: $iconUrl, ')
          ..write('errorCount: $errorCount, ')
          ..write('errorMsg: $errorMsg, ')
          ..write('folderId: $folderId, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('orderx: $orderx, ')
          ..write('hideGlobally: $hideGlobally, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $SyncRecordsTableTable extends SyncRecordsTable
    with TableInfo<$SyncRecordsTableTable, SyncRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncRecordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.bigInt,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _errorMsgMeta =
      const VerificationMeta('errorMsg');
  @override
  late final GeneratedColumn<String> errorMsg = GeneratedColumn<String>(
      'errorMsg', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'startTime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'endTime', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _entryMeta = const VerificationMeta('entry');
  @override
  late final GeneratedColumn<int> entry = GeneratedColumn<int>(
      'entry', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _feedMeta = const VerificationMeta('feed');
  @override
  late final GeneratedColumn<int> feed = GeneratedColumn<int>(
      'feed', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<int> folder = GeneratedColumn<int>(
      'folder', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, status, time, errorMsg, startTime, endTime, entry, feed, folder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_records';
  @override
  VerificationContext validateIntegrity(Insertable<SyncRecordRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('errorMsg')) {
      context.handle(_errorMsgMeta,
          errorMsg.isAcceptableOrUnknown(data['errorMsg']!, _errorMsgMeta));
    } else if (isInserting) {
      context.missing(_errorMsgMeta);
    }
    if (data.containsKey('startTime')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['startTime']!, _startTimeMeta));
    }
    if (data.containsKey('endTime')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['endTime']!, _endTimeMeta));
    }
    if (data.containsKey('entry')) {
      context.handle(
          _entryMeta, entry.isAcceptableOrUnknown(data['entry']!, _entryMeta));
    } else if (isInserting) {
      context.missing(_entryMeta);
    }
    if (data.containsKey('feed')) {
      context.handle(
          _feedMeta, feed.isAcceptableOrUnknown(data['feed']!, _feedMeta));
    } else if (isInserting) {
      context.missing(_feedMeta);
    }
    if (data.containsKey('folder')) {
      context.handle(_folderMeta,
          folder.isAcceptableOrUnknown(data['folder']!, _folderMeta));
    } else if (isInserting) {
      context.missing(_folderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncRecordRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
      errorMsg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}errorMsg'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}startTime'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}endTime'])!,
      entry: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entry'])!,
      feed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}feed'])!,
      folder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}folder'])!,
    );
  }

  @override
  $SyncRecordsTableTable createAlias(String alias) {
    return $SyncRecordsTableTable(attachedDatabase, alias);
  }
}

class SyncRecordRow extends DataClass implements Insertable<SyncRecordRow> {
  final BigInt id;
  final String status;
  final DateTime time;
  final String errorMsg;
  final DateTime startTime;
  final DateTime endTime;
  final int entry;
  final int feed;
  final int folder;
  const SyncRecordRow(
      {required this.id,
      required this.status,
      required this.time,
      required this.errorMsg,
      required this.startTime,
      required this.endTime,
      required this.entry,
      required this.feed,
      required this.folder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['status'] = Variable<String>(status);
    map['time'] = Variable<DateTime>(time);
    map['errorMsg'] = Variable<String>(errorMsg);
    map['startTime'] = Variable<DateTime>(startTime);
    map['endTime'] = Variable<DateTime>(endTime);
    map['entry'] = Variable<int>(entry);
    map['feed'] = Variable<int>(feed);
    map['folder'] = Variable<int>(folder);
    return map;
  }

  SyncRecordsTableCompanion toCompanion(bool nullToAbsent) {
    return SyncRecordsTableCompanion(
      id: Value(id),
      status: Value(status),
      time: Value(time),
      errorMsg: Value(errorMsg),
      startTime: Value(startTime),
      endTime: Value(endTime),
      entry: Value(entry),
      feed: Value(feed),
      folder: Value(folder),
    );
  }

  factory SyncRecordRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncRecordRow(
      id: serializer.fromJson<BigInt>(json['id']),
      status: serializer.fromJson<String>(json['status']),
      time: serializer.fromJson<DateTime>(json['time']),
      errorMsg: serializer.fromJson<String>(json['errorMsg']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      entry: serializer.fromJson<int>(json['entry']),
      feed: serializer.fromJson<int>(json['feed']),
      folder: serializer.fromJson<int>(json['folder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'status': serializer.toJson<String>(status),
      'time': serializer.toJson<DateTime>(time),
      'errorMsg': serializer.toJson<String>(errorMsg),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'entry': serializer.toJson<int>(entry),
      'feed': serializer.toJson<int>(feed),
      'folder': serializer.toJson<int>(folder),
    };
  }

  SyncRecordRow copyWith(
          {BigInt? id,
          String? status,
          DateTime? time,
          String? errorMsg,
          DateTime? startTime,
          DateTime? endTime,
          int? entry,
          int? feed,
          int? folder}) =>
      SyncRecordRow(
        id: id ?? this.id,
        status: status ?? this.status,
        time: time ?? this.time,
        errorMsg: errorMsg ?? this.errorMsg,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        entry: entry ?? this.entry,
        feed: feed ?? this.feed,
        folder: folder ?? this.folder,
      );
  SyncRecordRow copyWithCompanion(SyncRecordsTableCompanion data) {
    return SyncRecordRow(
      id: data.id.present ? data.id.value : this.id,
      status: data.status.present ? data.status.value : this.status,
      time: data.time.present ? data.time.value : this.time,
      errorMsg: data.errorMsg.present ? data.errorMsg.value : this.errorMsg,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      entry: data.entry.present ? data.entry.value : this.entry,
      feed: data.feed.present ? data.feed.value : this.feed,
      folder: data.folder.present ? data.folder.value : this.folder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncRecordRow(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('time: $time, ')
          ..write('errorMsg: $errorMsg, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('entry: $entry, ')
          ..write('feed: $feed, ')
          ..write('folder: $folder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, status, time, errorMsg, startTime, endTime, entry, feed, folder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncRecordRow &&
          other.id == this.id &&
          other.status == this.status &&
          other.time == this.time &&
          other.errorMsg == this.errorMsg &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.entry == this.entry &&
          other.feed == this.feed &&
          other.folder == this.folder);
}

class SyncRecordsTableCompanion extends UpdateCompanion<SyncRecordRow> {
  final Value<BigInt> id;
  final Value<String> status;
  final Value<DateTime> time;
  final Value<String> errorMsg;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> entry;
  final Value<int> feed;
  final Value<int> folder;
  const SyncRecordsTableCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.time = const Value.absent(),
    this.errorMsg = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.entry = const Value.absent(),
    this.feed = const Value.absent(),
    this.folder = const Value.absent(),
  });
  SyncRecordsTableCompanion.insert({
    this.id = const Value.absent(),
    required String status,
    this.time = const Value.absent(),
    required String errorMsg,
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    required int entry,
    required int feed,
    required int folder,
  })  : status = Value(status),
        errorMsg = Value(errorMsg),
        entry = Value(entry),
        feed = Value(feed),
        folder = Value(folder);
  static Insertable<SyncRecordRow> custom({
    Expression<BigInt>? id,
    Expression<String>? status,
    Expression<DateTime>? time,
    Expression<String>? errorMsg,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? entry,
    Expression<int>? feed,
    Expression<int>? folder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (time != null) 'time': time,
      if (errorMsg != null) 'errorMsg': errorMsg,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (entry != null) 'entry': entry,
      if (feed != null) 'feed': feed,
      if (folder != null) 'folder': folder,
    });
  }

  SyncRecordsTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<String>? status,
      Value<DateTime>? time,
      Value<String>? errorMsg,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<int>? entry,
      Value<int>? feed,
      Value<int>? folder}) {
    return SyncRecordsTableCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      time: time ?? this.time,
      errorMsg: errorMsg ?? this.errorMsg,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      entry: entry ?? this.entry,
      feed: feed ?? this.feed,
      folder: folder ?? this.folder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (errorMsg.present) {
      map['errorMsg'] = Variable<String>(errorMsg.value);
    }
    if (startTime.present) {
      map['startTime'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['endTime'] = Variable<DateTime>(endTime.value);
    }
    if (entry.present) {
      map['entry'] = Variable<int>(entry.value);
    }
    if (feed.present) {
      map['feed'] = Variable<int>(feed.value);
    }
    if (folder.present) {
      map['folder'] = Variable<int>(folder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncRecordsTableCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('time: $time, ')
          ..write('errorMsg: $errorMsg, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('entry: $entry, ')
          ..write('feed: $feed, ')
          ..write('folder: $folder')
          ..write(')'))
        .toString();
  }
}

class $FoldersTableTable extends FoldersTable
    with TableInfo<$FoldersTableTable, FolderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [id, userId, title, hideGlobally];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<FolderRow> instance,
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
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
  FolderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FolderRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      hideGlobally: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hide_globally'])!,
    );
  }

  @override
  $FoldersTableTable createAlias(String alias) {
    return $FoldersTableTable(attachedDatabase, alias);
  }
}

class FolderRow extends DataClass implements Insertable<FolderRow> {
  final BigInt id;
  final BigInt userId;
  final String title;
  final bool hideGlobally;
  const FolderRow(
      {required this.id,
      required this.userId,
      required this.title,
      required this.hideGlobally});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['user_id'] = Variable<BigInt>(userId);
    map['title'] = Variable<String>(title);
    map['hide_globally'] = Variable<bool>(hideGlobally);
    return map;
  }

  FoldersTableCompanion toCompanion(bool nullToAbsent) {
    return FoldersTableCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      hideGlobally: Value(hideGlobally),
    );
  }

  factory FolderRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FolderRow(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      hideGlobally: serializer.fromJson<bool>(json['hideGlobally']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'userId': serializer.toJson<BigInt>(userId),
      'title': serializer.toJson<String>(title),
      'hideGlobally': serializer.toJson<bool>(hideGlobally),
    };
  }

  FolderRow copyWith(
          {BigInt? id, BigInt? userId, String? title, bool? hideGlobally}) =>
      FolderRow(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        hideGlobally: hideGlobally ?? this.hideGlobally,
      );
  FolderRow copyWithCompanion(FoldersTableCompanion data) {
    return FolderRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      hideGlobally: data.hideGlobally.present
          ? data.hideGlobally.value
          : this.hideGlobally,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FolderRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('hideGlobally: $hideGlobally')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, hideGlobally);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolderRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.hideGlobally == this.hideGlobally);
}

class FoldersTableCompanion extends UpdateCompanion<FolderRow> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<String> title;
  final Value<bool> hideGlobally;
  const FoldersTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.hideGlobally = const Value.absent(),
  });
  FoldersTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required String title,
    this.hideGlobally = const Value.absent(),
  })  : userId = Value(userId),
        title = Value(title);
  static Insertable<FolderRow> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<String>? title,
    Expression<bool>? hideGlobally,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (hideGlobally != null) 'hide_globally': hideGlobally,
    });
  }

  FoldersTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<String>? title,
      Value<bool>? hideGlobally}) {
    return FoldersTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (hideGlobally.present) {
      map['hide_globally'] = Variable<bool>(hideGlobally.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('hideGlobally: $hideGlobally')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsTableTable feedsTable = $FeedsTableTable(this);
  late final $SyncRecordsTableTable syncRecordsTable =
      $SyncRecordsTableTable(this);
  late final $FoldersTableTable foldersTable = $FoldersTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [feedsTable, syncRecordsTable, foldersTable];
}

typedef $$FeedsTableTableCreateCompanionBuilder = FeedsTableCompanion Function({
  Value<BigInt> id,
  required BigInt userId,
  required String feedUrl,
  required String siteUrl,
  required String title,
  Value<String> iconUrl,
  Value<int> errorCount,
  Value<String> errorMsg,
  Value<BigInt> folderId,
  Value<bool> onlyShowUnread,
  Value<String> orderx,
  Value<bool> hideGlobally,
  Value<int> deleted,
});
typedef $$FeedsTableTableUpdateCompanionBuilder = FeedsTableCompanion Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<String> feedUrl,
  Value<String> siteUrl,
  Value<String> title,
  Value<String> iconUrl,
  Value<int> errorCount,
  Value<String> errorMsg,
  Value<BigInt> folderId,
  Value<bool> onlyShowUnread,
  Value<String> orderx,
  Value<bool> hideGlobally,
  Value<int> deleted,
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

  ColumnFilters<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get errorCount => $composableBuilder(
      column: $table.errorCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMsg => $composableBuilder(
      column: $table.errorMsg, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get folderId => $composableBuilder(
      column: $table.folderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get iconUrl => $composableBuilder(
      column: $table.iconUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get errorCount => $composableBuilder(
      column: $table.errorCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMsg => $composableBuilder(
      column: $table.errorMsg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get folderId => $composableBuilder(
      column: $table.folderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<int> get errorCount => $composableBuilder(
      column: $table.errorCount, builder: (column) => column);

  GeneratedColumn<String> get errorMsg =>
      $composableBuilder(column: $table.errorMsg, builder: (column) => column);

  GeneratedColumn<BigInt> get folderId =>
      $composableBuilder(column: $table.folderId, builder: (column) => column);

  GeneratedColumn<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread, builder: (column) => column);

  GeneratedColumn<String> get orderx =>
      $composableBuilder(column: $table.orderx, builder: (column) => column);

  GeneratedColumn<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => column);

  GeneratedColumn<int> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);
}

class $$FeedsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedsTableTable,
    FeedRow,
    $$FeedsTableTableFilterComposer,
    $$FeedsTableTableOrderingComposer,
    $$FeedsTableTableAnnotationComposer,
    $$FeedsTableTableCreateCompanionBuilder,
    $$FeedsTableTableUpdateCompanionBuilder,
    (FeedRow, BaseReferences<_$AppDatabase, $FeedsTableTable, FeedRow>),
    FeedRow,
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
            Value<String> iconUrl = const Value.absent(),
            Value<int> errorCount = const Value.absent(),
            Value<String> errorMsg = const Value.absent(),
            Value<BigInt> folderId = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<String> orderx = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
            Value<int> deleted = const Value.absent(),
          }) =>
              FeedsTableCompanion(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            iconUrl: iconUrl,
            errorCount: errorCount,
            errorMsg: errorMsg,
            folderId: folderId,
            onlyShowUnread: onlyShowUnread,
            orderx: orderx,
            hideGlobally: hideGlobally,
            deleted: deleted,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required String feedUrl,
            required String siteUrl,
            required String title,
            Value<String> iconUrl = const Value.absent(),
            Value<int> errorCount = const Value.absent(),
            Value<String> errorMsg = const Value.absent(),
            Value<BigInt> folderId = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<String> orderx = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
            Value<int> deleted = const Value.absent(),
          }) =>
              FeedsTableCompanion.insert(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            iconUrl: iconUrl,
            errorCount: errorCount,
            errorMsg: errorMsg,
            folderId: folderId,
            onlyShowUnread: onlyShowUnread,
            orderx: orderx,
            hideGlobally: hideGlobally,
            deleted: deleted,
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
    FeedRow,
    $$FeedsTableTableFilterComposer,
    $$FeedsTableTableOrderingComposer,
    $$FeedsTableTableAnnotationComposer,
    $$FeedsTableTableCreateCompanionBuilder,
    $$FeedsTableTableUpdateCompanionBuilder,
    (FeedRow, BaseReferences<_$AppDatabase, $FeedsTableTable, FeedRow>),
    FeedRow,
    PrefetchHooks Function()>;
typedef $$SyncRecordsTableTableCreateCompanionBuilder
    = SyncRecordsTableCompanion Function({
  Value<BigInt> id,
  required String status,
  Value<DateTime> time,
  required String errorMsg,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  required int entry,
  required int feed,
  required int folder,
});
typedef $$SyncRecordsTableTableUpdateCompanionBuilder
    = SyncRecordsTableCompanion Function({
  Value<BigInt> id,
  Value<String> status,
  Value<DateTime> time,
  Value<String> errorMsg,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<int> entry,
  Value<int> feed,
  Value<int> folder,
});

class $$SyncRecordsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncRecordsTableTable> {
  $$SyncRecordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMsg => $composableBuilder(
      column: $table.errorMsg, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get entry => $composableBuilder(
      column: $table.entry, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get feed => $composableBuilder(
      column: $table.feed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get folder => $composableBuilder(
      column: $table.folder, builder: (column) => ColumnFilters(column));
}

class $$SyncRecordsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncRecordsTableTable> {
  $$SyncRecordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMsg => $composableBuilder(
      column: $table.errorMsg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get entry => $composableBuilder(
      column: $table.entry, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get feed => $composableBuilder(
      column: $table.feed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get folder => $composableBuilder(
      column: $table.folder, builder: (column) => ColumnOrderings(column));
}

class $$SyncRecordsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncRecordsTableTable> {
  $$SyncRecordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get errorMsg =>
      $composableBuilder(column: $table.errorMsg, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get entry =>
      $composableBuilder(column: $table.entry, builder: (column) => column);

  GeneratedColumn<int> get feed =>
      $composableBuilder(column: $table.feed, builder: (column) => column);

  GeneratedColumn<int> get folder =>
      $composableBuilder(column: $table.folder, builder: (column) => column);
}

class $$SyncRecordsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncRecordsTableTable,
    SyncRecordRow,
    $$SyncRecordsTableTableFilterComposer,
    $$SyncRecordsTableTableOrderingComposer,
    $$SyncRecordsTableTableAnnotationComposer,
    $$SyncRecordsTableTableCreateCompanionBuilder,
    $$SyncRecordsTableTableUpdateCompanionBuilder,
    (
      SyncRecordRow,
      BaseReferences<_$AppDatabase, $SyncRecordsTableTable, SyncRecordRow>
    ),
    SyncRecordRow,
    PrefetchHooks Function()> {
  $$SyncRecordsTableTableTableManager(
      _$AppDatabase db, $SyncRecordsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncRecordsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncRecordsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncRecordsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> time = const Value.absent(),
            Value<String> errorMsg = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<int> entry = const Value.absent(),
            Value<int> feed = const Value.absent(),
            Value<int> folder = const Value.absent(),
          }) =>
              SyncRecordsTableCompanion(
            id: id,
            status: status,
            time: time,
            errorMsg: errorMsg,
            startTime: startTime,
            endTime: endTime,
            entry: entry,
            feed: feed,
            folder: folder,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required String status,
            Value<DateTime> time = const Value.absent(),
            required String errorMsg,
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            required int entry,
            required int feed,
            required int folder,
          }) =>
              SyncRecordsTableCompanion.insert(
            id: id,
            status: status,
            time: time,
            errorMsg: errorMsg,
            startTime: startTime,
            endTime: endTime,
            entry: entry,
            feed: feed,
            folder: folder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncRecordsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncRecordsTableTable,
    SyncRecordRow,
    $$SyncRecordsTableTableFilterComposer,
    $$SyncRecordsTableTableOrderingComposer,
    $$SyncRecordsTableTableAnnotationComposer,
    $$SyncRecordsTableTableCreateCompanionBuilder,
    $$SyncRecordsTableTableUpdateCompanionBuilder,
    (
      SyncRecordRow,
      BaseReferences<_$AppDatabase, $SyncRecordsTableTable, SyncRecordRow>
    ),
    SyncRecordRow,
    PrefetchHooks Function()>;
typedef $$FoldersTableTableCreateCompanionBuilder = FoldersTableCompanion
    Function({
  Value<BigInt> id,
  required BigInt userId,
  required String title,
  Value<bool> hideGlobally,
});
typedef $$FoldersTableTableUpdateCompanionBuilder = FoldersTableCompanion
    Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<String> title,
  Value<bool> hideGlobally,
});

class $$FoldersTableTableFilterComposer
    extends Composer<_$AppDatabase, $FoldersTableTable> {
  $$FoldersTableTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => ColumnFilters(column));
}

class $$FoldersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FoldersTableTable> {
  $$FoldersTableTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally,
      builder: (column) => ColumnOrderings(column));
}

class $$FoldersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoldersTableTable> {
  $$FoldersTableTableAnnotationComposer({
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => column);
}

class $$FoldersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoldersTableTable,
    FolderRow,
    $$FoldersTableTableFilterComposer,
    $$FoldersTableTableOrderingComposer,
    $$FoldersTableTableAnnotationComposer,
    $$FoldersTableTableCreateCompanionBuilder,
    $$FoldersTableTableUpdateCompanionBuilder,
    (FolderRow, BaseReferences<_$AppDatabase, $FoldersTableTable, FolderRow>),
    FolderRow,
    PrefetchHooks Function()> {
  $$FoldersTableTableTableManager(_$AppDatabase db, $FoldersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoldersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoldersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoldersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
          }) =>
              FoldersTableCompanion(
            id: id,
            userId: userId,
            title: title,
            hideGlobally: hideGlobally,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required String title,
            Value<bool> hideGlobally = const Value.absent(),
          }) =>
              FoldersTableCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            hideGlobally: hideGlobally,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoldersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoldersTableTable,
    FolderRow,
    $$FoldersTableTableFilterComposer,
    $$FoldersTableTableOrderingComposer,
    $$FoldersTableTableAnnotationComposer,
    $$FoldersTableTableCreateCompanionBuilder,
    $$FoldersTableTableUpdateCompanionBuilder,
    (FolderRow, BaseReferences<_$AppDatabase, $FoldersTableTable, FolderRow>),
    FolderRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsTableTableTableManager get feedsTable =>
      $$FeedsTableTableTableManager(_db, _db.feedsTable);
  $$SyncRecordsTableTableTableManager get syncRecordsTable =>
      $$SyncRecordsTableTableTableManager(_db, _db.syncRecordsTable);
  $$FoldersTableTableTableManager get foldersTable =>
      $$FoldersTableTableTableManager(_db, _db.foldersTable);
}
