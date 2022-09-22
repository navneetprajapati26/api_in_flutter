import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ApiPAGE extends StatefulWidget {
  const ApiPAGE({Key? key}) : super(key: key);

  @override
  State<ApiPAGE> createState() => _ApiPAGEState();
}

class _ApiPAGEState extends State<ApiPAGE> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "P H O T O   A P i",
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        //print(snapshot.data![index].url.toString());
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          title: Text(
                              "ID is " + snapshot.data![index].id.toString()),
                          subtitle:
                              Text(snapshot.data![index].title.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );

    // Widget buildImage(int index) =>CircleAvatar(
    //   backgroundImage: CachedNetworkImageProvider(
    //       snapshot.data![index].url.toString(),
    //   ),
    // )
  }
}

class Photos {
  String title, url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}
