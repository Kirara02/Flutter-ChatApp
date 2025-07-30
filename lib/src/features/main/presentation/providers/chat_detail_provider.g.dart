// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'chat_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDetailNotifierHash() =>
    r'8374dce235db693e710562f95746cb9e1a40fd02';

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

abstract class _$ChatDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ChatRoom?> {
  late final int roomId;

  FutureOr<ChatRoom?> build(int roomId);
}

/// See also [ChatDetailNotifier].
@ProviderFor(ChatDetailNotifier)
const chatDetailNotifierProvider = ChatDetailNotifierFamily();

/// See also [ChatDetailNotifier].
class ChatDetailNotifierFamily extends Family<AsyncValue<ChatRoom?>> {
  /// See also [ChatDetailNotifier].
  const ChatDetailNotifierFamily();

  /// See also [ChatDetailNotifier].
  ChatDetailNotifierProvider call(int roomId) {
    return ChatDetailNotifierProvider(roomId);
  }

  @override
  ChatDetailNotifierProvider getProviderOverride(
    covariant ChatDetailNotifierProvider provider,
  ) {
    return call(provider.roomId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatDetailNotifierProvider';
}

/// See also [ChatDetailNotifier].
class ChatDetailNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<ChatDetailNotifier, ChatRoom?> {
  /// See also [ChatDetailNotifier].
  ChatDetailNotifierProvider(int roomId)
    : this._internal(
        () => ChatDetailNotifier()..roomId = roomId,
        from: chatDetailNotifierProvider,
        name: r'chatDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatDetailNotifierHash,
        dependencies: ChatDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            ChatDetailNotifierFamily._allTransitiveDependencies,
        roomId: roomId,
      );

  ChatDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final int roomId;

  @override
  FutureOr<ChatRoom?> runNotifierBuild(covariant ChatDetailNotifier notifier) {
    return notifier.build(roomId);
  }

  @override
  Override overrideWith(ChatDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatDetailNotifierProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatDetailNotifier, ChatRoom?>
  createElement() {
    return _ChatDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDetailNotifierProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatDetailNotifierRef on AutoDisposeAsyncNotifierProviderRef<ChatRoom?> {
  /// The parameter `roomId` of this provider.
  int get roomId;
}

class _ChatDetailNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ChatDetailNotifier, ChatRoom?>
    with ChatDetailNotifierRef {
  _ChatDetailNotifierProviderElement(super.provider);

  @override
  int get roomId => (origin as ChatDetailNotifierProvider).roomId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
