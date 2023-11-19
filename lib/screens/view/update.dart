import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:voting_app/model/electionModel.dart';

class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  List<electionModel> postList = [];
  Future<List<electionModel>> apihit() async {
    final response = await http
        .get(Uri.parse("https://alelection.blogvali.com/api/elections"));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(electionModel.fromJson(i));

        nameController.text = data['name'];
        dateController.text = data['date'];
        timeController.text = data['time'];
        descController.text = data['description'];
         dropdownvalue = data['status'];
      }
      return postList;
    } else {
      return postList;
    }
  }
 
   String  dropdownvalue = '';
  // List of items in our dropdown menu
  var items = [
    'Upcoming',
    'Ongoing',
    'Completed',
  ];
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descController = TextEditingController();
   void updatePost(String name, String date, String time, String desc,
      String dropData) async {
    try {
      Response response = await put(
          Uri.parse('https://alelection.blogvali.com/api/elections'),
          body: {
            "Name": name,
            "Date": date,
            "Time": time,
            "Description": desc,
            "Status": dropData,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('Post create successfully');
        nameController.dispose();
        descController.dispose();
        dateController.dispose();
        timeController.dispose();
      } else {
        print("failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: apihit(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading'));
            } else {
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6,
                      child: ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Column(children: [
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      labelText: 'Enter Your Name'),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      labelText: 'Date'),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: timeController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      labelText: 'Time'),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: descController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green)),
                                      labelText: 'Description'),
                                ),
                                         const SizedBox(height: 10),
                                DropdownButton(
                                  value: dropdownvalue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                      onTap: () {
                                       updatePost(
                                          nameController.text.toString(),
                                          dateController.text.toString(),
                                          timeController.text.toString(),
                                          descController.text.toString(),
                                          dropdownvalue.toString(),
                                        );
                                      },
                                      child: Container(
                                          height: 60,
                                          width: 160,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: Text("Update",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),
                                    ),
                              ]),
                            ),
                          );
                        },
                        leading: Text(postList[index].electionID.toString()),
                        title: Text(postList[index].name.toString()),
                        subtitle: Text(postList[index].description.toString()),
                        trailing: Column(
                          children: [
                            Text(postList[index].time.toString()),
                            Text(postList[index].date.toString()),
                            Text(postList[index].status.toString())
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
