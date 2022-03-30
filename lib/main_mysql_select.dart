import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NftDataJson {
  final String id;
  final String name, imageUrl, description;

  NftDataJson({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory NftDataJson.fromJson(Map<String, dynamic> jsonData) {
    return NftDataJson(
      id: jsonData['id'],
      name: jsonData['name'],
      description: jsonData['description'],
      imageUrl: "http://ipaddress/images_file/"+jsonData['image_url'],
    );
  }

}

class CustomListView extends StatelessWidget {

  final List<NftDataJson> Imbmarket;

  CustomListView(this.Imbmarket);

  Widget build(context) {
    return ListView.builder(
      itemCount: Imbmarket.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(Imbmarket[currentIndex], context);
      },
    );
  }

  Widget createViewItem(NftDataJson nftdatajson, BuildContext context) {
    return ListTile(
        title: Card(
          elevation: 5.0,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Text('LogIn', style: TextStyle(fontSize: 20.0),),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {

                      print("hello");
                    },
                  ),
                ),
                Padding(
                  child: Image.network(nftdatajson.imageUrl),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Row(children: <Widget>[
                  Padding(
                      child: Text(
                        nftdatajson.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                  Text(" | "),
                  Padding(
                      child: Text(
                        nftdatajson.description,
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                ]),
              ],
            ),
          ),
        ),
        onTap: () {
          //We start by creating a Page Route.
          //A MaterialPageRoute is a modal route that replaces the entire
          //screen with a platform-adaptive transition.
          var route = MaterialPageRoute(
            builder: (BuildContext context) =>
                SecondScreen(value: nftdatajson),
          );
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          Navigator.of(context).push(route);
        });
  }
}

//Future is n object representing a delayed computation.
Future<List<NftDataJson>> downloadJSON() async {
  final jsonEndpoint = "http://ipaddress/select.php";

  final response = await get(Uri.parse(jsonEndpoint));

  if (response.statusCode == 200) {
    List Imbmarket = json.decode(response.body);
    //print(Imbmarket);
    print("response json : " + Imbmarket.toString());//[{id: 29, name: t, description: ttt, destination: ttt, image_url: apollo.jpg, technology_exists: t}, {id: 3, name: t, description: ttt, destination: ttt, image_url: apollo.jpg, technology_exists: t}, {id: 2, name: b, description: very nice, destination: abc, image_url: challenger.jpg, technology_exists: b}, {id: 1, name: a, description: this is good, destination: this is good, image_url: apollo.jpg, technology_exists: a}]
    print("response json[0] : " + Imbmarket[0].toString()); //{id: 29, name: t, description: ttt, destination: ttt, image_url: apollo.jpg, technology_exists: t}
    print("response json[0] : " + Imbmarket[0]['id'].toString()); // 29

    return Imbmarket
        .map((imbntfdata) => new NftDataJson.fromJson(imbntfdata))
        .toList();

  } else
    throw Exception('We were not able to successfully download the json data.');
}

class SecondScreen extends StatefulWidget {
  final NftDataJson value;

  SecondScreen({Key? key, required this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text(
                  'SPACECRAFT DETAILS',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              Padding(
                //`widget` is the current configuration. A State object's configuration
                //is the corresponding StatefulWidget instance.
                child: Image.network('${widget.value.imageUrl}'),
                padding: EdgeInsets.all(12.0),
              ),
              Padding(
                child: Text(
                  'NAME : ${widget.value.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: Text(
                  'description : ${widget.value.description}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              )
            ],   ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('MySQL Images Text')),
        body: Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child: FutureBuilder<List<NftDataJson>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NftDataJson>? Imbmarket = snapshot.data;
                return CustomListView(Imbmarket!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //return  a circular progress indicator.
              return CircularProgressIndicator();
            },
          ),

        ),
      ),
    );
  }
}


void main() {
  runApp(MyApp());
}
//end

