import 'package:flutter/material.dart';

// Cards that work as buttons on the homepage menu
class HomePageMenuCard extends StatelessWidget {
  final IconData icons;
  final String text;
  final String onTab;
  const HomePageMenuCard({
    this.onTab,
    @required this.icons,
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(onTab);
      },
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        color: Colors.white.withOpacity(0.9),
        margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0, top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icons,
              size: 40,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
