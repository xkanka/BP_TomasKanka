import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/models/comments_record.dart';
import 'package:kanofit/models/serializers.dart';

import '../auth/firebase_user_provider.dart';
import 'utils.dart';

// Creates a Firestore document representing the logged in user if it doesn't yet exist
// TODO: We should probably move this to model before
Future maybeCreateUser(User user) async {
  final userRecord = UserDataRecord.collection.doc(user.uid);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    currentUserDocument = await UserDataRecord.getDocumentOnce(userRecord);
    return;
  }

  final userData = createCommentsRecordData(
    email: user.email,
    displayName: user.displayName,
    uid: user.uid,
    createdTime: getCurrentTimestamp,
  );

  await userRecord.set(userData);
  currentUserDocument = serializers.deserializeWith(UserDataRecord.serializer, userData);
}
