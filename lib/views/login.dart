import '/classes/main_theme.dart';
import '/classes/utils.dart';
import '../components/util_widgets.dart';
import '/views/change_password.dart';
import '/views/create_account.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kanofit/controllers/login_controller.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  LoginController _controller = LoginController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _controller.emailAddressController ??= TextEditingController();
    _controller.passwordController ??= TextEditingController();
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
      body: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 1.0,
        decoration: BoxDecoration(
          color: Color(0xFF262D34),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/login_BG.png',
            ).image,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //LogoSection(),
              LoginSection(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.0, 70.0, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 255.0,
            height: 50.0,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }
}

class LoginSection extends StatelessWidget {
  final LoginController controller;

  LoginSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 36.0, 0.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: MainTheme.of(context).white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginHeader(),
              EmailInputField(controller: controller),
              PasswordInputField(controller: controller),
              LoginButtons(controller: controller),
              DividerSection(),
              CreateAccountButton()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: AutoSizeText(
              'Prihlásenie',
              style: MainTheme.of(context).title1,
            ),
          ),
        ],
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  final LoginController controller;

  EmailInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.emailAddressController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: MainTheme.of(context).bodyText1.override(
                      fontFamily: 'Overpass',
                      color: Color(0xFF95A1AC),
                    ),
                hintStyle: MainTheme.of(context).bodyText1.override(
                      fontFamily: 'Overpass',
                      color: Color(0xFF95A1AC),
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
                fillColor: MainTheme.of(context).white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 24.0),
              ),
              style: MainTheme.of(context).bodyText1.override(
                    fontFamily: 'Overpass',
                    color: Color(0xFF2B343A),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInputField extends StatefulWidget {
  final LoginController controller;

  PasswordInputField({required this.controller});

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller.passwordController,
              obscureText: !widget.controller.passwordVisibility,
              decoration: InputDecoration(
                labelText: 'Heslo',
                labelStyle: MainTheme.of(context).bodyText1.override(
                      fontFamily: 'Overpass',
                      color: Color(0xFF95A1AC),
                    ),
                hintStyle: MainTheme.of(context).bodyText1.override(
                      fontFamily: 'Overpass',
                      color: Color(0xFF95A1AC),
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
                fillColor: MainTheme.of(context).white,
                contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 24.0),
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () => widget.controller.passwordVisibility = !widget.controller.passwordVisibility,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    widget.controller.passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Color(0xFF95A1AC),
                    size: 22.0,
                  ),
                ),
              ),
              style: MainTheme.of(context).bodyText1.override(
                    fontFamily: 'Overpass',
                    color: Color(0xFF2B343A),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
      child: CustomButtonWidget(
        onPressed: () async {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 250),
              reverseDuration: Duration(milliseconds: 250),
              child: CreateAccountWidget(),
            ),
          );
        },
        text: 'Vytvorit účet',
        options: CustomButtonOptions(
          width: 170.0,
          height: 40.0,
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          color: MainTheme.of(context).white,
          textStyle: MainTheme.of(context).subtitle2.override(
                fontFamily: 'Overpass',
                color: MainTheme.of(context).primaryColor,
              ),
          elevation: 0.0,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

class DividerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2.0,
      thickness: 2.0,
      indent: 20.0,
      endIndent: 20.0,
      color: Color(0xFFDBE2E7),
    );
  }
}

class LoginButtons extends StatelessWidget {
  final LoginController controller;

  LoginButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ForgotPasswordButton(),
          LoginButton(controller: controller),
        ],
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePasswordWidget(),
          ),
        );
      },
      text: 'Zabudnuté heslo',
      options: CustomButtonOptions(
        width: 120.0,
        height: 40.0,
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: MainTheme.of(context).white,
        textStyle: MainTheme.of(context).subtitle2.override(
              fontFamily: 'Overpass',
              color: Color(0xFF090F13),
              fontSize: 12.0,
            ),
        elevation: 0.0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginController controller;

  LoginButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      onPressed: () async {
        await controller.login(context);
      },
      text: 'Prihlásiť sa',
      options: CustomButtonOptions(
        width: 130.0,
        height: 50.0,
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: MainTheme.of(context).primaryColor,
        textStyle: MainTheme.of(context).subtitle2.override(
              fontFamily: 'Overpass',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
        elevation: 2.0,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
