import 'package:flutter/material.dart';
import 'package:http/http.dart';

class electionPost extends StatefulWidget {
  const electionPost({super.key});

  @override
  State<electionPost> createState() => _electionPostState();
}

class _electionPostState extends State<electionPost> {
  String dropdownvalue = 'Upcoming';

  // List of items in our dropdown menu
  var items = [
    'Upcoming',
    'Ongoing',
    'Completed',
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void electionPost(String name, String date, String time, String desc,
      String dropData) async {
    try {
      Response response = await post(
          Uri.parse('https://alelection.blogvali.com/api/elections'),
          body: {
            "Name": name,
            "Date": date,
            "Time": time,
            "Descrition": desc,
            "Status": dropData,
          });
      if (response.statusCode == 200) {
        print('Post create successfully');
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
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                height: 600,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("Create a Post",
                        style: TextStyle(fontSize: 24, color: Colors.black)),
                  ),
                ),
              ),
              Container(
                height: 540,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Container(
                                child: Column(
                              children: [
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
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    electionPost(
                                      nameController.text.toString(),
                                      dateController.text.toString(),
                                      timeController.text.toString(),
                                      descController.text.toString(),
                                      dropdownvalue.toString(),
                                    );
                                  },
                                  child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text("POST",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ),
                              ],
                            )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
