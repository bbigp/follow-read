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
        content,
        author,
        starred,
        readingTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries_table';
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
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('starred: $starred, ')
          ..write('readingTime: $readingTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, feedId, status, hash, title, url,
      publishedAt, createdAt, changedAt, content, author, starred, readingTime);
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
          ..write('content: $content, ')
          ..write('author: $author, ')
          ..write('starred: $starred, ')
          ..write('readingTime: $readingTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsTableTable feedsTable = $FeedsTableTable(this);
  late final $EntriesTableTable entriesTable = $EntriesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [feedsTable, entriesTable];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsTableTableTableManager get feedsTable =>
      $$FeedsTableTableTableManager(_db, _db.feedsTable);
  $$EntriesTableTableTableManager get entriesTable =>
      $$EntriesTableTableTableManager(_db, _db.entriesTable);
}
