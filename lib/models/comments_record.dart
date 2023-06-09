import 'dart:async';

import 'package:kanofit/models/index.dart';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'comments_record.g.dart';

abstract class UserDataRecord implements Built<UserDataRecord, CommentsRecordBuilder> {
  static Serializer<UserDataRecord> get serializer => _$commentsRecordSerializer;

  String? get email;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  String? get uid;

  @BuiltValueField(wireName: 'goal_weight')
  double? get goalWeight;

  @BuiltValueField(wireName: 'gender')
  String? get gender;

  @BuiltValueField(wireName: 'goal_date')
  DateTime? get goalDate;

  @BuiltValueField(wireName: 'height')
  int? get height;

  @BuiltValueField(wireName: 'birth_date')
  DateTime? get birthDate;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CommentsRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..uid = '';

  static CollectionReference get collection => FirebaseFirestore.instance.collection('comments');

  static Stream<UserDataRecord> getDocument(DocumentReference ref) => ref.snapshots().map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UserDataRecord> getDocumentOnce(DocumentReference ref) => ref.get().then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UserDataRecord._();
  factory UserDataRecord([void Function(CommentsRecordBuilder) updates]) = _$CommentsRecord;

  static UserDataRecord getDocumentFromData(Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer, {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCommentsRecordData({
  String? email,
  String? displayName,
  String? uid,
  String? photoUrl,
  double? goalWeight,
  String? gender,
  int? height,
  DateTime? goalDate,
  DateTime? birthDate,
  DateTime? createdTime,
}) {
  birthDate = birthDate ?? DateTime(1990);
  createdTime = createdTime ?? DateTime.now();
  final firestoreData = serializers.toFirestore(
    UserDataRecord.serializer,
    UserDataRecord((c) => c
      ..email = email
      ..displayName = displayName
      ..uid = uid
      ..goalWeight = goalWeight
      ..gender = gender
      ..height = height
      ..goalDate = goalDate
      ..photoUrl = photoUrl
      ..birthDate = birthDate
      ..createdTime = createdTime),
  );

  return firestoreData;
}
