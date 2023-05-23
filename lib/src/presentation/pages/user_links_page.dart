import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class UserLinksPage extends StatefulWidget {
  const UserLinksPage({super.key});
  @override
  State<UserLinksPage> createState() => _UserLinksPageState();
}

class _UserLinksPageState extends State<UserLinksPage>{

  //TODO: obtain data from server
  var link1 = ['Panchito 1', '11/22/33', defaultProfileImage];
  var link2 = ['Panchito 2', '11/22/33', defaultProfileImage];
  var link3 = ['Panchito 3', '11/22/33', defaultProfileImage];

  var links = [];

  @override
  void initState() {
    super.initState();
    links.add(link1);
    links.add(link2);
    links.add(link3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Links"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { debugPrint('add user link'); }, //TODO: add dialogue to add account
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(defaultSize-20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  userListWidget(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userListWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: buildUserList(),
      ),
    );
  }

  List<Widget> buildUserList() {
    List<Widget> rows = [];
    for (var element in links) {
      rows.add(userInfo(element[0], element[1], element[2]));
    }
    return rows;
  }

  Widget userInfo(String name, String date, String image) {
    return Card(
      child: InkWell(
        onTap: () {debugPrint('Card: $name');}, //TODO: add connection with user info
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 80,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(name,),
                      Text(date,)
                    ],
                  ),
                ),
                const SizedBox(width: 20,),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(image)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}