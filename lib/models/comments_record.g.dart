// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserDataRecord> _$commentsRecordSerializer =
    new _$CommentsRecordSerializer();

class _$CommentsRecordSerializer
    implements StructuredSerializer<UserDataRecord> {
  @override
  final Iterable<Type> types = const [UserDataRecord, _$CommentsRecord];
  @override
  final String wireName = 'CommentsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserDataRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.goalDate;
    if (value != null) {
      result
        ..add('goal_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.goalWeight;
    if (value != null) {
      result
        ..add('goal_weight')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.gender;
    if (value != null) {
      result
        ..add('gender')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.height;
    if (value != null) {
      result
        ..add('height')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.birthDate;
    if (value != null) {
      result
        ..add('birth_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  UserDataRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'goal_date':
          result.goalDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'goal_weight':
          result.goalWeight = double.tryParse(value.toString());
          break;
        case 'gender':
          result.gender = value.toString();
          break;
        case 'height':
          result.height = int.tryParse(value.toString());
          break;
        case 'birth_date':
          result.birthDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$CommentsRecord extends UserDataRecord {
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? uid;
  @override
  final DateTime? createdTime;
  @override
  final DocumentReference<Object?>? ffRef;
  @override
  final DateTime? goalDate;
  @override
  final double? goalWeight;
  @override
  final String? gender;
  @override
  final int? height;
  @override
  final DateTime? birthDate;
  @override
  final String? photoUrl;

  factory _$CommentsRecord([void Function(CommentsRecordBuilder)? updates]) =>
      (new CommentsRecordBuilder()..update(updates))._build();

  _$CommentsRecord._(
      {this.email,
      this.displayName,
      this.uid,
      this.createdTime,
      this.goalDate,
      this.goalWeight,
      this.gender,
      this.height,
      this.birthDate,
      this.photoUrl,
      this.ffRef})
      : super._();

  @override
  UserDataRecord rebuild(void Function(CommentsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentsRecordBuilder toBuilder() =>
      new CommentsRecordBuilder()..replace(this);
}

class CommentsRecordBuilder
    implements Builder<UserDataRecord, CommentsRecordBuilder> {
  _$CommentsRecord? _$v;

  DocumentReference<Object?>? _user;
  DocumentReference<Object?>? get user => _$this._user;

  set user(DocumentReference<Object?>? user) => _$this._user = user;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  DateTime? _createdTime;
  DateTime? get createdTime => _$this._createdTime;
  set createdTime(DateTime? createdTime) => _$this._createdTime = createdTime;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  DateTime? _goalDate;
  DateTime? get goalDate => _$this._goalDate;
  set goalDate(DateTime? goalDate) => _$this._goalDate = goalDate;

  double? _goalWeight;
  double? get goalWeight => _$this._goalWeight;
  set goalWeight(double? goalWeight) => _$this._goalWeight = goalWeight;

  DateTime? _birthDate;
  DateTime? get birthDate => _$this._birthDate;
  set birthDate(DateTime? birthDate) => _$this._birthDate = birthDate;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CommentsRecordBuilder() {
    UserDataRecord._initializeBuilder(this);
  }

  CommentsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _displayName = $v.displayName;
      _uid = $v.uid;
      _goalDate = $v.goalDate;
      _height = $v.height;
      _photoUrl = $v.photoUrl;
      _gender = $v.gender;
      _goalWeight = $v.goalWeight;
      _birthDate = $v.birthDate;
      _createdTime = $v.createdTime;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDataRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommentsRecord;
  }

  @override
  void update(void Function(CommentsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDataRecord build() => _build();

  _$CommentsRecord _build() {
    final _$result = _$v ??
        new _$CommentsRecord._(
            email: email,
            displayName: displayName,
            goalDate: goalDate,
            height: height,
            goalWeight: goalWeight,
            birthDate: birthDate,
            photoUrl: photoUrl,
            gender: gender,
            uid: uid,
            createdTime: createdTime,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
