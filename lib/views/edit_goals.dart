import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanofit/models/users_record.dart';
import 'package:kanofit/components/date_picker.dart';
import 'package:kanofit/controllers/edit_goals_controller.dart';

import '../../components/profile_image.dart';
import '../../components/text_field.dart';
import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '/classes/utils.dart';
import '../components/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditGoalsPage extends StatefulWidget {
  const EditGoalsPage({Key? key}) : super(key: key);

  @override
  _EditGoalsPageState createState() => _EditGoalsPageState();
}

class _EditGoalsPageState extends State<EditGoalsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = EditGoalsController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord?>(
      stream: UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}')),
      builder: (context, snapshot) {
        UsersRecord? user = snapshot.data;

        if (!snapshot.hasData || user == null) {
          print('snapshot has no data');
          print(snapshot.hasError);
          if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
          }

          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitFadingCircle(
                color: MainTheme.of(context).primaryColor,
                size: 50.0,
              ),
            ),
          );
        }

        final profilePageUsersRecord = user;
        _controller.textController.text = profilePageUsersRecord.goalWeight?.toString() ?? '';

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 24.0,
              ),
            ),
            title: Text(
              'Moje ciele',
              style: MainTheme.of(context).bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF14181B),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFDBE2E7),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => ProfileImage(
                            imageUrl: valueOrDefault<String>(
                              profilePageUsersRecord.photoUrl,
                              'https://images.unsplash.com/photo-1680393339458-d4c8d4e55249?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                      child: CustomTextField(
                        controller: _controller.textController,
                        labelText: 'Cieľová váha',
                        hintText: '',
                        keyboardType: TextInputType.number,
                        initialValue: profilePageUsersRecord.goalWeight.toString(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
                      child: CustomDatePicker(
                          labelText: 'Cieľový dátum',
                          initialDate: profilePageUsersRecord.goalDate,
                          firstDate: DateTime.now().add(
                            Duration(days: 1),
                          ),
                          lastDate: DateTime.now().add(
                            Duration(days: 3650),
                          ),
                          onDateChanged: (date) => {
                                setState(() {
                                  _controller.goalDate = date;
                                })
                              }),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtonWidget(
                            onPressed: () async {
                              final usersUpdateData = {
                                'goal_weight': _controller.textController.text,
                                'goal_date': _controller.goalDate,
                              };
                              await currentUserReference?.update(usersUpdateData);
                              Navigator.pop(context);
                            },
                            text: 'Uložiť zmeny',
                            options: CustomButtonOptions(
                              width: 110.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: Colors.white,
                              textStyle: MainTheme.of(context).bodyText2.override(
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
