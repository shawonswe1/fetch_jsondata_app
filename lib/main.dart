
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var dailyCall;
  var projectCount;
  Future getDailyData() async{
    var response = await http.get("https://software.techdynobd.com/android/dailyCall.php");

    setState(() {
      var decode = json.decode(response.body);
      dailyCall = decode;
      print(dailyCall);
    });
  }

  Future getProjectCount() async{
    var pResponse = await http.get("https://software.techdynobd.com/android/projectCount.php");

    setState(() {
      var pDecode = json.decode(pResponse.body);
      projectCount = pDecode;
      print(projectCount);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getDailyData();
    this.getProjectCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test App"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                tooltip: "Search",
                onPressed: null)
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(accountName: Text("Morshed"), accountEmail: Text("morshed.swe@gmail.com"))
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: Container(
                      decoration: new BoxDecoration(
                          color: Colors.blue,
                          borderRadius: new BorderRadius.all(const Radius.circular(5.0))
                      ),
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                      margin: const EdgeInsets.fromLTRB(5,10,5,6),
                      child: Text("Daily Call",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white),)
                  ),
                ),
                Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: GridView.count(crossAxisCount: 3,
                    children: List.generate(dailyCall ==null?0 : dailyCall.length, (index){
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              child: ListTile(
                                title: Text(dailyCall[index]["name"],style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),overflow: TextOverflow.fade,maxLines: 1,softWrap: false,),
                                subtitle: Text(dailyCall[index]["count"]+" Calls"),
                              ),
                            ),
                          )
                      );
                    }),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: Container(
                      decoration: new BoxDecoration(
                          color: Colors.blue,
                          borderRadius: new BorderRadius.all(const Radius.circular(5.0))
                      ),
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                      margin: const EdgeInsets.fromLTRB(5,10,5,6),
                      child: Text("Project On Hands",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white),)
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: GridView.count(crossAxisCount: 3,
                    children: List.generate(projectCount ==null?0 : projectCount.length, (index){
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              child: ListTile(
                                title: Text(projectCount[index]["name"],style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),overflow: TextOverflow.fade,maxLines: 1,softWrap: false,),
                                subtitle: Text("Project on Hands : "+projectCount[index]["count"]),
                              ),
                            ),
                          )
                      );
                    }),),
                ),
              ],
            ),
          ],
        )
    );
  }
}


