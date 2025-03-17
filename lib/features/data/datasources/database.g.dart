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
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, feedUrl, siteUrl, title, unread, read];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeds_table';
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
  const FeedEntity(
      {required this.id,
      required this.userId,
      required this.feedUrl,
      required this.siteUrl,
      required this.title,
      required this.unread,
      required this.read});
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
    };
  }

  FeedEntity copyWith(
          {BigInt? id,
          BigInt? userId,
          String? feedUrl,
          String? siteUrl,
          String? title,
          int? unread,
          int? read}) =>
      FeedEntity(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        feedUrl: feedUrl ?? this.feedUrl,
        siteUrl: siteUrl ?? this.siteUrl,
        title: title ?? this.title,
        unread: unread ?? this.unread,
        read: read ?? this.read,
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
          ..write('read: $read')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, feedUrl, siteUrl, title, unread, read);
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
          other.read == this.read);
}

class FeedsTableCompanion extends UpdateCompanion<FeedEntity> {
  final Value<BigInt> id;
  final Value<BigInt> userId;
  final Value<String> feedUrl;
  final Value<String> siteUrl;
  final Value<String> title;
  final Value<int> unread;
  final Value<int> read;
  const FeedsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.feedUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.unread = const Value.absent(),
    this.read = const Value.absent(),
  });
  FeedsTableCompanion.insert({
    this.id = const Value.absent(),
    required BigInt userId,
    required String feedUrl,
    required String siteUrl,
    required String title,
    this.unread = const Value.absent(),
    this.read = const Value.absent(),
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
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (feedUrl != null) 'feed_url': feedUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (title != null) 'title': title,
      if (unread != null) 'unread': unread,
      if (read != null) 'read': read,
    });
  }

  FeedsTableCompanion copyWith(
      {Value<BigInt>? id,
      Value<BigInt>? userId,
      Value<String>? feedUrl,
      Value<String>? siteUrl,
      Value<String>? title,
      Value<int>? unread,
      Value<int>? read}) {
    return FeedsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      unread: unread ?? this.unread,
      read: read ?? this.read,
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
          ..write('read: $read')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsTableTable feedsTable = $FeedsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [feedsTable];
}

typedef $$FeedsTableTableCreateCompanionBuilder = FeedsTableCompanion Function({
  Value<BigInt> id,
  required BigInt userId,
  required String feedUrl,
  required String siteUrl,
  required String title,
  Value<int> unread,
  Value<int> read,
});
typedef $$FeedsTableTableUpdateCompanionBuilder = FeedsTableCompanion Function({
  Value<BigInt> id,
  Value<BigInt> userId,
  Value<String> feedUrl,
  Value<String> siteUrl,
  Value<String> title,
  Value<int> unread,
  Value<int> read,
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
          }) =>
              FeedsTableCompanion(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            unread: unread,
            read: read,
          ),
          createCompanionCallback: ({
            Value<BigInt> id = const Value.absent(),
            required BigInt userId,
            required String feedUrl,
            required String siteUrl,
            required String title,
            Value<int> unread = const Value.absent(),
            Value<int> read = const Value.absent(),
          }) =>
              FeedsTableCompanion.insert(
            id: id,
            userId: userId,
            feedUrl: feedUrl,
            siteUrl: siteUrl,
            title: title,
            unread: unread,
            read: read,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsTableTableTableManager get feedsTable =>
      $$FeedsTableTableTableManager(_db, _db.feedsTable);
}
