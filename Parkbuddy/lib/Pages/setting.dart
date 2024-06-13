import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Controls",
    route: "/",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Change Password",
    route: "/",
    icon: Icons.settings,
  ),
  Setting(
    title: "Privacy and Security",
    route: "/",
    icon: CupertinoIcons.doc_fill,
  ),
  Setting(
    title: "Notification Settings",
    route: "/",
    icon: CupertinoIcons.heart_fill,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    route: "/",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Our Handbook",
    route: "/",
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  Setting(
    title: "Community",
    route: "/",
    icon: CupertinoIcons.person_3_fill,
  ),
];
