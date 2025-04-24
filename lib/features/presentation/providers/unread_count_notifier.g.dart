// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_count_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedUnreadHash() => r'd21cf754cc2c563f35f52f9a30acc138cc441b21';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [feedUnread].
@ProviderFor(feedUnread)
const feedUnreadProvider = FeedUnreadFamily();

/// See also [feedUnread].
class FeedUnreadFamily extends Family<AsyncValue<int>> {
  /// See also [feedUnread].
  const FeedUnreadFamily();

  /// See also [feedUnread].
  FeedUnreadProvider call(
    int feedId,
  ) {
    return FeedUnreadProvider(
      feedId,
    );
  }

  @override
  FeedUnreadProvider getProviderOverride(
    covariant FeedUnreadProvider provider,
  ) {
    return call(
      provider.feedId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedUnreadProvider';
}

/// See also [feedUnread].
class FeedUnreadProvider extends AutoDisposeFutureProvider<int> {
  /// See also [feedUnread].
  FeedUnreadProvider(
    int feedId,
  ) : this._internal(
          (ref) => feedUnread(
            ref as FeedUnreadRef,
            feedId,
          ),
          from: feedUnreadProvider,
          name: r'feedUnreadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$feedUnreadHash,
          dependencies: FeedUnreadFamily._dependencies,
          allTransitiveDependencies:
              FeedUnreadFamily._allTransitiveDependencies,
          feedId: feedId,
        );

  FeedUnreadProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedId,
  }) : super.internal();

  final int feedId;

  @override
  Override overrideWith(
    FutureOr<int> Function(FeedUnreadRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedUnreadProvider._internal(
        (ref) => create(ref as FeedUnreadRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedId: feedId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _FeedUnreadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedUnreadProvider && other.feedId == feedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedUnreadRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `feedId` of this provider.
  int get feedId;
}

class _FeedUnreadProviderElement extends AutoDisposeFutureProviderElement<int>
    with FeedUnreadRef {
  _FeedUnreadProviderElement(super.provider);

  @override
  int get feedId => (origin as FeedUnreadProvider).feedId;
}

String _$folderUnreadHash() => r'a326b3682a53aa2fbcde3934b2cab912986eb88e';

/// See also [folderUnread].
@ProviderFor(folderUnread)
const folderUnreadProvider = FolderUnreadFamily();

/// See also [folderUnread].
class FolderUnreadFamily extends Family<AsyncValue<int>> {
  /// See also [folderUnread].
  const FolderUnreadFamily();

  /// See also [folderUnread].
  FolderUnreadProvider call(
    String feeds,
  ) {
    return FolderUnreadProvider(
      feeds,
    );
  }

  @override
  FolderUnreadProvider getProviderOverride(
    covariant FolderUnreadProvider provider,
  ) {
    return call(
      provider.feeds,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'folderUnreadProvider';
}

/// See also [folderUnread].
class FolderUnreadProvider extends AutoDisposeFutureProvider<int> {
  /// See also [folderUnread].
  FolderUnreadProvider(
    String feeds,
  ) : this._internal(
          (ref) => folderUnread(
            ref as FolderUnreadRef,
            feeds,
          ),
          from: folderUnreadProvider,
          name: r'folderUnreadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$folderUnreadHash,
          dependencies: FolderUnreadFamily._dependencies,
          allTransitiveDependencies:
              FolderUnreadFamily._allTransitiveDependencies,
          feeds: feeds,
        );

  FolderUnreadProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feeds,
  }) : super.internal();

  final String feeds;

  @override
  Override overrideWith(
    FutureOr<int> Function(FolderUnreadRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FolderUnreadProvider._internal(
        (ref) => create(ref as FolderUnreadRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feeds: feeds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _FolderUnreadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FolderUnreadProvider && other.feeds == feeds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feeds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FolderUnreadRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `feeds` of this provider.
  String get feeds;
}

class _FolderUnreadProviderElement extends AutoDisposeFutureProviderElement<int>
    with FolderUnreadRef {
  _FolderUnreadProviderElement(super.provider);

  @override
  String get feeds => (origin as FolderUnreadProvider).feeds;
}

String _$clusterUnreadHash() => r'bb0792ddc42e0287d33d11f361931b4ac43933d4';

/// See also [clusterUnread].
@ProviderFor(clusterUnread)
const clusterUnreadProvider = ClusterUnreadFamily();

/// See also [clusterUnread].
class ClusterUnreadFamily extends Family<AsyncValue<int>> {
  /// See also [clusterUnread].
  const ClusterUnreadFamily();

  /// See also [clusterUnread].
  ClusterUnreadProvider call(
    int clusterId,
  ) {
    return ClusterUnreadProvider(
      clusterId,
    );
  }

  @override
  ClusterUnreadProvider getProviderOverride(
    covariant ClusterUnreadProvider provider,
  ) {
    return call(
      provider.clusterId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'clusterUnreadProvider';
}

/// See also [clusterUnread].
class ClusterUnreadProvider extends AutoDisposeFutureProvider<int> {
  /// See also [clusterUnread].
  ClusterUnreadProvider(
    int clusterId,
  ) : this._internal(
          (ref) => clusterUnread(
            ref as ClusterUnreadRef,
            clusterId,
          ),
          from: clusterUnreadProvider,
          name: r'clusterUnreadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clusterUnreadHash,
          dependencies: ClusterUnreadFamily._dependencies,
          allTransitiveDependencies:
              ClusterUnreadFamily._allTransitiveDependencies,
          clusterId: clusterId,
        );

  ClusterUnreadProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.clusterId,
  }) : super.internal();

  final int clusterId;

  @override
  Override overrideWith(
    FutureOr<int> Function(ClusterUnreadRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClusterUnreadProvider._internal(
        (ref) => create(ref as ClusterUnreadRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        clusterId: clusterId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _ClusterUnreadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClusterUnreadProvider && other.clusterId == clusterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, clusterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClusterUnreadRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `clusterId` of this provider.
  int get clusterId;
}

class _ClusterUnreadProviderElement
    extends AutoDisposeFutureProviderElement<int> with ClusterUnreadRef {
  _ClusterUnreadProviderElement(super.provider);

  @override
  int get clusterId => (origin as ClusterUnreadProvider).clusterId;
}

String _$unreadCountNotifierHash() =>
    r'a57e16fb63ff9dccb73c689259adc4bbfe4058f5';

/// See also [UnreadCountNotifier].
@ProviderFor(UnreadCountNotifier)
final unreadCountNotifierProvider =
    AutoDisposeAsyncNotifierProvider<UnreadCountNotifier, UnreadCount>.internal(
  UnreadCountNotifier.new,
  name: r'unreadCountNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadCountNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UnreadCountNotifier = AutoDisposeAsyncNotifier<UnreadCount>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
