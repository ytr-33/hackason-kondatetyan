// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_answer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiAnswerNotifierHash() => r'13a4986b86b5b1b3ef5de9805a35c825f7c8f8c9';

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

abstract class _$AiAnswerNotifier extends BuildlessAsyncNotifier<String> {
  late final List<num> selectedIngredients;

  FutureOr<String> build(
    List<num> selectedIngredients,
  );
}

/// See also [AiAnswerNotifier].
@ProviderFor(AiAnswerNotifier)
const aiAnswerNotifierProvider = AiAnswerNotifierFamily();

/// See also [AiAnswerNotifier].
class AiAnswerNotifierFamily extends Family<AsyncValue<String>> {
  /// See also [AiAnswerNotifier].
  const AiAnswerNotifierFamily();

  /// See also [AiAnswerNotifier].
  AiAnswerNotifierProvider call(
    List<num> selectedIngredients,
  ) {
    return AiAnswerNotifierProvider(
      selectedIngredients,
    );
  }

  @override
  AiAnswerNotifierProvider getProviderOverride(
    covariant AiAnswerNotifierProvider provider,
  ) {
    return call(
      provider.selectedIngredients,
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
  String? get name => r'aiAnswerNotifierProvider';
}

/// See also [AiAnswerNotifier].
class AiAnswerNotifierProvider
    extends AsyncNotifierProviderImpl<AiAnswerNotifier, String> {
  /// See also [AiAnswerNotifier].
  AiAnswerNotifierProvider(
    List<num> selectedIngredients,
  ) : this._internal(
          () => AiAnswerNotifier()..selectedIngredients = selectedIngredients,
          from: aiAnswerNotifierProvider,
          name: r'aiAnswerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$aiAnswerNotifierHash,
          dependencies: AiAnswerNotifierFamily._dependencies,
          allTransitiveDependencies:
              AiAnswerNotifierFamily._allTransitiveDependencies,
          selectedIngredients: selectedIngredients,
        );

  AiAnswerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectedIngredients,
  }) : super.internal();

  final List<num> selectedIngredients;

  @override
  FutureOr<String> runNotifierBuild(
    covariant AiAnswerNotifier notifier,
  ) {
    return notifier.build(
      selectedIngredients,
    );
  }

  @override
  Override overrideWith(AiAnswerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: AiAnswerNotifierProvider._internal(
        () => create()..selectedIngredients = selectedIngredients,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectedIngredients: selectedIngredients,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<AiAnswerNotifier, String> createElement() {
    return _AiAnswerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiAnswerNotifierProvider &&
        other.selectedIngredients == selectedIngredients;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectedIngredients.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AiAnswerNotifierRef on AsyncNotifierProviderRef<String> {
  /// The parameter `selectedIngredients` of this provider.
  List<num> get selectedIngredients;
}

class _AiAnswerNotifierProviderElement
    extends AsyncNotifierProviderElement<AiAnswerNotifier, String>
    with AiAnswerNotifierRef {
  _AiAnswerNotifierProviderElement(super.provider);

  @override
  List<num> get selectedIngredients =>
      (origin as AiAnswerNotifierProvider).selectedIngredients;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
