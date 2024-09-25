// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:plants/constant/strings.dart';

import 'package:plants/data/models/plant.dart';

class PlantItem extends StatelessWidget {
  Plant itemOfPlant;
  PlantItem({
    Key? key,
    required this.itemOfPlant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(6.0),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, plantsDetails, arguments: itemOfPlant),
        child: GridTile(
          child: Hero(
            tag: itemOfPlant.Id,
            child: Container(
              color: lightGreen,
              child: (itemOfPlant.defaultImage?.originalUrl != null &&
                      itemOfPlant.defaultImage!.originalUrl!.isNotEmpty)
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: "assets/images/plant.gif",
                      image: itemOfPlant.defaultImage!.originalUrl!,
                      // Handle loading error with a fallback image
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/plant.gif",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      "assets/images/plant.gif",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            color: darkGreen,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${itemOfPlant.name}",
              style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: lightGreen,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
