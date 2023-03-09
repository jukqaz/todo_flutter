// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as String,
      email: json['email'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskFilterNotifierHash() =>
    r'd8df88888d5b49513f9d249e6d842c6e428fe9ea';

/// See also [TaskFilterNotifier].
@ProviderFor(TaskFilterNotifier)
final taskFilterNotifierProvider =
    AutoDisposeNotifierProvider<TaskFilterNotifier, TaskFilter>.internal(
  TaskFilterNotifier.new,
  name: r'taskFilterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskFilterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskFilterNotifier = AutoDisposeNotifier<TaskFilter>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
