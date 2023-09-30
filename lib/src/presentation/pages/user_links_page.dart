import 'package:cross_link/src/presentation/cubits/user_links/user_links_cubit.dart';
import 'package:cross_link/src/presentation/cubits/user_links/user_links_state.dart';
import 'package:cross_link/src/presentation/widgets/add_user_widget.dart';
import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:cross_link/src/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/themes/app_colors.dart';
import '../../domain/models/user_link.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';

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
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) => AddUserWidget());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
    List<Widget> list = [];
    for (var element in links) {
      list.add(userInfo(element));
      list.add(const SizedBox(height: 5));
    }
    return list;
  }

  Widget userInfo(UserLink link) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Colors.grey.shade300)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () {debugPrint('Card: ${link.user2code}');},
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
                      SectionBoldTextWidget(text: '${link.name?? 'Name'}: ${link.user2code}'),
                      const SizedBox(height: 10),
                      RichText(
                        text: const TextSpan(
                          text: 'Link date: ',
                          style: TextStyle(color: Color.fromRGBO(143,143,143,1), fontSize: 14.0, fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: '2023/09/23', style: TextStyle(fontWeight: FontWeight.normal)),
                            //TextSpan(text: link.state.toString(), style: const TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                  height: 50,
                  width: 50,
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