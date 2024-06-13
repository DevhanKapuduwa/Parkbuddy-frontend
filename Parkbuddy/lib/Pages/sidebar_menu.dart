import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SidebarMenuWidget extends StatefulWidget {
  const SidebarMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final bool isActive;


  @override
  _SidebarMenuWidgetState createState() => _SidebarMenuWidgetState();
}

class _SidebarMenuWidgetState extends State<SidebarMenuWidget> {
  bool isHovered = false;


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
    child:  Stack(
      children: [
        if (widget.isActive || isHovered)
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          height: 54,
          width: 288,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        )
        else SizedBox(),

        ListTile(
          onTap: widget.onPress,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.6),
            ),
            child: Icon(widget.icon, color: Colors.black),
          ),
          title: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.black)
          ),
          trailing: widget.endIcon ? Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.4),
            ),
            child: Icon(LineAwesomeIcons.angle_right_solid, size: 18,color: Colors.black,),
          ) : null,
        ),
      ],
    ),
    );
  }
}
