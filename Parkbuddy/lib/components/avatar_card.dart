import 'package:flutter/material.dart';
import 'package:plz/components/user.dart';
import 'package:provider/provider.dart';

import '../Pages/profile_image_provider.dart';
import 'contants_set.dart';

class AvatarCard extends StatelessWidget {
  final MobileUser CurrentUser;
  const AvatarCard({super.key,required this.CurrentUser});

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        profileImageProvider.profileImage != null
            ? CircleAvatar(
                radius: 40, // half the width and height for a circular avatar
                backgroundImage:
                    MemoryImage(profileImageProvider.profileImage!),
              )
            : Image.asset(
                "lib/images/profilepic.jpg",
                width: 80,
                height: 80,
              ),
        SizedBox(
          height: 10,
        ),
         Text(
          CurrentUser.Username,
          style: TextStyle(
            fontSize: kbigFontSize,
            fontWeight: FontWeight.bold,
            color: kprimaryColor,
          ),
        ),
      ],
    );
  }
}
