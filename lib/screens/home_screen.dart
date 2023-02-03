import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../data_models/categories_model.dart';
import '../data_models/home_data.dart';
import '../shop_cubit/shop_cubit.dart';
import '../shop_cubit/shop_states.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var carouselKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeData != null && ShopCubit.get(context).categories != null ,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  child: CarouselSlider.builder(
                    slideBuilder: (index) => CachedNetworkImage(
                        imageUrl:  ShopCubit.get(context)
                            .homeData!
                            .data
                            .banners[index]
                            .image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,

                          ),
                        ),
                      ),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: (context,url)=> Center(child: CircularProgressIndicator()),
                      errorWidget: (context,url,error)=> Icon(Icons.error_outline),
                    ),
                    itemCount:
                        ShopCubit.get(context).homeData!.data.banners.length,
                    unlimitedMode: true,
                    // slideTransform: CubeTransform(),
                    key: carouselKey,
                    enableAutoSlider: true,
                    autoSliderTransitionCurve: Curves.easeInCubic,
                    slideIndicator: CircularSlideIndicator(
                      padding: EdgeInsets.only(bottom: 10),
                      currentIndicatorColor: Colors.blue,
                    ),
                    autoSliderTransitionTime: Duration(
                      seconds: 1,
                    ),
                  ),
                  height: 300,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 120,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => CategoryItem(
                        ShopCubit.get(context).categories!.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemCount:
                        ShopCubit.get(context).categories!.data.data.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.73,
                  ),
                  itemCount:
                      ShopCubit.get(context).homeData!.data.products.length,
                  itemBuilder: (context, index) => GridItem(
                      ShopCubit.get(context).homeData!.data.products[index],
                      context),
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

GridItem(ProductsData item, context) {
  return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context,state){},
    builder: (context,state){
      return Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: item.image,
                width: 200,
                height: 200,
                placeholder: (context,url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context,url,error) => Icon(Icons.error_outline_outlined),
                imageBuilder: (context,imageProvider)=> Image(

                  image: imageProvider,
                ),
              ),
              if (item.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                   Column(
                     children: [
                       Text(
                         "${item.price}",
                         style: TextStyle(
                           color: Colors.blue,
                         ),
                       ),
                       SizedBox(
                         height: 5,
                       ),
                       if (item.discount != 0)
                         Text(
                           '${item.old_price}',
                           style: TextStyle(
                             decoration: TextDecoration.lineThrough,
                           ),
                         ),
                     ],
                   ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        ShopCubit.get(context).AddOrRemoveInCart(pId: item.id);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: item.in_cart ? Colors.blue : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).AddRemoveFavorites(id: item.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                        item.in_favorites ? Colors.red : Colors.grey[400],
                        child:  Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },

  );
}

CategoryItem(CategoriesDataData cat) {
  return Container(
    width: 120,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: cat.image,
          width: 120,
          height: 120,
          placeholder: (context,url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context,url,error) => Icon(Icons.error_outline_outlined),
          imageBuilder: (context,imageProvider)=> Image(
            width: 120,
            height: 120,
            image: imageProvider,
          ),
        ),
        Container(
          height: 30,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5),
          color: Colors.black.withOpacity(.4),
          child: Center(
            child: Text(
              cat.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

