import 'package:cross_link/src/presentation/cubits/user_links/user_links_cubit.dart';
import 'package:cross_link/src/presentation/cubits/user_links/user_links_state.dart';
import 'package:cross_link/src/presentation/widgets/add_user_widget.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/user_link.dart';

class UserLinksPage extends StatefulWidget {
  const UserLinksPage({super.key});
  @override
  State<UserLinksPage> createState() => _UserLinksPageState();
}

class _UserLinksPageState extends State<UserLinksPage>{

  @override
  void initState() {
    super.initState();
    final aCubit = BlocProvider.of<UserLinksCubit>(context);
    aCubit.getUserLinks(apiKey: '', userCode: 'user1code');

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Links"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) => AddUserWidget());
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<UserLinksCubit, UserLinksState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case UserLinksLoading:
              return const Center(child: CupertinoActivityIndicator());
            case UserLinksFailed:
              debugPrint('error: ${state.error}');
              return Center(child: IconButton(icon: const Icon(Icons.refresh), onPressed: () {
                  context.read<UserLinksCubit>().getUserLinks(apiKey: 'aa', userCode: 'user1code');
                },)
              );
            case UserLinksSuccess:
              return state.userLinks.isNotEmpty? _buildUserLinks(state.userLinks)
                  : const Center(child: Text('No users added'));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildUserLinks(List<UserLink> links) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(defaultSize-20),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                userListWidget(links),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userListWidget(List<UserLink> links) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: buildUserList(links),
      ),
    );
  }

  List<Widget> buildUserList(List<UserLink> links) {
    List<Widget> rows = [];
    for (var element in links) {
      rows.add(userInfo(element));
    }
    return rows;
  }

  Widget userInfo(UserLink link) {
    return Card(
      child: InkWell(
        onTap: () {debugPrint('Card: ${link.user2code}');},
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
                      Text('${link.name}: ${link.user2code} NAME',),
                      Text('state: ${link.state}',)
                    ],
                  ),
                ),
                const SizedBox(width: 20,),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(link.imageUrl ?? defaultProfileImage)
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