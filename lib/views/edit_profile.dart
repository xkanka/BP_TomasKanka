import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/models/users_record.dart';
import 'package:kanofit/components/app_bar_dialog.dart';
import 'package:kanofit/components/date_picker.dart';
import 'package:kanofit/controllers/edit_profile_controller.dart';

import '../../auth/firebase_user_provider.dart';
import '../../components/profile_image.dart';
import '../../components/text_field.dart';
import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '/classes/utils.dart';
import '../components/util_widgets.dart';
import 'package:flutter/material.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late EditProfileController _controller;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime birthDate = DateTime(1990);

  @override
  void initState() {
    super.initState();
    _controller = EditProfileController(currentUserDocument?.displayName ?? 'Not set', currentUserDocument?.birthDate ?? DateTime(1990));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarDialog(
        scaffoldKey: scaffoldKey,
        title: 'Upraviť profil',
      ),
      body: SafeArea(
        child: StreamBuilder<UsersRecord?>(
          stream: UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}')),
          builder: (context, snapshot) {
            final currentUser = snapshot.data;
            if (!snapshot.hasData || currentUser == null) {
              return Center(child: CircularProgressIndicator());
            }

            _controller.birthDate = currentUser.birthDate ?? DateTime(1990);
            _controller.textController = TextEditingController(text: currentUser.displayName ?? 'Not set');
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImage(
                      imageUrl: valueOrDefault<String>(
                        currentUser.photoUrl,
                        'https://images.unsplash.com/photo-1680393339458-d4c8d4e55249?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonWidget(
                        onPressed: () async {
                          await _controller.uploadProfilePicture(currentUserUid);
                        },
                        text: 'Zmeniť fotku',
                        options: CustomButtonOptions(
                          width: 130.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: Colors.white,
                          textStyle: MainTheme.of(context).bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: MainTheme.of(context).primaryColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                    child: CustomTextField(
                      controller: _controller.textController!,
                      labelText: 'Meno a priezvisko',
                      initialValue: currentUser.displayName ?? 'Not set',
                      hintText: '',
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                  child: CustomDatePicker(
                    labelText: 'Dátum narodenia',
                    initialDate: _controller.birthDate,
                    onDateChanged: (date) {
                      setState(() => {
                            if (date != null) {_controller.birthDate = date}
                          });
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: CustomButtonWidget(
                      onPressed: () async {
                        _controller.saveChanges(context, currentUserReference);
                      },
                      text: 'Uložiť zmeny',
                      options: CustomButtonOptions(
                        width: 340.0,
                        height: 60.0,
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: MainTheme.of(context).primaryColor,
                        textStyle: MainTheme.of(context).subtitle2.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
