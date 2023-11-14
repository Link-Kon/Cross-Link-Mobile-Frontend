import 'package:cross_link/src/presentation/cubits/user_links/user_links_cubit.dart';
import 'package:cross_link/src/presentation/cubits/user_links/user_links_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/themes/app_colors.dart';
import '../../domain/models/responses/user_link_response.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/constants/nums.dart';
import '../../utils/constants/strings.dart';
import '../cubits/user/user_cubit.dart';
import '../cubits/user_data/user_data_cubit.dart';
import '../widgets/add_user_widget.dart';

class UserLinksPage extends StatefulWidget {
  const UserLinksPage({super.key});
  @override
  State<UserLinksPage> createState() => _UserLinksPageState();
}

class _UserLinksPageState extends State<UserLinksPage>{

  String userCode1 = '';
  @override
  void initState() {
    super.initState();
    final aCubit = BlocProvider.of<UserLinksCubit>(context);
    final bCubit = BlocProvider.of<UserCubit>(context);

    userCode1 = bCubit.state.response!.userCode;
    aCubit.getUserLinks(apiKey: '', userCode: userCode1);
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
          showDialog(context: context, builder: (BuildContext context) => AddUserWidget(userCode1: userCode1));
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

  Widget _buildUserLinks(List<UserLinkResponse> links) {
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

  Widget userListWidget(List<UserLinkResponse> links) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: buildUserList(links),
      ),
    );
  }

  List<Widget> buildUserList(List<UserLinkResponse> links) {
    List<Widget> list = [];
    for (var element in links) {
      list.add(userInfo(element));
      list.add(const SizedBox(height: 5));
    }
    return list;
  }

  Widget userInfo(UserLinkResponse link) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Colors.grey.shade300)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () {debugPrint('Card: ${link.code}');},
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
                      SectionBoldTextWidget(text: link.name ?? 'User\'s Name'),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Link date: ',
                          style: const TextStyle(color: Color.fromRGBO(143,143,143,1), fontSize: 14.0, fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(text: link.creationDate.toString().substring(0, 10), style: const TextStyle(fontWeight: FontWeight.normal)),
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
                    child: SvgPicture.asset(link.imageUrl ?? defaultProfileImage)
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