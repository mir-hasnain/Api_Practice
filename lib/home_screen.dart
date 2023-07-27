import 'dart:convert';

import 'package:api_practice/Photo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<Photo> photoList = [];
  void hello(http.Response resp){
    print(resp.body);
  }
  Future<List<Photo>> getData () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        Photo photoObj = Photo(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photoObj);
      }
      return photoList;
    }else{
      // Photo photoObj = Photo(title: 'title1', url: 'url1');
      // photoList.add(photoObj);
      return photoList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Practice chal rahi hai'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getData(),
                builder: (context,AsyncSnapshot<List<Photo>> snapshot){
              return ListView.builder(
                itemCount: photoList.length,
                  itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data![index].title.toString()),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  trailing: Text(snapshot.data![index].id.toString()),
                );
              });
            }),
          )
        ],
      ),
    );
  }
}
