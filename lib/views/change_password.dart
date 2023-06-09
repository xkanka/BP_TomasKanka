import 'package:kanofit/controllers/change_password_controller.dart';

import '/auth/auth_util.dart';
import '/classes/main_theme.dart';
import '../components/util_widgets.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final ChangePasswordController _controller = ChangePasswordController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller.emailAddressController ??= TextEditingController(text: currentUserEmail);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
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
              'Reset hesla',
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
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 12.0),
                  child: TextFormField(
                    controller: _controller.emailAddressController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: MainTheme.of(context).bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Váš email',
                      hintStyle: MainTheme.of(context).bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                    ),
                    style: MainTheme.of(context).bodyText1.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF14181B),
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Pošleme vám e-mail s odkazom na obnovenie hesla, zadajte vyššie uvedený e-mail spojený s vaším účtom.',
                          style: MainTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.05),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: CustomButtonWidget(
                      onPressed: () async {
                        if (_controller.emailAddressController?.text == null || _controller.emailAddressController!.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Email je povinný',
                              ),
                            ),
                          );
                          return;
                        }
                        await resetPassword(
                          email: _controller.emailAddressController!.text,
                          context: context,
                        );
                      },
                      text: 'Zaslať odkaz na obnovenie hesla',
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
            ),
          ),
        );
      },
    );
  }
}
