// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FeedsDataTable extends FeedsData
    with TableInfo<$FeedsDataTable, FeedsDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedsDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _checkedAtMeta =
      const VerificationMeta('checkedAt');
  @override
  late final GeneratedColumn<String> checkedAt = GeneratedColumn<String>(
      'checked_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nextCheckAtMeta =
      const VerificationMeta('nextCheckAt');
  @override
  late final GeneratedColumn<String> nextCheckAt = GeneratedColumn<String>(
      'next_check_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int> icon = GeneratedColumn<int>(
      'icon', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _parsingErrorMsgMeta =
      const VerificationMeta('parsingErrorMsg');
  @override
  late final GeneratedColumn<String> parsingErrorMsg = GeneratedColumn<String>(
      'parsing_error_msg', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _parsingErrorCountMeta =
      const VerificationMeta('parsingErrorCount');
  @override
  late final GeneratedColumn<int> parsingErrorCount = GeneratedColumn<int>(
      'parsing_error_count', aliasedName, false,
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
  static const VerificationMeta _unreadMeta = const VerificationMeta('unread');
  @override
  late final GeneratedColumn<int> unread = GeneratedColumn<int>(
      'unread', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        feedUrl,
        siteUrl,
        title,
        description,
        checkedAt,
        nextCheckAt,
        icon,
        parsingErrorMsg,
        parsingErrorCount,
        read,
        unread
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeds_data';
  @override
  VerificationContext validateIntegrity(Insertable<FeedsDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('checked_at')) {
      context.handle(_checkedAtMeta,
          checkedAt.isAcceptableOrUnknown(data['checked_at']!, _checkedAtMeta));
    } else if (isInserting) {
      context.missing(_checkedAtMeta);
    }
    if (data.containsKey('next_check_at')) {
      context.handle(
          _nextCheckAtMeta,
          nextCheckAt.isAcceptableOrUnknown(
              data['next_check_at']!, _nextCheckAtMeta));
    } else if (isInserting) {
      context.missing(_nextCheckAtMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('parsing_error_msg')) {
      context.handle(
          _parsingErrorMsgMeta,
          parsingErrorMsg.isAcceptableOrUnknown(
              data['parsing_error_msg']!, _parsingErrorMsgMeta));
    }
    if (data.containsKey('parsing_error_count')) {
      context.handle(
          _parsingErrorCountMeta,
          parsingErrorCount.isAcceptableOrUnknown(
              data['parsing_error_count']!, _parsingErrorCountMeta));
    }
    if (data.containsKey('read')) {
      context.handle(
          _readMeta, read.isAcceptableOrUnknown(data['read']!, _readMeta));
    }
    if (data.containsKey('unread')) {
      context.handle(_unreadMeta,
          unread.isAcceptableOrUnknown(data['unread']!, _unreadMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FeedsDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedsDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      feedUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feed_url'])!,
      siteUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}site_url'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      checkedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checked_at'])!,
      nextCheckAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_check_at'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon']),
      parsingErrorMsg: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}parsing_error_msg']),
      parsingErrorCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}parsing_error_count'])!,
      read: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}read'])!,
      unread: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread'])!,
    );
  }

  @override
  $FeedsDataTable createAlias(String alias) {
    return $FeedsDataTable(attachedDatabase, alias);
  }
}

class FeedsDataData extends DataClass implements Insertable<FeedsDataData> {
  final int id;
  final int userId;
  final String feedUrl;
  final String siteUrl;
  final String title;
  final String description;
  final String checkedAt;
  final String nextCheckAt;
  final int? icon;
  final String? parsingErrorMsg;
  final int parsingErrorCount;
  final int read;
  final int unread;
  const FeedsDataData(
      {required this.id,
      required this.userId,
      required this.feedUrl,
      required this.siteUrl,
      required this.title,
      required this.description,
      required this.checkedAt,
      required this.nextCheckAt,
      this.icon,
      this.parsingErrorMsg,
      required this.parsingErrorCount,
      required this.read,
      required this.unread});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['feed_url'] = Variable<String>(feedUrl);
    map['site_url'] = Variable<String>(siteUrl);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['checked_at'] = Variable<String>(checkedAt);
    map['next_check_at'] = Variable<String>(nextCheckAt);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<int>(icon);
    }
    if (!nullToAbsent || parsingErrorMsg != null) {
      map['parsing_error_msg'] = Variable<String>(parsingErrorMsg);
    }
    map['parsing_error_count'] = Variable<int>(parsingErrorCount);
    map['read'] = Variable<int>(read);
    map['unread'] = Variable<int>(unread);
    return map;
  }

  FeedsDataCompanion toCompanion(bool nullToAbsent) {
    return FeedsDataCompanion(
      id: Value(id),
      userId: Value(userId),
      feedUrl: Value(feedUrl),
      siteUrl: Value(siteUrl),
      title: Value(title),
      description: Value(description),
      checkedAt: Value(checkedAt),
      nextCheckAt: Value(nextCheckAt),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      parsingErrorMsg: parsingErrorMsg == null && nullToAbsent
          ? const Value.absent()
          : Value(parsingErrorMsg),
      parsingErrorCount: Value(parsingErrorCount),
      read: Value(read),
      unread: Value(unread),
    );
  }

  factory FeedsDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedsDataData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      feedUrl: serializer.fromJson<String>(json['feedUrl']),
      siteUrl: serializer.fromJson<String>(json['siteUrl']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      checkedAt: serializer.fromJson<String>(json['checkedAt']),
      nextCheckAt: serializer.fromJson<String>(json['nextCheckAt']),
      icon: serializer.fromJson<int?>(json['icon']),
      parsingErrorMsg: serializer.fromJson<String?>(json['parsingErrorMsg']),
      parsingErrorCount: serializer.fromJson<int>(json['parsingErrorCount']),
      read: serializer.fromJson<int>(json['read']),
      unread: serializer.fromJson<int>(json['unread']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'feedUrl': serializer.toJson<String>(feedUrl),
      'siteUrl': serializer.toJson<String>(siteUrl),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'checkedAt': serializer.toJson<String>(checkedAt),
      'nextCheckAt': serializer.toJson<String>(nextCheckAt),
      'icon': serializer.toJson<int?>(icon),
      'parsingErrorMsg': serializer.toJson<String?>(parsingErrorMsg),
      'parsingErrorCount': serializer.toJson<int>(parsingErrorCount),
      'read': serializer.toJson<int>(read),
      'unread': serializer.toJson<int>(unread),
    };
  }

  FeedsDataData copyWith(
          {int? id,
          int? userId,
          String? feedUrl,
          String? siteUrl,
          String? title,
          String? description,
          String? checkedAt,
          String? nextCheckAt,
          Value<int?> icon = const Value.absent(),
          Value<String?> parsingErrorMsg = const Value.absent(),
          int? parsingErrorCount,
          int? read,
          int? unread}) =>
      FeedsDataData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        feedUrl: feedUrl ?? this.feedUrl,
        siteUrl: siteUrl ?? this.siteUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        checkedAt: checkedAt ?? this.checkedAt,
        nextCheckAt: nextCheckAt ?? this.nextCheckAt,
        icon: icon.present ? icon.value : this.icon,
        parsingErrorMsg: parsingErrorMsg.present
            ? parsingErrorMsg.value
            : this.parsingErrorMsg,
        parsingErrorCount: parsingErrorCount ?? this.parsingErrorCount,
        read: read ?? this.read,
        unread: unread ?? this.unread,
      );
  FeedsDataData copyWithCompanion(FeedsDataCompanion data) {
    return FeedsDataData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      feedUrl: data.feedUrl.present ? data.feedUrl.value : this.feedUrl,
      siteUrl: data.siteUrl.present ? data.siteUrl.value : this.siteUrl,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      checkedAt: data.checkedAt.present ? data.checkedAt.value : this.checkedAt,
      nextCheckAt:
          data.nextCheckAt.present ? data.nextCheckAt.value : this.nextCheckAt,
      icon: data.icon.present ? data.icon.value : this.icon,
      parsingErrorMsg: data.parsingErrorMsg.present
          ? data.parsingErrorMsg.value
          : this.parsingErrorMsg,
      parsingErrorCount: data.parsingErrorCount.present
          ? data.parsingErrorCount.value
          : this.parsingErrorCount,
      read: data.read.present ? data.read.value : this.read,
      unread: data.unread.present ? data.unread.value : this.unread,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedsDataData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedUrl: $feedUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('checkedAt: $checkedAt, ')
          ..write('nextCheckAt: $nextCheckAt, ')
          ..write('icon: $icon, ')
          ..write('parsingErrorMsg: $parsingErrorMsg, ')
          ..write('parsingErrorCount: $parsingErrorCount, ')
          ..write('read: $read, ')
          ..write('unread: $unread')
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
      description,
      checkedAt,
      nextCheckAt,
      icon,
      parsingErrorMsg,
      parsingErrorCount,
      read,
      unread);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedsDataData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.feedUrl == this.feedUrl &&
          other.siteUrl == this.siteUrl &&
          other.title == this.title &&
          other.description == this.description &&
          other.checkedAt == this.checkedAt &&
          other.nextCheckAt == this.nextCheckAt &&
          other.icon == this.icon &&
          other.parsingErrorMsg == this.parsingErrorMsg &&
          other.parsingErrorCount == this.parsingErrorCount &&
          other.read == this.read &&
          other.unread == this.unread);
}

class FeedsDataCompanion extends UpdateCompanion<FeedsDataData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> feedUrl;
  final Value<String> siteUrl;
  final Value<String> title;
  final Value<String> description;
  final Value<String> checkedAt;
  final Value<String> nextCheckAt;
  final Value<int?> icon;
  final Value<String?> parsingErrorMsg;
  final Value<int> parsingErrorCount;
  final Value<int> read;
  final Value<int> unread;
  final Value<int> rowid;
  const FeedsDataCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.checkedAt = const Value.absent(),
    this.nextCheckAt = const Value.absent(),
    this.icon = const Value.absent(),
    this.parsingErrorMsg = const Value.absent(),
    this.parsingErrorCount = const Value.absent(),
    this.read = const Value.absent(),
    this.unread = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedsDataCompanion.insert({
    required int id,
    required int userId,
    required String feedUrl,
    required String siteUrl,
    required String title,
    required String description,
    required String checkedAt,
    required String nextCheckAt,
    this.icon = const Value.absent(),
    this.parsingErrorMsg = const Value.absent(),
    this.parsingErrorCount = const Value.absent(),
    this.read = const Value.absent(),
    this.unread = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        feedUrl = Value(feedUrl),
        siteUrl = Value(siteUrl),
        title = Value(title),
        description = Value(description),
        checkedAt = Value(checkedAt),
        nextCheckAt = Value(nextCheckAt);
  static Insertable<FeedsDataData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? feedUrl,
    Expression<String>? siteUrl,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? checkedAt,
    Expression<String>? nextCheckAt,
    Expression<int>? icon,
    Expression<String>? parsingErrorMsg,
    Expression<int>? parsingErrorCount,
    Expression<int>? read,
    Expression<int>? unread,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (feedUrl != null) 'feed_url': feedUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (checkedAt != null) 'checked_at': checkedAt,
      if (nextCheckAt != null) 'next_check_at': nextCheckAt,
      if (icon != null) 'icon': icon,
      if (parsingErrorMsg != null) 'parsing_error_msg': parsingErrorMsg,
      if (parsingErrorCount != null) 'parsing_error_count': parsingErrorCount,
      if (read != null) 'read': read,
      if (unread != null) 'unread': unread,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedsDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? feedUrl,
      Value<String>? siteUrl,
      Value<String>? title,
      Value<String>? description,
      Value<String>? checkedAt,
      Value<String>? nextCheckAt,
      Value<int?>? icon,
      Value<String?>? parsingErrorMsg,
      Value<int>? parsingErrorCount,
      Value<int>? read,
      Value<int>? unread,
      Value<int>? rowid}) {
    return FeedsDataCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      checkedAt: checkedAt ?? this.checkedAt,
      nextCheckAt: nextCheckAt ?? this.nextCheckAt,
      icon: icon ?? this.icon,
      parsingErrorMsg: parsingErrorMsg ?? this.parsingErrorMsg,
      parsingErrorCount: parsingErrorCount ?? this.parsingErrorCount,
      read: read ?? this.read,
      unread: unread ?? this.unread,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (checkedAt.present) {
      map['checked_at'] = Variable<String>(checkedAt.value);
    }
    if (nextCheckAt.present) {
      map['next_check_at'] = Variable<String>(nextCheckAt.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    if (parsingErrorMsg.present) {
      map['parsing_error_msg'] = Variable<String>(parsingErrorMsg.value);
    }
    if (parsingErrorCount.present) {
      map['parsing_error_count'] = Variable<int>(parsingErrorCount.value);
    }
    if (read.present) {
      map['read'] = Variable<int>(read.value);
    }
    if (unread.present) {
      map['unread'] = Variable<int>(unread.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedsDataCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('feedUrl: $feedUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('checkedAt: $checkedAt, ')
          ..write('nextCheckAt: $nextCheckAt, ')
          ..write('icon: $icon, ')
          ..write('parsingErrorMsg: $parsingErrorMsg, ')
          ..write('parsingErrorCount: $parsingErrorCount, ')
          ..write('read: $read, ')
          ..write('unread: $unread, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsDataTable feedsData = $FeedsDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [feedsData];
}

typedef $$FeedsDataTableCreateCompanionBuilder = FeedsDataCompanion Function({
  required int id,
  required int userId,
  required String feedUrl,
  required String siteUrl,
  required String title,
  required String description,
  required String checkedAt,
  required String nextCheckAt,
  Value<int?> icon,
  Value<String?> parsingErrorMsg,
  Value<int> parsingErrorCount,
  Value<int> read,
  Value<int> unread,
  Value<int> rowid,
});
typedef $$FeedsDataTableUpdateCompanionBuilder = FeedsDataCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> feedUrl,
  Value<String> siteUrl,
  Value<String> title,
  Value<String> description,
  Value<String> checkedAt,
  Value<String> nextCheckAt,
  Value<int?> icon,
  Value<String?> parsingErrorMsg,
  Value<int> parsingErrorCount,
  Value<int> read,
  Value<int> unread,
  Value<int> rowid,
});

class $$FeedsDataTableFilterComposer
    extends Composer<_$AppDatabase, $FeedsDataTable> {
  $$FeedsDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedUrl => $composableBuilder(
      column: $table.feedUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get siteUrl => $composableBuilder(
      column: $table.siteUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get checkedAt => $composableBuilder(
      column: $table.checkedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextCheckAt => $composableBuilder(
      column: $table.nextCheckAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parsingErrorMsg => $composableBuilder(
      column: $table.parsingErrorMsg,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get parsingErrorCount => $composableBuilder(
      column: $table.parsingErrorCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get read => $composableBuilder(
      column: $table.read, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unread => $composableBuilder(
      column: $table.unread, builder: (column) => ColumnFilters(column));
}

class $$FeedsDataTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedsDataTable> {
  $$FeedsDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedUrl => $composableBuilder(
      column: $table.feedUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get siteUrl => $composableBuilder(
      column: $table.siteUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get checkedAt => $composableBuilder(
      column: $table.checkedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextCheckAt => $composableBuilder(
      column: $table.nextCheckAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parsingErrorMsg => $composableBuilder(
      column: $table.parsingErrorMsg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get parsingErrorCount => $composableBuilder(
      column: $table.parsingErrorCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get read => $composableBuilder(
      column: $table.read, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unread => $composableBuilder(
      column: $table.unread, builder: (column) => ColumnOrderings(column));
}

class $$FeedsDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedsDataTable> {
  $$FeedsDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get feedUrl =>
      $composableBuilder(column: $table.feedUrl, builder: (column) => column);

  GeneratedColumn<String> get siteUrl =>
      $composableBuilder(column: $table.siteUrl, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get checkedAt =>
      $composableBuilder(column: $table.checkedAt, builder: (column) => column);

  GeneratedColumn<String> get nextCheckAt => $composableBuilder(
      column: $table.nextCheckAt, builder: (column) => column);

  GeneratedColumn<int> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get parsingErrorMsg => $composableBuilder(
      column: $table.parsingErrorMsg, builder: (column) => column);

  GeneratedColumn<int> get parsingErrorCount => $composableBuilder(
      column: $table.parsingErrorCount, builder: (column) => column);

  GeneratedColumn<int> get read =>
      $composableBuilder(column: $table.read, builder: (column) => column);

  GeneratedColumn<int> get unread =>
      $composableBuilder(column: $table.unread, builder: (column) => column);
}

class $$FeedsDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeedsDataTable,
    FeedsDataData,
    $$FeedsDataTableFilterComposer,
    $$FeedsDataTableOrderingComposer,
    $$FeedsDataTableAnnotationComposer,
    $$FeedsDataTableCreateCompanionBuilder,
    $$FeedsDataTableUpdateCompanionBuilder,
    (
      FeedsDataData,
      BaseReferences<_$AppDatabase, $FeedsDataTable, FeedsDataData>
    ),
    FeedsDataData,
    PrefetchHooks Function()> {
  $$FeedsDataTableTableManager(_$AppDatabase db, $FeedsDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedsDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedsDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedsDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> feedUrl = const Value.absent(),
            Value<String> siteUrl = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> checkedAt = const Value.absent(),
            Value<String> nextCheckAt = const Value.absent(),
            Value<int?> icon = const Value.absent(),
            Value<String?> parsingErrorMsg = const Value.absent(),
            Value<int> parsingErrorCount = const Value.absent(),
            Value<int> read = const Value.absent(),
            Value<int> unread = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FeedsDataCompanion(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            description: description,
            checkedAt: checkedAt,
            nextCheckAt: nextCheckAt,
            icon: icon,
            parsingErrorMsg: parsingErrorMsg,
            parsingErrorCount: parsingErrorCount,
            read: read,
            unread: unread,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int id,
            required int userId,
            required String feedUrl,
            required String siteUrl,
            required String title,
            required String description,
            required String checkedAt,
            required String nextCheckAt,
            Value<int?> icon = const Value.absent(),
            Value<String?> parsingErrorMsg = const Value.absent(),
            Value<int> parsingErrorCount = const Value.absent(),
            Value<int> read = const Value.absent(),
            Value<int> unread = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FeedsDataCompanion.insert(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            description: description,
            checkedAt: checkedAt,
            nextCheckAt: nextCheckAt,
            icon: icon,
            parsingErrorMsg: parsingErrorMsg,
            parsingErrorCount: parsingErrorCount,
            read: read,
            unread: unread,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FeedsDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeedsDataTable,
    FeedsDataData,
    $$FeedsDataTableFilterComposer,
    $$FeedsDataTableOrderingComposer,
    $$FeedsDataTableAnnotationComposer,
    $$FeedsDataTableCreateCompanionBuilder,
    $$FeedsDataTableUpdateCompanionBuilder,
    (
      FeedsDataData,
      BaseReferences<_$AppDatabase, $FeedsDataTable, FeedsDataData>
    ),
    FeedsDataData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsDataTableTableManager get feedsData =>
      $$FeedsDataTableTableManager(_db, _db.feedsData);
}
