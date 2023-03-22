// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskRepositoryHash() => r'379f4c4eeb0272a234b681542934aa64afe3b166';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$getTaskHash() => r'0ec91647da24ed97a1bb04810a6be3abd4ad85b9';

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

typedef GetTaskRef = AutoDisposeFutureProviderRef<Task?>;

/// See also [getTask].
@ProviderFor(getTask)
const getTaskProvider = GetTaskFamily();

/// See also [getTask].
class GetTaskFamily extends Family<AsyncValue<Task?>> {
  /// See also [getTask].
  const GetTaskFamily();

  /// See also [getTask].
  GetTaskProvider call({
    required String taskId,
  }) {
    return GetTaskProvider(
      taskId: taskId,
    );
  }

  @override
  GetTaskProvider getProviderOverride(
    covariant GetTaskProvider provider,
  ) {
    return call(
      taskId: provider.taskId,
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
  String? get name => r'getTaskProvider';
}

/// See also [getTask].
class GetTaskProvider extends AutoDisposeFutureProvider<Task?> {
  /// See also [getTask].
  GetTaskProvider({
    required this.taskId,
  }) : super.internal(
          (ref) => getTask(
            ref,
            taskId: taskId,
          ),
          from: getTaskProvider,
          name: r'getTaskProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTaskHash,
          dependencies: GetTaskFamily._dependencies,
          allTransitiveDependencies: GetTaskFamily._allTransitiveDependencies,
        );

  final String taskId;

  @override
  bool operator ==(Object other) {
    return other is GetTaskProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
