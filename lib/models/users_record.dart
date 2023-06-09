import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  String? get email;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  String? get uid;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: 'goal_weight')
  double? get goalWeight;

  @BuiltValueField(wireName: 'height')
  int? get height;

  @BuiltValueField(wireName: 'goal_date')
  DateTime? get goalDate;

  @BuiltValueField(wireName: 'birth_date')
  DateTime? get birthDate;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..goalWeight = null
    ..height = null
    ..goalDate = null
    ..birthDate = DateTime.now()
    ..uid = '';

  static CollectionReference get collection => FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) {
    return ref.snapshots().map((DocumentSnapshot snapshot) {
      // print("Snapshot exists: ${snapshot.exists}");
      return serializers.deserializeWith(serializer, serializedData(snapshot))!;
    });
  }

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref.get().then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) = _$UsersRecord;

  static UsersRecord getDocumentFromData(Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer, {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  double? goalWeight,
  int? height,
  DateTime? goalDate,
  DateTime? birthDate,
  DateTime? createdTime,
}) {
  final firestoreData = serializers.toFirestore(
    UsersRecord.serializer,
    UsersRecord((u) => u
      ..email = email
      ..displayName = displayName
      ..photoUrl = photoUrl
      ..uid = uid
      ..height = height
      ..goalWeight = goalWeight
      ..goalDate = goalDate
      ..birthDate = birthDate
      ..createdTime = createdTime),
  );

  return firestoreData;
}
