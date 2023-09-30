import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';

class DeviceLinksPage extends StatefulWidget {
  const DeviceLinksPage({super.key});
  @override
  State<DeviceLinksPage> createState() => _DeviceLinksPageState();
}

class _DeviceLinksPageState extends State<DeviceLinksPage>{

  //TODO: obtain data from server
  var link1 = ['Wearable 1', '11/22/33', '1', defaultProfileImage];
  var link2 = ['Wearable 2', '11/22/33', '0', defaultProfileImage];
  var link3 = ['Wearable 3', '11/22/33', '0', defaultProfileImage];

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
        title: const Text("Device Links"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(defaultSize-20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  deviceListWidget(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deviceListWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: buildDeviceList(),
      ),
    );
  }

  List<Widget> buildDeviceList() {
    List<Widget> list = [];
    for (var element in links) {
      list.add(deviceInfo(element[0], element[1], element[2], element[3]));
      list.add(const SizedBox(height: 5));
    }
    return list;
  }

  Widget deviceInfo(String name, String date, String state, String image) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Colors.grey.shade300)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () {debugPrint('Card: $name');}, //TODO: add connection with device info
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SectionBoldTextWidget(text: name),
                      const SizedBox(height: 10),
                      state=='1'? const SectionTextWidget(text: 'Current - Some description') : const SizedBox(),
                      SizedBox(height: state=='1'? 10 : 0),
                      RichText(
                        text: TextSpan(
                          text: 'Last connection: ',
                          style: const TextStyle(color: Color.fromRGBO(143,143,143,1), fontSize: 14.0, fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: date, style: const TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /*const SizedBox(width: 20,),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(image)
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}