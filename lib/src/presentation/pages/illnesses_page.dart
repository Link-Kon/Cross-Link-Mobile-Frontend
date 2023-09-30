import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants/nums.dart';
import '../../utils/constants/strings.dart';
import '../cubits/illness/illness_cubit.dart';
import '../cubits/illness/illness_state.dart';

class IllnessesPage extends StatefulWidget {
  const IllnessesPage({super.key});
  @override
  State<IllnessesPage> createState() => IllnessesPageState();
}

class IllnessesPageState extends State<IllnessesPage>{

  //TODO: obtain data from server
  var link1 = ['Illness 1', '11/22/33', '1', defaultProfileImage];
  var link2 = ['Illness 2', '11/22/33', '0', defaultProfileImage];
  var link3 = ['Illness 3', '11/22/33', '0', defaultProfileImage];

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
    final aCubit = BlocProvider.of<IllnessCubit>(context);
    aCubit.getAllIllnesses('', 'userCode1');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Illnesses"),
      ),
      body: BlocBuilder<IllnessCubit, IllnessState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case IllnessLoading:
              return const Center(child: CupertinoActivityIndicator());
            case IllnessFailed:
              debugPrint('error: ${state.error}');
              return Center(child: IconButton(icon: const Icon(Icons.refresh), onPressed: () {
                final cubit = context.read<IllnessCubit>();
                cubit.getAllIllnesses('', '');
              },)
              );
            case IllnessSuccess:
              debugPrint('data: ${state.illnesses[0].name}');
              return _buildIllnesses();
            default:
              return const SizedBox();
          }
        },
      )
    );
  }

  Widget _buildIllnesses() {
    return Container(
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
      rows.add(userInfo(element[0], element[1], element[2], element[3]));
    }
    return rows;
  }

  Widget userInfo(String name, String date, String state, String image) {
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
                      state=='1'? const Text('Current', style: TextStyle(color: Colors.grey),) : const SizedBox(),
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