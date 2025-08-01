// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'chats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatsNotifierHash() => r'37d723287ea5f7b86a0a69744be62a52bdd6ed00';

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

abstract class _$ChatsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatRoom>> {
  late final bool showEmpty;

  FutureOr<List<ChatRoom>> build({bool showEmpty = false});
}

/// See also [ChatsNotifier].
@ProviderFor(ChatsNotifier)
const chatsNotifierProvider = ChatsNotifierFamily();

/// See also [ChatsNotifier].
class ChatsNotifierFamily extends Family<AsyncValue<List<ChatRoom>>> {
  /// See also [ChatsNotifier].
  const ChatsNotifierFamily();

  /// See also [ChatsNotifier].
  ChatsNotifierProvider call({bool showEmpty = false}) {
    return ChatsNotifierProvider(showEmpty: showEmpty);
  }

  @override
  ChatsNotifierProvider getProviderOverride(
    covariant ChatsNotifierProvider provider,
  ) {
    return call(showEmpty: provider.showEmpty);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatsNotifierProvider';
}

/// See also [ChatsNotifier].
class ChatsNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<ChatsNotifier, List<ChatRoom>> {
  /// See also [ChatsNotifier].
  ChatsNotifierProvider({bool showEmpty = false})
    : this._internal(
        () => ChatsNotifier()..showEmpty = showEmpty,
        from: chatsNotifierProvider,
        name: r'chatsNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatsNotifierHash,
        dependencies: ChatsNotifierFamily._dependencies,
        allTransitiveDependencies:
            ChatsNotifierFamily._allTransitiveDependencies,
        showEmpty: showEmpty,
      );

  ChatsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.showEmpty,
  }) : super.internal();

  final bool showEmpty;

  @override
  FutureOr<List<ChatRoom>> runNotifierBuild(covariant ChatsNotifier notifier) {
    return notifier.build(showEmpty: showEmpty);
  }

  @override
  Override overrideWith(ChatsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatsNotifierProvider._internal(
        () => create()..showEmpty = showEmpty,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        showEmpty: showEmpty,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatsNotifier, List<ChatRoom>>
  createElement() {
    return _ChatsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatsNotifierProvider && other.showEmpty == showEmpty;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, showEmpty.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatsNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<ChatRoom>> {
  /// The parameter `showEmpty` of this provider.
  bool get showEmpty;
}

class _ChatsNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ChatsNotifier, List<ChatRoom>>
    with ChatsNotifierRef {
  _ChatsNotifierProviderElement(super.provider);

  @override
  bool get showEmpty => (origin as ChatsNotifierProvider).showEmpty;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
