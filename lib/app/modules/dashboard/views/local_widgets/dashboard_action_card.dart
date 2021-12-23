import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';

class DashboardActionCard extends StatelessWidget {
  final Function onTap;
  final String title;
  final String iconImage;

  const DashboardActionCard({Key key, this.onTap, this.title, this.iconImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 95,
                width: 95,
                child: Image.network(
                  iconImage.toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Icon(
                      Icons.error,
                      size: 70,
                      color: Colors.white,
                    );
                  },
                ),
              ),
              VerticalGap(),
              Text(
                title ?? AppStrings.notAvailable,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
