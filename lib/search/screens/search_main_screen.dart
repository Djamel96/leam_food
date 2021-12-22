import 'package:flutter/material.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/rich_text_field.dart';

class SearchMainScreen extends StatefulWidget {
  const SearchMainScreen({Key key}) : super(key: key);

  @override
  _SearchMainScreenState createState() => _SearchMainScreenState();
}

class _SearchMainScreenState extends State<SearchMainScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichTextField(
          prefixIcon: Icon(
            Icons.search,
            color: MyColors.grey106,
          ),
          controller: searchController,
          hintText: "Recipe",
          validator: (value) {
            return null;
          },
        ),
      ),
      body: Column(),
    );
  }
}
