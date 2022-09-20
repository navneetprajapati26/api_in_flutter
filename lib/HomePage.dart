import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'Models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi() async {
    final respons =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(respons.body.toString());
    if (respons.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "A P I",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
             future: getPostApi(),
              builder: (context , snapshot) {
               if(!snapshot.hasData){
                 return Text("L O A D I N G..");
               }else{
                 return ListView.builder(
                   itemCount: postList.length,
                     itemBuilder:(context,index){
                   return Card(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('T I T A L E\n'+postList[index].title.toString()),
                           Text('D I S C R I P T I O N\n'+postList[index].body.toString())
                         ],
                       ),
                     ),
                   );
                 });
               }
              },
            ),
          )
        ],
      ),
    );
  }
}
