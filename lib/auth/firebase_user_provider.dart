import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/models/comments_record.dart';
import 'package:rxdart/rxdart.dart';

class KanofitFirebaseUser {
  KanofitFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
  bool get hasGoalInfo =>
      currentUserDocument?.goalWeight != null &&
      currentUserDocument?.height != null &&
      currentUserDocument?.goalDate != null &&
      currentUserDocument?.birthDate != null;
}

KanofitFirebaseUser? currentUser;
UserDataRecord? currentUserDocument;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<KanofitFirebaseUser> kanofitFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn ? TimerStream(true, const Duration(seconds: 1)) : Stream.value(user))
        .map<KanofitFirebaseUser>(
      (user) {
        currentUser = KanofitFirebaseUser(user);
        return currentUser!;
      },
    );
