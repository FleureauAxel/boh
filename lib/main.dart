import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FunnWeb",
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: CompanyColors.black,
          fontFamily: 'Raleway'),
      home: MyHomePage(title: 'FunnWeb'),
    );
  }
}

class PulseAnimator extends StatefulWidget {
  final Widget child;
  const PulseAnimator({Key key, this.child}) : super(key: key);

  @override
  State createState() => _PulseAnimatorState();
}

class _PulseAnimatorState extends State<PulseAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: TweenAndBack(begin: 0.5, end: 1.0).animate(_controller),
      child: widget.child,
    );
  }

  TweenAndBack({double begin, double end}) {}
}

final ThemeData CompanyThemeData = new ThemeData(
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColor: CompanyColors.black[500],
    accentColorBrightness: Brightness.light);

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class

  static const _blackPrimaryValue = 0xFF000000;

  static const MaterialColor black = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      50: const Color(0xFFe0e0e0),
      100: const Color(0xFFb3b3b3),
      200: const Color(0xFF808080),
      300: const Color(0xFF4d4d4d),
      400: const Color(0xFF262626),
      500: const Color(_blackPrimaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String mail = "prove@domain.com";
  String name = "Rich Morth";

  Future<String> changeMail(BuildContext context) async {
    var email = await createAlertDialog(context, "your mail?");
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (email != null)
        mail = '$email';
    });
    return '$email';
  }

  Future<String> changeName(BuildContext context) async {
    var myName = await createAlertDialog(context, "your name?");
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (myName != null)
        name = '$myName';
    });
    return '$myName';
  }

  Future<String> createAlertDialog(BuildContext context, String str) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(str),
            content: TextField(
              controller: controller,
            ),
            actions: <Widget>[
              
                MaterialButton
                (
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel",style: TextStyle(color: Colors.red))
                ),
                MaterialButton
              (
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.of(context).pop(controller.text.toString());
                  },
                  splashColor: Colors.black,
                  child: Text("Submit")
              ),
            ],
          );
        });
  }

  double pos_l = 0;
  double pos_r = 0;
  double pos_t = 0;
  double pos_b = 0;

  void _movewidget(String pos) {
    setState(() {
      if (pos == "Up") {
        pos_l = 0;
        pos_r = 0;
        pos_t = 0;
        pos_b = 150;
      } else if (pos == "Right") {
        pos_l = 150;
        pos_r = 0;
        pos_t = 0;
        pos_b = 0;
      } else if (pos == "Down") {
        pos_l = 0;
        pos_r = 0;
        pos_t = 150;
        pos_b = 0;
      } else if (pos == "Left") {
        pos_l = 0;
        pos_r = 150;
        pos_t = 0;
        pos_b = 0;
      }
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double width = MediaQuery.of(context).size.width; //ottiene la larghezza, uso di questo dato in via sperimentale
    double height = MediaQuery.of(context).size.height; //ottiene l'altezza dello schermo.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: GoogleFonts.lobster(color: Colors.white),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
        child: Stack(
          children: <Widget>[
            
            AnimatedPositioned(
              left: pos_l,
              right: pos_r,
              top: pos_t,
              bottom: pos_b,
              duration: Duration(milliseconds: 300),
              child: Center(
                child: Container(
                  //color: Colors.black, //va in conflitto con la proprietà decoration
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(12), image: const DecorationImage(image: NetworkImage('https://github.com/FleureauAxel/diocane/raw/master/IMG_7698.JPG'), fit: BoxFit.fill)),
                  margin: const EdgeInsets.all(25.0),
                  padding: const EdgeInsets.all(10.0),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 120,
              child: RaisedButton(
                onPressed: () {
                  _movewidget("Up");
                },
                child: Icon(Icons.keyboard_arrow_up),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 225,
              child: RaisedButton(
                onPressed: () {
                  _movewidget("Right");
                },
                child: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 120,
              child: RaisedButton(
                onPressed: () {
                  _movewidget("Down");
                },
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 15,
              child: RaisedButton(
                onPressed: () {
                  _movewidget("Left");
                },
                child: Icon(Icons.keyboard_arrow_left),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            Text(
              '\nBenvenuti nella prima applicazione dedicata al funneling.',
              style: GoogleFonts.pacifico(),
            ),
            Text(''),
          ],
            ),
          ],
        ),
        
      )
        
      ),
      // This trailing comma makes auto-formatting nicer for build methods
      
      drawer: Drawer(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('$name'),
              accountEmail: Text('$mail'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('$name'.split("")[0] + '$name'.split(" ")[1].split("")[0]), //it takes the first letters of the name (name and surname). it doesn't work in multiple name case. (not definitive) 
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.change_history),
                )
              ],
            ),
            ListTile(
              title: Text("Change email"),
              leading: new Icon(Icons.edit),
              onTap: () {
                changeMail(this.context);
              },
            ),
            Divider(
              height: 0.1,
            ),
            ListTile(
              title: new Text("Change name"),
              leading: new Icon(Icons.account_circle),
              onTap: (){
                  changeName(this.context);
              },
            ),
            ListTile(
              title: new Text("Social"),
              leading: new Icon(Icons.people),
            ),
            ListTile(
              title: new Text("Promotions"),
              leading: new Icon(Icons.local_offer),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.teal,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Search"),
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text("Add"),
            icon: Icon(Icons.add_box),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

