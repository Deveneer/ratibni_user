import 'package:flutter/material.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';

class MenuOption extends StatelessWidget {
  final String iconPath;
  final Icon icon;
  final String text;
  final Function onTap;

  const MenuOption({Key key, this.iconPath, this.text, this.onTap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 36,
        ),
        child: Row(
          children: [
            if (iconPath != null) ImageIcon(AssetImage(iconPath)),
            if (icon != null) icon,
            HorizontalGap(gap: 20),
            Text(
              text,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
