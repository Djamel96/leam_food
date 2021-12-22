import 'package:flutter/material.dart';
import 'package:leamapp/common/helpers/navigation_helper.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/default_loading.dart';
import 'package:leamapp/common/widgets/my_inkwell.dart';
import 'package:leamapp/common/widgets/rich_text_field.dart';
import 'package:leamapp/home/services/get_recipes_services.dart';
import 'package:leamapp/home/widgets/recipe_widget.dart';
import 'package:leamapp/main_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getRecipes();
    });
  }

  _getRecipes() {
    final mainStore = Provider.of<MainStore>(context, listen: false);
    getRecipe(mainStore).then((value) {});
  }

  bool _viewAllRecipe = false;
  @override
  Widget build(BuildContext context) {
    final mainStore = Provider.of<MainStore>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text("What do you want \nto cook today?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.3,
                    color: Color(0xff514244),
                    fontFamily: 'PlayfairDisplay',
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            MyInKWell(
              onTap: () => navigateCounselorMenu(context, 1),
              child: IgnorePointer(
                ignoring: true,
                child: RichTextField(
                  readOnly: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyColors.appMain100,
                  ),
                  hintText: "Recipe",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            mainStore.recipes == null
                ? const Center()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyInKWell(
                        onTap: () {
                          setState(() {
                            _viewAllRecipe = false;
                          });
                        },
                        child: Text("Popular lunch recips",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: !_viewAllRecipe
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: _viewAllRecipe
                                  ? const Color(0xff514244).withOpacity(.5)
                                  : const Color(0xff514244).withOpacity(.9),
                              fontFamily: 'SourceSansPro',
                            )),
                      ),
                      MyInKWell(
                        onTap: () {
                          setState(() {
                            _viewAllRecipe = true;
                          });
                        },
                        child: Text("View all",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _viewAllRecipe
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: _viewAllRecipe
                                  ? const Color(0xff514244).withOpacity(.9)
                                  : const Color(0xff514244).withOpacity(.5),
                              fontFamily: 'SourceSansPro',
                            )),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            mainStore.recipes == null
                ? const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Loading(),
                  )
                : Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List<Widget>.generate(
                          mainStore.recipes.length,
                          (index) => RecipWidget(
                                recipe: mainStore.recipes[index],
                              )),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
