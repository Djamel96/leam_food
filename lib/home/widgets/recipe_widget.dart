import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leamapp/common/helpers/device_info.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/my_inkwell.dart';
import 'package:leamapp/home/models/recipe.dart';
import 'package:leamapp/home/screens/recip_details_screen.dart';

class RecipWidget extends StatelessWidget {
  final Recipe recipe;
  const RecipWidget({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInKWell(
      onTap: () {
        Get.to(() => RecipDetailsScreen(
              recipe: recipe,
            ));
      },
      child: Container(
        height: getScreenHeight(context, .5),
        margin: const EdgeInsets.only(right: 20),
        width: getScreenWidth(context, .5),
        decoration: BoxDecoration(
          color: const Color(0xfff8f7f7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: (recipe.image?.isNotEmpty ?? false)
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                            imageUrl: recipe.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Container(),
                            height: getScreenHeight(context, .4)),
                      )
                    : Container(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: getScreenWidth(context, .4),
                    child: Text(
                      recipe.title.length > 30
                          ? recipe.title.substring(0, 30) + "..."
                          : recipe.title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff514244),
                        fontFamily: "SansSerif",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${recipe.readyInMinutes} min',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.grey169,
                        fontFamily: "SansSerif",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
