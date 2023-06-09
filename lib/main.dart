import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_translate/google_translate.dart';
import 'package:kanofit/models/users_record.dart';
import 'package:kanofit/components/profile_image.dart';
import 'package:kanofit/views/kcal_calculator.dart';
import 'package:kanofit/views/measurement_input.dart';
import 'package:kanofit/views/measurements.dart';
import 'package:kanofit/views/random_recipe.dart';
import 'package:kanofit/views/statistics.dart';
import 'package:kanofit/views/login.dart';
import 'package:kanofit/views/profile.dart';
import 'package:kanofit/views/silhouette.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';
import 'classes/main_theme.dart';
import 'classes/utils.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleTranslate.initialize(
    apiKey: "--",
    sourceLanguage: "en",
    targetLanguage: "sk",
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  late Stream<KanofitFirebaseUser> userStream;
  KanofitFirebaseUser? initialUser;
  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();
    userStream = kanofitFirebaseUserStream()..listen((user) => setState(() => initialUser = user));
    Future.delayed(
      Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kanofit',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: initialUser == null || displaySplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(
                    'assets/images/login_BG.png',
                    width: MediaQuery.of(context).size.width * 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : currentUser!.loggedIn && currentUser!.hasGoalInfo
              ? NavBarPage()
              : LoginWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'silhouette';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          StreamBuilder<UsersRecord>(
              stream: UsersRecord.getDocument(FirebaseFirestore.instance.doc('comments/${FirebaseAuth.instance.currentUser!.uid}')),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return SizedBox.shrink();
                final userRecord = snapshot.data;
                return DrawerHeader(
                  decoration: BoxDecoration(
                    color: MainTheme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileImage(
                        imageUrl: valueOrDefault<String>(
                          userRecord?.photoUrl,
                          'https://images.unsplash.com/photo-1680393339458-d4c8d4e55249?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                        ),
                      ),
                      Text(
                        userRecord?.displayName ?? '',
                        style: MainTheme.of(context).subtitle1.override(
                              fontFamily: 'Poppins',
                              color: MainTheme.of(context).white,
                            ),
                      )
                    ],
                  ),
                );
              }),
          ListTile(
            leading: Icon(Icons.set_meal),
            title: Text('Náhodný recept na chudnutie'),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomRecipePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.accessibility_new_outlined),
            title: Text('Predošlé merania'),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeasurementsPage(uid: currentUserUid),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Odhlásiť sa'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginWidget(),
                ),
                (r) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {'silhouette': SilhouetteWidget(), 'caloriesCalculator': KcalCalculator(), 'profile': ProfilePageWidget(), 'statistics': StatisticsPage()};
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      drawer: buildDrawer(context),
      appBar: AppBar(
        backgroundColor: MainTheme.of(context).secondaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Fitness',
          style: MainTheme.of(context).title1.override(
                fontFamily: 'Poppins',
                color: MainTheme.of(context).primaryColor,
              ),
        ),
        actions: [],
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              Icons.menu,
              color: MainTheme.of(context).primaryColor,
              size: 30,
            ),
            iconSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      floatingActionButton: _currentPageName == 'silhouette'
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MeasurementInput(title: 'Nové meranie'),
                    ));
              },
              backgroundColor: MainTheme.of(context).primaryColor,
              elevation: 8,
              child: Icon(
                Icons.add,
                color: MainTheme.of(context).secondaryColor,
                size: 24,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: MainTheme.of(context).secondaryColor,
        selectedItemColor: MainTheme.of(context).primaryColor,
        unselectedItemColor: MainTheme.of(context).iconGray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility_new_outlined,
              size: 24.0,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calculate_outlined,
              size: 24.0,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.person,
              size: 24.0,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monitor_heart_outlined,
              size: 24.0,
            ),
            activeIcon: Icon(
              Icons.monitor_heart,
              size: 24.0,
            ),
            label: 'Home',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
