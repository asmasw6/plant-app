// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:charchters/constant/strings.dart';
import 'package:flutter/material.dart';

import 'package:charchters/data/models/charachter.dart';

class CharacterItem extends StatelessWidget {
  Charachter itemOfCharacter;
  CharacterItem({
    Key? key,
    required this.itemOfCharacter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charachtersDetails,
            arguments: itemOfCharacter),
        child: GridTile(
          child: Hero(
            tag: itemOfCharacter.Id,
            child: Container(
              color: Colors.amber,
              child: (itemOfCharacter.defaultImage?.originalUrl != null &&
                      itemOfCharacter.defaultImage!.originalUrl!.isNotEmpty)
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: "assets/images/plant.gif",
                      image: itemOfCharacter.defaultImage!.originalUrl!,
                      // Handle loading error with a fallback image
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/plant.gif");
                      },
                    )
                  : Image.asset(
                      "assets/images/plant.gif",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          /* Container(
            color: Colors.amber,
            child: itemOfCharacter.defaultImage!.originalUrl!.is
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/plant.gif",
                    image: itemOfCharacter.defaultImage!.originalUrl!)
                : Image.asset("assets/images/plant.gif"),
          ),*/
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            color: Colors.red,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${itemOfCharacter.name}",
              style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: Colors.greenAccent,
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
