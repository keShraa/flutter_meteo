import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weatherino',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Weatherino'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String key = "Villes";
  List<String> cities = [];
  String chosenCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView.builder(
            itemCount: cities.length + 2,
              itemBuilder: (context, i) {
              if (i == 0) {
                return DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      styledText("Mes villes", fontSize: 24.0, fontWeight: FontWeight.bold),
                      CupertinoButton(
                        color: Colors.white,
                        child: styledText("Ajouter une ville", color: Colors.blue[800], fontWeight: FontWeight.bold),
                        onPressed: addCity,
                      ),
                    ],
                  ),
                );
              } else if (i == 1) {
                return new ListTile(
                  title: styledText("Ma ville actuelle"),
                  onTap: () {
                    setState(() {
                      chosenCity = null;
                      Navigator.pop(context);
                    });
                  },
                );
              } else {
                String city = cities[i - 2];
                return ListTile(
                  title: styledText(city),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: (() => delete(city)),
                  ),
                  onTap: () {
                    setState(() {
                      chosenCity = city;
                      Navigator.pop(context);
                    });
                  },
                );
              }
              }),
          color: Colors.blue[800],
        ),
      ),
      body: Center(
        child: Text((chosenCity == null)? "Ville actuelle": chosenCity),
      ),
    );
  }

  Text styledText(String data, {color: Colors.white, fontSize: 18.0, fontStyle: FontStyle.normal, textAlign: TextAlign.left, fontWeight: FontWeight.w400}) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    );
  }

  Future<Null> addCity() async {
    return showDialog(
      barrierDismissible: true,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            title: styledText("Ajouter une ville", fontSize: 24.0, color: Colors.blue[800]),
            children: <Widget>[
              CupertinoTextField(
                placeholder: "Ville",
                autofocus: true,
                onSubmitted: (String str) {
                  add(str);
                  Navigator.pop(buildContext);
                },
              ),
            ],
          );
        },
        context: context
    );
  }

  void getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> list = await sharedPreferences.getStringList(key);
    if (list != null) {
      setState(() {
        cities = list;
      });
    }
  }

  void add(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cities.add(str);
    await sharedPreferences.setStringList(key, cities);
    getSharedPreferences();
  }

  void delete(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cities.remove(str);
    await sharedPreferences.setStringList(key, cities);
    getSharedPreferences();
  }
}
