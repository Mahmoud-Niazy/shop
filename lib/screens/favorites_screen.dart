import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_models/favorites_model.dart';
import '../shop_cubit/shop_cubit.dart';
import '../shop_cubit/shop_states.dart';

class FavoritesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).favorites != null ,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => FavoriteItem(ShopCubit.get(context).favorites!.data.data[index].product,context) ,
            separatorBuilder: (context,index) => Container(
              height: 1,
              color: Colors.grey[300],
            ),
            itemCount: ShopCubit.get(context).favorites!.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

FavoriteItem(FavoritesDataDataProduct item,context){
  return Container(
    height: 200,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.topRight,
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
            if(item.discount != 0)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "${item.price}",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(item.discount !=0)
                  Text(
                   '${item.oldPrice}' ,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).AddRemoveFavorites(id: item.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor:  Colors.red,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),

                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}