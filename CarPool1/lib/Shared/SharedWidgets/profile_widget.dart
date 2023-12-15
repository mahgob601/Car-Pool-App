import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
import 'package:flutter/material.dart';
class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(

      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
              right: 4,
              child: buildEditIcon(color)
          ),

        ],
      )
    );
  }

  Widget buildEditIcon(Color color)
  {
    return ClipOval(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(3),
        child: ClipOval(
          child: Container(
            color: SharedColor.tealColor,
            padding: EdgeInsets.all(8),
            child: Icon(
              isEdit? Icons.add_a_photo:Icons.edit,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  Widget buildImage()
  {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128 ,
          child: InkWell(onTap: onClicked,),
         ),
      ),
    );
  }
}
