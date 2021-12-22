import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leamapp/common/helpers/device_info.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/my_inkwell.dart';
import 'package:leamapp/home/models/recipe.dart';
import 'package:leamapp/home/widgets/ingredient_widget.dart';
import 'package:leamapp/main_store.dart';
import 'package:provider/provider.dart';

class RecipDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipDetailsScreen({Key key, this.recipe}) : super(key: key);

  @override
  State<RecipDetailsScreen> createState() => _RecipDetailsScreenState();
}

class _RecipDetailsScreenState extends State<RecipDetailsScreen> {
  int servings = 1;
  @override
  Widget build(BuildContext context) {
    final mainStore = Provider.of<MainStore>(context, listen: true);
    return Scaffold(
      backgroundColor: MyColors.appMain100,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            leading: IconButton(
              icon: const Icon(
                Icons.keyboard_backspace,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              MyInKWell(
                onTap: () {
                  widget.recipe.saved = !widget.recipe.saved;
                  mainStore.notify();
                },
                child: Image.asset(
                  "assets/icons/save.png",
                  color: widget.recipe.saved ? Colors.redAccent : Colors.white,
                  width: 50,
                ),
              ),
              const SizedBox(width: 10)
            ],
            backgroundColor: MyColors.appMain100,
            expandedHeight: getScreenHeight(context, .4),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              background: (widget.recipe.image?.isNotEmpty ?? false)
                  ? Container(
                      margin: const EdgeInsets.all(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: widget.recipe.image,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => Container(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // height: 9900,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/hand.png",
                                width: 60,
                                color: MyColors.appMain100,
                              ),
                              //const SizedBox(height: 10),
                              const Text(
                                "Easy",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff514244),
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/clock.png",
                                width: 60,
                                color: MyColors.appMain100,
                              ),
                              Text(
                                "${widget.recipe.readyInMinutes} min",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff514244),
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/starr.png",
                                width: 60,
                                color: MyColors.appMain100,
                              ),
                              const Text(
                                "4,8",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff514244),
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: Text(widget.recipe.title,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.3,
                              fontFamily: 'PlayfairDisplay',
                            )),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: Text("Classic japanese recipe",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: MyColors.grey129)),
                      ),
                      const SizedBox(height: 26),

                      /// Number of the servings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Ingredients',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87)),
                              const SizedBox(height: 10),
                              Text('How many serving?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.grey169)),
                            ],
                          ),
                          Container(
                            height: 60,
                            padding: const EdgeInsets.all(20),
                            width: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xfff8f7f7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyInKWell(
                                  onTap: () {
                                    if (servings > 1) {
                                      setState(() {
                                        servings--;
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                ),
                                Text("$servings",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87)),
                                MyInKWell(
                                  onTap: () {
                                    setState(() {
                                      servings++;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// List of the ingrediens
                      const SizedBox(height: 26),

                      ...List.generate(
                          widget.recipe.ingredients.length,
                          (index) => IngredientWidget(
                                ingredient: widget.recipe.ingredients[index],
                                servings: servings,
                              ))
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
