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
  static const VerificationMeta _mediaMeta = const VerificationMeta('media');
  @override
  late final GeneratedColumn<int> media = GeneratedColumn<int>(
      'media', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        status,
        time,
        errorMsg,
        startTime,
        endTime,
        entry,
        feed,
        folder,
        media
      ];
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
    if (data.containsKey('media')) {
      context.handle(
          _mediaMeta, media.isAcceptableOrUnknown(data['media']!, _mediaMeta));
    } else if (isInserting) {
      context.missing(_mediaMeta);
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
      media: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}media'])!,
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
  final int media;
  const SyncRecordRow(
      {required this.id,
      required this.status,
      required this.time,
      required this.errorMsg,
      required this.startTime,
      required this.endTime,
      required this.entry,
      required this.feed,
      required this.folder,
      required this.media});
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
    map['media'] = Variable<int>(media);
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
      media: Value(media),
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
      media: serializer.fromJson<int>(json['media']),
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
      'media': serializer.toJson<int>(media),
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
          int? folder,
          int? media}) =>
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
        media: media ?? this.media,
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
      media: data.media.present ? data.media.value : this.media,
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
          ..write('folder: $folder, ')
          ..write('media: $media')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, status, time, errorMsg, startTime,
      endTime, entry, feed, folder, media);
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
          other.folder == this.folder &&
          other.media == this.media);
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
  final Value<int> media;
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
    this.media = const Value.absent(),
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
    required int media,
  })  : status = Value(status),
        errorMsg = Value(errorMsg),
        entry = Value(entry),
        feed = Value(feed),
        folder = Value(folder),
        media = Value(media);
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
    Expression<int>? media,
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
      if (media != null) 'media': media,
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
      Value<int>? folder,
      Value<int>? media}) {
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
      media: media ?? this.media,
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
    if (media.present) {
      map['media'] = Variable<int>(media.value);
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
          ..write('folder: $folder, ')
          ..write('media: $media')
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

class $FiltersTableTable extends FiltersTable
    with TableInfo<$FiltersTableTable, FilterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FiltersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.bigInt,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<BigInt> userId = GeneratedColumn<BigInt>(
      'user_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
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
  static const VerificationMeta _publishedTimeMeta =
      const VerificationMeta('publishedTime');
  @override
  late final GeneratedColumn<int> publishedTime = GeneratedColumn<int>(
      'published_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _addTimeMeta =
      const VerificationMeta('addTime');
  @override
  late final GeneratedColumn<int> addTime = GeneratedColumn<int>(
      'add_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _statusesMeta =
      const VerificationMeta('statuses');
  @override
  late final GeneratedColumn<String> statuses = GeneratedColumn<String>(
      'statuses', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _changedAtMeta =
      const VerificationMeta('changedAt');
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
      'changed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
        name,
        icon,
        feedIds,
        publishedTime,
        addTime,
        statuses,
        createdAt,
        changedAt,
        orderx,
        hideGlobally,
        onlyShowUnread,
        deleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'filters';
  @override
  VerificationContext validateIntegrity(Insertable<FilterRow> instance,
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
    if (data.containsKey('published_time')) {
      context.handle(
          _publishedTimeMeta,
          publishedTime.isAcceptableOrUnknown(
              data['published_time']!, _publishedTimeMeta));
    }
    if (data.containsKey('add_time')) {
      context.handle(_addTimeMeta,
          addTime.isAcceptableOrUnknown(data['add_time']!, _addTimeMeta));
    }
    if (data.containsKey('statuses')) {
      context.handle(_statusesMeta,
          statuses.isAcceptableOrUnknown(data['statuses']!, _statusesMeta));
    } else if (isInserting) {
      context.missing(_statusesMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    } else if (isInserting) {
      context.missing(_changedAtMeta);
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
    if (data.containsKey('only_show_unread')) {
      context.handle(
          _onlyShowUnreadMeta,
          onlyShowUnread.isAcceptableOrUnknown(
              data['only_show_unread']!, _onlyShowUnreadMeta));
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
  FilterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilterRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      feedIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feed_ids'])!,
      publishedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}published_time'])!,
      addTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}add_time'])!,
      statuses: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}statuses'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
      orderx: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orderx'])!,
      hideGlobally: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hide_globally'])!,
      onlyShowUnread: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}only_show_unread'])!,
      deleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted'])!,
    );
  }

  @override
  $FiltersTableTable createAlias(String alias) {
    return $FiltersTableTable(attachedDatabase, alias);
  }
}

class FilterRow extends DataClass implements Insertable<FilterRow> {
  final BigInt id;
  final BigInt userId;
  final String name;
  final String icon;
  final String feedIds;
  final int publishedTime;
  final int addTime;
  final String statuses;
  final DateTime createdAt;
  final DateTime changedAt;
  final String orderx;
  final bool hideGlobally;
  final bool onlyShowUnread;
  final int deleted;
  const FilterRow(
      {required this.id,
      required this.userId,
      required this.name,
      required this.icon,
      required this.feedIds,
      required this.publishedTime,
      required this.addTime,
      required this.statuses,
      required this.createdAt,
      required this.changedAt,
      required this.orderx,
      required this.hideGlobally,
      required this.onlyShowUnread,
      required this.deleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['user_id'] = Variable<BigInt>(userId);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['feed_ids'] = Variable<String>(feedIds);
    map['published_time'] = Variable<int>(publishedTime);
    map['add_time'] = Variable<int>(addTime);
    map['statuses'] = Variable<String>(statuses);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['changed_at'] = Variable<DateTime>(changedAt);
    map['orderx'] = Variable<String>(orderx);
    map['hide_globally'] = Variable<bool>(hideGlobally);
    map['only_show_unread'] = Variable<bool>(onlyShowUnread);
    map['deleted'] = Variable<int>(deleted);
    return map;
  }

  FiltersTableCompanion toCompanion(bool nullToAbsent) {
    return FiltersTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      icon: Value(icon),
      feedIds: Value(feedIds),
      publishedTime: Value(publishedTime),
      addTime: Value(addTime),
      statuses: Value(statuses),
      createdAt: Value(createdAt),
      changedAt: Value(changedAt),
      orderx: Value(orderx),
      hideGlobally: Value(hideGlobally),
      onlyShowUnread: Value(onlyShowUnread),
      deleted: Value(deleted),
    );
  }

  factory FilterRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilterRow(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      feedIds: serializer.fromJson<String>(json['feedIds']),
      publishedTime: serializer.fromJson<int>(json['publishedTime']),
      addTime: serializer.fromJson<int>(json['addTime']),
      statuses: serializer.fromJson<String>(json['statuses']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      orderx: serializer.fromJson<String>(json['orderx']),
      hideGlobally: serializer.fromJson<bool>(json['hideGlobally']),
      onlyShowUnread: serializer.fromJson<bool>(json['onlyShowUnread']),
      deleted: serializer.fromJson<int>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'userId': serializer.toJson<BigInt>(userId),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'feedIds': serializer.toJson<String>(feedIds),
      'publishedTime': serializer.toJson<int>(publishedTime),
      'addTime': serializer.toJson<int>(addTime),
      'statuses': serializer.toJson<String>(statuses),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'orderx': serializer.toJson<String>(orderx),
      'hideGlobally': serializer.toJson<bool>(hideGlobally),
      'onlyShowUnread': serializer.toJson<bool>(onlyShowUnread),
      'deleted': serializer.toJson<int>(deleted),
    };
  }

  FilterRow copyWith(
          {BigInt? id,
          BigInt? userId,
          String? name,
          String? icon,
          String? feedIds,
          int? publishedTime,
          int? addTime,
          String? statuses,
          DateTime? createdAt,
          DateTime? changedAt,
          String? orderx,
          bool? hideGlobally,
          bool? onlyShowUnread,
          int? deleted}) =>
      FilterRow(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        feedIds: feedIds ?? this.feedIds,
        publishedTime: publishedTime ?? this.publishedTime,
        addTime: addTime ?? this.addTime,
        statuses: statuses ?? this.statuses,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        orderx: orderx ?? this.orderx,
        hideGlobally: hideGlobally ?? this.hideGlobally,
        onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
        deleted: deleted ?? this.deleted,
      );
  FilterRow copyWithCompanion(FiltersTableCompanion data) {
    return FilterRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      feedIds: data.feedIds.present ? data.feedIds.value : this.feedIds,
      publishedTime: data.publishedTime.present
          ? data.publishedTime.value
          : this.publishedTime,
      addTime: data.addTime.present ? data.addTime.value : this.addTime,
      statuses: data.statuses.present ? data.statuses.value : this.statuses,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      orderx: data.orderx.present ? data.orderx.value : this.orderx,
      hideGlobally: data.hideGlobally.present
          ? data.hideGlobally.value
          : this.hideGlobally,
      onlyShowUnread: data.onlyShowUnread.present
          ? data.onlyShowUnread.value
          : this.onlyShowUnread,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FilterRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('feedIds: $feedIds, ')
          ..write('publishedTime: $publishedTime, ')
          ..write('addTime: $addTime, ')
          ..write('statuses: $statuses, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('orderx: $orderx, ')
          ..write('hideGlobally: $hideGlobally, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      icon,
      feedIds,
      publishedTime,
      addTime,
      statuses,
      createdAt,
      changedAt,
      orderx,
      hideGlobally,
      onlyShowUnread,
      deleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilterRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.feedIds == this.feedIds &&
          other.publishedTime == this.publishedTime &&
          other.addTime == this.addTime &&
          other.statuses == this.statuses &&
          other.createdAt == this.createdAt &&
          other.changedAt == this.changedAt &&
          other.orderx == this.orderx &&
          other.hideGlobally == this.hideGlobally &&
          other.onlyShowUnread == this.onlyShowUnread &&
          other.deleted == this.deleted);
}

class FiltersTableCompanion extends UpdateCompanion<FilterRow> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> feedIds;
  final Value<int> publishedTime;
  final Value<int> addTime;
  final Value<String> statuses;
  final Value<DateTime> createdAt;
  final Value<DateTime> changedAt;
  final Value<String> orderx;
  final Value<bool> hideGlobally;
  final Value<bool> onlyShowUnread;
  final Value<int> deleted;
  const FiltersTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.feedIds = const Value.absent(),
    this.publishedTime = const Value.absent(),
    this.addTime = const Value.absent(),
    this.statuses = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.orderx = const Value.absent(),
    this.hideGlobally = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  FiltersTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required String name,
    required String icon,
    required String feedIds,
    this.publishedTime = const Value.absent(),
    this.addTime = const Value.absent(),
    required String statuses,
    required DateTime createdAt,
    required DateTime changedAt,
    this.orderx = const Value.absent(),
    this.hideGlobally = const Value.absent(),
    this.onlyShowUnread = const Value.absent(),
    this.deleted = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name),
        icon = Value(icon),
        feedIds = Value(feedIds),
        statuses = Value(statuses),
        createdAt = Value(createdAt),
        changedAt = Value(changedAt);
  static Insertable<FilterRow> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? feedIds,
    Expression<int>? publishedTime,
    Expression<int>? addTime,
    Expression<String>? statuses,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? changedAt,
    Expression<String>? orderx,
    Expression<bool>? hideGlobally,
    Expression<bool>? onlyShowUnread,
    Expression<int>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (feedIds != null) 'feed_ids': feedIds,
      if (publishedTime != null) 'published_time': publishedTime,
      if (addTime != null) 'add_time': addTime,
      if (statuses != null) 'statuses': statuses,
      if (createdAt != null) 'created_at': createdAt,
      if (changedAt != null) 'changed_at': changedAt,
      if (orderx != null) 'orderx': orderx,
      if (hideGlobally != null) 'hide_globally': hideGlobally,
      if (onlyShowUnread != null) 'only_show_unread': onlyShowUnread,
      if (deleted != null) 'deleted': deleted,
    });
  }

  FiltersTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<String>? name,
      Value<String>? icon,
      Value<String>? feedIds,
      Value<int>? publishedTime,
      Value<int>? addTime,
      Value<String>? statuses,
      Value<DateTime>? createdAt,
      Value<DateTime>? changedAt,
      Value<String>? orderx,
      Value<bool>? hideGlobally,
      Value<bool>? onlyShowUnread,
      Value<int>? deleted}) {
    return FiltersTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      feedIds: feedIds ?? this.feedIds,
      publishedTime: publishedTime ?? this.publishedTime,
      addTime: addTime ?? this.addTime,
      statuses: statuses ?? this.statuses,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      orderx: orderx ?? this.orderx,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (feedIds.present) {
      map['feed_ids'] = Variable<String>(feedIds.value);
    }
    if (publishedTime.present) {
      map['published_time'] = Variable<int>(publishedTime.value);
    }
    if (addTime.present) {
      map['add_time'] = Variable<int>(addTime.value);
    }
    if (statuses.present) {
      map['statuses'] = Variable<String>(statuses.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (orderx.present) {
      map['orderx'] = Variable<String>(orderx.value);
    }
    if (hideGlobally.present) {
      map['hide_globally'] = Variable<bool>(hideGlobally.value);
    }
    if (onlyShowUnread.present) {
      map['only_show_unread'] = Variable<bool>(onlyShowUnread.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<int>(deleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FiltersTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('feedIds: $feedIds, ')
          ..write('publishedTime: $publishedTime, ')
          ..write('addTime: $addTime, ')
          ..write('statuses: $statuses, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('orderx: $orderx, ')
          ..write('hideGlobally: $hideGlobally, ')
          ..write('onlyShowUnread: $onlyShowUnread, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $EntriesTableTable extends EntriesTable
    with TableInfo<$EntriesTableTable, EntryRow> {
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
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _readingTimeMeta =
      const VerificationMeta('readingTime');
  @override
  late final GeneratedColumn<int> readingTime = GeneratedColumn<int>(
      'reading_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
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
      defaultValue: Constant(false));
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        feedId,
        status,
        hash,
        title,
        url,
        content,
        author,
        readingTime,
        summary,
        starred,
        publishedAt,
        createdAt,
        changedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(Insertable<EntryRow> instance,
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
    } else if (isInserting) {
      context.missing(_statusMeta);
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
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('reading_time')) {
      context.handle(
          _readingTimeMeta,
          readingTime.isAcceptableOrUnknown(
              data['reading_time']!, _readingTimeMeta));
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    }
    if (data.containsKey('starred')) {
      context.handle(_starredMeta,
          starred.isAcceptableOrUnknown(data['starred']!, _starredMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryRow(
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
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      readingTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_time'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      starred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}starred'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
    );
  }

  @override
  $EntriesTableTable createAlias(String alias) {
    return $EntriesTableTable(attachedDatabase, alias);
  }
}

class EntryRow extends DataClass implements Insertable<EntryRow> {
  final BigInt id;
  final BigInt userId;
  final BigInt feedId;
  final String status;
  final String hash;
  final String title;
  final String url;
  final String content;
  final String author;
  final int readingTime;
  final String summary;
  final bool starred;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime changedAt;
  const EntryRow(
      {required this.id,
      required this.userId,
      required this.feedId,
      required this.status,
      required this.hash,
      required this.title,
      required this.url,
      required this.content,
      required this.author,
      required this.readingTime,
      required this.summary,
      required this.starred,
      required this.publishedAt,
      required this.createdAt,
      required this.changedAt});
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
    map['content'] = Variable<String>(content);
    map['author'] = Variable<String>(author);
    map['reading_time'] = Variable<int>(readingTime);
    map['summary'] = Variable<String>(summary);
    map['starred'] = Variable<bool>(starred);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['changed_at'] = Variable<DateTime>(changedAt);
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
      content: Value(content),
      author: Value(author),
      readingTime: Value(readingTime),
      summary: Value(summary),
      starred: Value(starred),
      publishedAt: Value(publishedAt),
      createdAt: Value(createdAt),
      changedAt: Value(changedAt),
    );
  }

  factory EntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryRow(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      feedId: serializer.fromJson<BigInt>(json['feedId']),
      status: serializer.fromJson<String>(json['status']),
      hash: serializer.fromJson<String>(json['hash']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      content: serializer.fromJson<String>(json['content']),
      author: serializer.fromJson<String>(json['author']),
      readingTime: serializer.fromJson<int>(json['readingTime']),
      summary: serializer.fromJson<String>(json['summary']),
      starred: serializer.fromJson<bool>(json['starred']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
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
      'content': serializer.toJson<String>(content),
      'author': serializer.toJson<String>(author),
      'readingTime': serializer.toJson<int>(readingTime),
      'summary': serializer.toJson<String>(summary),
      'starred': serializer.toJson<bool>(starred),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changedAt': serializer.toJson<DateTime>(changedAt),
    };
  }

  EntryRow copyWith(
          {BigInt? id,
          BigInt? userId,
          BigInt? feedId,
          String? status,
          String? hash,
          String? title,
          String? url,
          String? content,
          String? author,
          int? readingTime,
          String? summary,
          bool? starred,
          DateTime? publishedAt,
          DateTime? createdAt,
          DateTime? changedAt}) =>
      EntryRow(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        feedId: feedId ?? this.feedId,
        status: status ?? this.status,
        hash: hash ?? this.hash,
        title: title ?? this.title,
        url: url ?? this.url,
        content: content ?? this.content,
        author: author ?? this.author,
        readingTime: readingTime ?? this.readingTime,
        summary: summary ?? this.summary,
        starred: starred ?? this.starred,
        publishedAt: publishedAt ?? this.publishedAt,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
      );
  EntryRow copyWithCompanion(EntriesTableCompanion data) {
    return EntryRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      feedId: data.feedId.present ? data.feedId.value : this.feedId,
      status: data.status.present ? data.status.value : this.status,
      hash: data.hash.present ? data.hash.value : this.hash,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      content: data.content.present ? data.content.value : this.content,
      author: data.author.present ? data.author.value : this.author,
      readingTime:
          data.readingTime.present ? data.readingTime.value : this.readingTime,
      summary: data.summary.present ? data.summary.value : this.summary,
      starred: data.starred.present ? data.starred.value : this.starred,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedId: $feedId, ')
          ..write('status: $status, ')
          ..write('hash: $hash, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('readingTime: $readingTime, ')
          ..write('summary: $summary, ')
          ..write('starred: $starred, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt')
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
      content,
      author,
      readingTime,
      summary,
      starred,
      publishedAt,
      createdAt,
      changedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.feedId == this.feedId &&
          other.status == this.status &&
          other.hash == this.hash &&
          other.title == this.title &&
          other.url == this.url &&
          other.content == this.content &&
          other.author == this.author &&
          other.readingTime == this.readingTime &&
          other.summary == this.summary &&
          other.starred == this.starred &&
          other.publishedAt == this.publishedAt &&
          other.createdAt == this.createdAt &&
          other.changedAt == this.changedAt);
}

class EntriesTableCompanion extends UpdateCompanion<EntryRow> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<BigInt> feedId;
  final Value<String> status;
  final Value<String> hash;
  final Value<String> title;
  final Value<String> url;
  final Value<String> content;
  final Value<String> author;
  final Value<int> readingTime;
  final Value<String> summary;
  final Value<bool> starred;
  final Value<DateTime> publishedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> changedAt;
  const EntriesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedId = const Value.absent(),
    this.status = const Value.absent(),
    this.hash = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.content = const Value.absent(),
    this.author = const Value.absent(),
    this.readingTime = const Value.absent(),
    this.summary = const Value.absent(),
    this.starred = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
  });
  EntriesTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required BigInt feedId,
    required String status,
    required String hash,
    required String title,
    this.url = const Value.absent(),
    this.content = const Value.absent(),
    this.author = const Value.absent(),
    this.readingTime = const Value.absent(),
    this.summary = const Value.absent(),
    this.starred = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
  })  : userId = Value(userId),
        feedId = Value(feedId),
        status = Value(status),
        hash = Value(hash),
        title = Value(title);
  static Insertable<EntryRow> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<BigInt>? feedId,
    Expression<String>? status,
    Expression<String>? hash,
    Expression<String>? title,
    Expression<String>? url,
    Expression<String>? content,
    Expression<String>? author,
    Expression<int>? readingTime,
    Expression<String>? summary,
    Expression<bool>? starred,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? changedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (feedId != null) 'feed_id': feedId,
      if (status != null) 'status': status,
      if (hash != null) 'hash': hash,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (content != null) 'content': content,
      if (author != null) 'author': author,
      if (readingTime != null) 'reading_time': readingTime,
      if (summary != null) 'summary': summary,
      if (starred != null) 'starred': starred,
      if (publishedAt != null) 'published_at': publishedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (changedAt != null) 'changed_at': changedAt,
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
      Value<String>? content,
      Value<String>? author,
      Value<int>? readingTime,
      Value<String>? summary,
      Value<bool>? starred,
      Value<DateTime>? publishedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? changedAt}) {
    return EntriesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedId: feedId ?? this.feedId,
      status: status ?? this.status,
      hash: hash ?? this.hash,
      title: title ?? this.title,
      url: url ?? this.url,
      content: content ?? this.content,
      author: author ?? this.author,
      readingTime: readingTime ?? this.readingTime,
      summary: summary ?? this.summary,
      starred: starred ?? this.starred,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
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
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (readingTime.present) {
      map['reading_time'] = Variable<int>(readingTime.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (starred.present) {
      map['starred'] = Variable<bool>(starred.value);
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
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('readingTime: $readingTime, ')
          ..write('summary: $summary, ')
          ..write('starred: $starred, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }
}

class $MediasTableTable extends MediasTable
    with TableInfo<$MediasTableTable, MediaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediasTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<BigInt> entryId = GeneratedColumn<BigInt>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
      'size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, entryId, url, mimeType, size];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medias';
  @override
  VerificationContext validateIntegrity(Insertable<MediaRow> instance,
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
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}user_id'])!,
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}entry_id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type'])!,
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size'])!,
    );
  }

  @override
  $MediasTableTable createAlias(String alias) {
    return $MediasTableTable(attachedDatabase, alias);
  }
}

class MediaRow extends DataClass implements Insertable<MediaRow> {
  final BigInt id;
  final BigInt userId;
  final BigInt entryId;
  final String url;
  final String mimeType;
  final int size;
  const MediaRow(
      {required this.id,
      required this.userId,
      required this.entryId,
      required this.url,
      required this.mimeType,
      required this.size});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['user_id'] = Variable<BigInt>(userId);
    map['entry_id'] = Variable<BigInt>(entryId);
    map['url'] = Variable<String>(url);
    map['mime_type'] = Variable<String>(mimeType);
    map['size'] = Variable<int>(size);
    return map;
  }

  MediasTableCompanion toCompanion(bool nullToAbsent) {
    return MediasTableCompanion(
      id: Value(id),
      userId: Value(userId),
      entryId: Value(entryId),
      url: Value(url),
      mimeType: Value(mimeType),
      size: Value(size),
    );
  }

  factory MediaRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaRow(
      id: serializer.fromJson<BigInt>(json['id']),
      userId: serializer.fromJson<BigInt>(json['userId']),
      entryId: serializer.fromJson<BigInt>(json['entryId']),
      url: serializer.fromJson<String>(json['url']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      size: serializer.fromJson<int>(json['size']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'userId': serializer.toJson<BigInt>(userId),
      'entryId': serializer.toJson<BigInt>(entryId),
      'url': serializer.toJson<String>(url),
      'mimeType': serializer.toJson<String>(mimeType),
      'size': serializer.toJson<int>(size),
    };
  }

  MediaRow copyWith(
          {BigInt? id,
          BigInt? userId,
          BigInt? entryId,
          String? url,
          String? mimeType,
          int? size}) =>
      MediaRow(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        entryId: entryId ?? this.entryId,
        url: url ?? this.url,
        mimeType: mimeType ?? this.mimeType,
        size: size ?? this.size,
      );
  MediaRow copyWithCompanion(MediasTableCompanion data) {
    return MediaRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      url: data.url.present ? data.url.value : this.url,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      size: data.size.present ? data.size.value : this.size,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('entryId: $entryId, ')
          ..write('url: $url, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, entryId, url, mimeType, size);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.entryId == this.entryId &&
          other.url == this.url &&
          other.mimeType == this.mimeType &&
          other.size == this.size);
}

class MediasTableCompanion extends UpdateCompanion<MediaRow> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<BigInt> entryId;
  final Value<String> url;
  final Value<String> mimeType;
  final Value<int> size;
  const MediasTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.url = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.size = const Value.absent(),
  });
  MediasTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required BigInt entryId,
    required String url,
    required String mimeType,
    required int size,
  })  : userId = Value(userId),
        entryId = Value(entryId),
        url = Value(url),
        mimeType = Value(mimeType),
        size = Value(size);
  static Insertable<MediaRow> custom({
    Expression<BigInt>? id,
    Expression<BigInt>? userId,
    Expression<BigInt>? entryId,
    Expression<String>? url,
    Expression<String>? mimeType,
    Expression<int>? size,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (entryId != null) 'entry_id': entryId,
      if (url != null) 'url': url,
      if (mimeType != null) 'mime_type': mimeType,
      if (size != null) 'size': size,
    });
  }

  MediasTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<BigInt>? entryId,
      Value<String>? url,
      Value<String>? mimeType,
      Value<int>? size}) {
    return MediasTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      entryId: entryId ?? this.entryId,
      url: url ?? this.url,
      mimeType: mimeType ?? this.mimeType,
      size: size ?? this.size,
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
    if (entryId.present) {
      map['entry_id'] = Variable<BigInt>(entryId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediasTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('entryId: $entryId, ')
          ..write('url: $url, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size')
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
  late final $FiltersTableTable filtersTable = $FiltersTableTable(this);
  late final $EntriesTableTable entriesTable = $EntriesTableTable(this);
  late final $MediasTableTable mediasTable = $MediasTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        feedsTable,
        syncRecordsTable,
        foldersTable,
        filtersTable,
        entriesTable,
        mediasTable
      ];
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
  required int media,
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
  Value<int> media,
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

  ColumnFilters<int> get media => $composableBuilder(
      column: $table.media, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get media => $composableBuilder(
      column: $table.media, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get media =>
      $composableBuilder(column: $table.media, builder: (column) => column);
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
            Value<int> media = const Value.absent(),
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
            media: media,
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
            required int media,
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
            media: media,
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
typedef $$FiltersTableTableCreateCompanionBuilder = FiltersTableCompanion
    Function({
  Value<BigInt> id,
  required BigInt userId,
  required String name,
  required String icon,
  required String feedIds,
  Value<int> publishedTime,
  Value<int> addTime,
  required String statuses,
  required DateTime createdAt,
  required DateTime changedAt,
  Value<String> orderx,
  Value<bool> hideGlobally,
  Value<bool> onlyShowUnread,
  Value<int> deleted,
});
typedef $$FiltersTableTableUpdateCompanionBuilder = FiltersTableCompanion
    Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<String> name,
  Value<String> icon,
  Value<String> feedIds,
  Value<int> publishedTime,
  Value<int> addTime,
  Value<String> statuses,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
  Value<String> orderx,
  Value<bool> hideGlobally,
  Value<bool> onlyShowUnread,
  Value<int> deleted,
});

class $$FiltersTableTableFilterComposer
    extends Composer<_$AppDatabase, $FiltersTableTable> {
  $$FiltersTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedIds => $composableBuilder(
      column: $table.feedIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get publishedTime => $composableBuilder(
      column: $table.publishedTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get addTime => $composableBuilder(
      column: $table.addTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statuses => $composableBuilder(
      column: $table.statuses, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnFilters(column));
}

class $$FiltersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FiltersTableTable> {
  $$FiltersTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedIds => $composableBuilder(
      column: $table.feedIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get publishedTime => $composableBuilder(
      column: $table.publishedTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get addTime => $composableBuilder(
      column: $table.addTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statuses => $composableBuilder(
      column: $table.statuses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderx => $composableBuilder(
      column: $table.orderx, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deleted => $composableBuilder(
      column: $table.deleted, builder: (column) => ColumnOrderings(column));
}

class $$FiltersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FiltersTableTable> {
  $$FiltersTableTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get feedIds =>
      $composableBuilder(column: $table.feedIds, builder: (column) => column);

  GeneratedColumn<int> get publishedTime => $composableBuilder(
      column: $table.publishedTime, builder: (column) => column);

  GeneratedColumn<int> get addTime =>
      $composableBuilder(column: $table.addTime, builder: (column) => column);

  GeneratedColumn<String> get statuses =>
      $composableBuilder(column: $table.statuses, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get orderx =>
      $composableBuilder(column: $table.orderx, builder: (column) => column);

  GeneratedColumn<bool> get hideGlobally => $composableBuilder(
      column: $table.hideGlobally, builder: (column) => column);

  GeneratedColumn<bool> get onlyShowUnread => $composableBuilder(
      column: $table.onlyShowUnread, builder: (column) => column);

  GeneratedColumn<int> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);
}

class $$FiltersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FiltersTableTable,
    FilterRow,
    $$FiltersTableTableFilterComposer,
    $$FiltersTableTableOrderingComposer,
    $$FiltersTableTableAnnotationComposer,
    $$FiltersTableTableCreateCompanionBuilder,
    $$FiltersTableTableUpdateCompanionBuilder,
    (FilterRow, BaseReferences<_$AppDatabase, $FiltersTableTable, FilterRow>),
    FilterRow,
    PrefetchHooks Function()> {
  $$FiltersTableTableTableManager(_$AppDatabase db, $FiltersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FiltersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FiltersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FiltersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> feedIds = const Value.absent(),
            Value<int> publishedTime = const Value.absent(),
            Value<int> addTime = const Value.absent(),
            Value<String> statuses = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
            Value<String> orderx = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<int> deleted = const Value.absent(),
          }) =>
              FiltersTableCompanion(
            id: id,
            userId: userId,
            name: name,
            icon: icon,
            feedIds: feedIds,
            publishedTime: publishedTime,
            addTime: addTime,
            statuses: statuses,
            createdAt: createdAt,
            changedAt: changedAt,
            orderx: orderx,
            hideGlobally: hideGlobally,
            onlyShowUnread: onlyShowUnread,
            deleted: deleted,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required String name,
            required String icon,
            required String feedIds,
            Value<int> publishedTime = const Value.absent(),
            Value<int> addTime = const Value.absent(),
            required String statuses,
            required DateTime createdAt,
            required DateTime changedAt,
            Value<String> orderx = const Value.absent(),
            Value<bool> hideGlobally = const Value.absent(),
            Value<bool> onlyShowUnread = const Value.absent(),
            Value<int> deleted = const Value.absent(),
          }) =>
              FiltersTableCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            icon: icon,
            feedIds: feedIds,
            publishedTime: publishedTime,
            addTime: addTime,
            statuses: statuses,
            createdAt: createdAt,
            changedAt: changedAt,
            orderx: orderx,
            hideGlobally: hideGlobally,
            onlyShowUnread: onlyShowUnread,
            deleted: deleted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FiltersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FiltersTableTable,
    FilterRow,
    $$FiltersTableTableFilterComposer,
    $$FiltersTableTableOrderingComposer,
    $$FiltersTableTableAnnotationComposer,
    $$FiltersTableTableCreateCompanionBuilder,
    $$FiltersTableTableUpdateCompanionBuilder,
    (FilterRow, BaseReferences<_$AppDatabase, $FiltersTableTable, FilterRow>),
    FilterRow,
    PrefetchHooks Function()>;
typedef $$EntriesTableTableCreateCompanionBuilder = EntriesTableCompanion
    Function({
  Value<BigInt> id,
  required BigInt userId,
  required BigInt feedId,
  required String status,
  required String hash,
  required String title,
  Value<String> url,
  Value<String> content,
  Value<String> author,
  Value<int> readingTime,
  Value<String> summary,
  Value<bool> starred,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
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
  Value<String> content,
  Value<String> author,
  Value<int> readingTime,
  Value<String> summary,
  Value<bool> starred,
  Value<DateTime> publishedAt,
  Value<DateTime> createdAt,
  Value<DateTime> changedAt,
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

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get readingTime => $composableBuilder(
      column: $table.readingTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get starred => $composableBuilder(
      column: $table.starred, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get readingTime => $composableBuilder(
      column: $table.readingTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get starred => $composableBuilder(
      column: $table.starred, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<int> get readingTime => $composableBuilder(
      column: $table.readingTime, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<bool> get starred =>
      $composableBuilder(column: $table.starred, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $$EntriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntriesTableTable,
    EntryRow,
    $$EntriesTableTableFilterComposer,
    $$EntriesTableTableOrderingComposer,
    $$EntriesTableTableAnnotationComposer,
    $$EntriesTableTableCreateCompanionBuilder,
    $$EntriesTableTableUpdateCompanionBuilder,
    (EntryRow, BaseReferences<_$AppDatabase, $EntriesTableTable, EntryRow>),
    EntryRow,
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
            Value<String> content = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<int> readingTime = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              EntriesTableCompanion(
            id: id,
            userId: userId,
            feedId: feedId,
            status: status,
            hash: hash,
            title: title,
            url: url,
            content: content,
            author: author,
            readingTime: readingTime,
            summary: summary,
            starred: starred,
            publishedAt: publishedAt,
            createdAt: createdAt,
            changedAt: changedAt,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required BigInt feedId,
            required String status,
            required String hash,
            required String title,
            Value<String> url = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<int> readingTime = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<bool> starred = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              EntriesTableCompanion.insert(
            id: id,
            userId: userId,
            feedId: feedId,
            status: status,
            hash: hash,
            title: title,
            url: url,
            content: content,
            author: author,
            readingTime: readingTime,
            summary: summary,
            starred: starred,
            publishedAt: publishedAt,
            createdAt: createdAt,
            changedAt: changedAt,
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
    EntryRow,
    $$EntriesTableTableFilterComposer,
    $$EntriesTableTableOrderingComposer,
    $$EntriesTableTableAnnotationComposer,
    $$EntriesTableTableCreateCompanionBuilder,
    $$EntriesTableTableUpdateCompanionBuilder,
    (EntryRow, BaseReferences<_$AppDatabase, $EntriesTableTable, EntryRow>),
    EntryRow,
    PrefetchHooks Function()>;
typedef $$MediasTableTableCreateCompanionBuilder = MediasTableCompanion
    Function({
  Value<BigInt> id,
  required BigInt userId,
  required BigInt entryId,
  required String url,
  required String mimeType,
  required int size,
});
typedef $$MediasTableTableUpdateCompanionBuilder = MediasTableCompanion
    Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<BigInt> entryId,
  Value<String> url,
  Value<String> mimeType,
  Value<int> size,
});

class $$MediasTableTableFilterComposer
    extends Composer<_$AppDatabase, $MediasTableTable> {
  $$MediasTableTableFilterComposer({
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

  ColumnFilters<BigInt> get entryId => $composableBuilder(
      column: $table.entryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));
}

class $$MediasTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MediasTableTable> {
  $$MediasTableTableOrderingComposer({
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

  ColumnOrderings<BigInt> get entryId => $composableBuilder(
      column: $table.entryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));
}

class $$MediasTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediasTableTable> {
  $$MediasTableTableAnnotationComposer({
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

  GeneratedColumn<BigInt> get entryId =>
      $composableBuilder(column: $table.entryId, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);
}

class $$MediasTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediasTableTable,
    MediaRow,
    $$MediasTableTableFilterComposer,
    $$MediasTableTableOrderingComposer,
    $$MediasTableTableAnnotationComposer,
    $$MediasTableTableCreateCompanionBuilder,
    $$MediasTableTableUpdateCompanionBuilder,
    (MediaRow, BaseReferences<_$AppDatabase, $MediasTableTable, MediaRow>),
    MediaRow,
    PrefetchHooks Function()> {
  $$MediasTableTableTableManager(_$AppDatabase db, $MediasTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediasTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediasTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediasTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            Value<BigInt> userId = const Value.absent(),
            Value<BigInt> entryId = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<String> mimeType = const Value.absent(),
            Value<int> size = const Value.absent(),
          }) =>
              MediasTableCompanion(
            id: id,
            userId: userId,
            entryId: entryId,
            url: url,
            mimeType: mimeType,
            size: size,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required BigInt entryId,
            required String url,
            required String mimeType,
            required int size,
          }) =>
              MediasTableCompanion.insert(
            id: id,
            userId: userId,
            entryId: entryId,
            url: url,
            mimeType: mimeType,
            size: size,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MediasTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MediasTableTable,
    MediaRow,
    $$MediasTableTableFilterComposer,
    $$MediasTableTableOrderingComposer,
    $$MediasTableTableAnnotationComposer,
    $$MediasTableTableCreateCompanionBuilder,
    $$MediasTableTableUpdateCompanionBuilder,
    (MediaRow, BaseReferences<_$AppDatabase, $MediasTableTable, MediaRow>),
    MediaRow,
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
  $$FiltersTableTableTableManager get filtersTable =>
      $$FiltersTableTableTableManager(_db, _db.filtersTable);
  $$EntriesTableTableTableManager get entriesTable =>
      $$EntriesTableTableTableManager(_db, _db.entriesTable);
  $$MediasTableTableTableManager get mediasTable =>
      $$MediasTableTableTableManager(_db, _db.mediasTable);
}
