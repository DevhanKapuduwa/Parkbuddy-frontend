import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/profile_image_provider.dart';
import 'contants_set.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key});

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
        const Text(
          "Michael John",
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
