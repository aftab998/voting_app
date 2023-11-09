import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/model/electionModel.dart';
import 'dart:convert';

class homeNav extends StatefulWidget {
  const homeNav({super.key});

  @override
  State<homeNav> createState() => _homeNavState();
}

class _homeNavState extends State<homeNav> {
  List<electionModel> postList = [];
  Future<List<electionModel>> apihit() async {
    final response = await http
        .get(Uri.parse("https://alelection.blogvali.com/api/elections"));
    var data = jsonDecode(response.body.toString());
    

    if (response.statusCode == 200) {
      for (Map<String,dynamic> i in data) {
        postList.add(electionModel.fromJson(i));
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
        backgroundColor: Colors.green,
        title: Text(
          'Election List',
          style: TextStyle(color: Colors.white, letterSpacing: 2.5),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: apihit(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'));
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3),
                  itemCount: postList.length,
                  itemBuilder: (contex, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 24,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    postList[index].name!.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade700,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  postList[index].date!.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timer,
                                        color: Colors.grey.shade700),
                                    Text(postList[index].time!.toString(),
                                        style: TextStyle(
                                            color: Colors.grey.shade700))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 23.500,
                            ),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                child: Center(
                                  child: Text(postList[index].status!.toString(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ))
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
