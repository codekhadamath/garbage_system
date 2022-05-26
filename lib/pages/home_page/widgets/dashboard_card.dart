import 'package:flutter/material.dart';
import 'package:garbage_system/router/router.dart';
import 'package:garbage_system/widgets/normal_text.dart';

class DashBoardCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const DashBoardCard({Key? key, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          switch (title) {
            case 'No of Bins':
              Navigator.pushNamed(context, RouteGenerator.noOfBinsRoute);
              break;
            case 'No of Locations':
              Navigator.pushNamed(context, RouteGenerator.binLocationRoute);
              break;
            case 'Recycle':
              Navigator.pushNamed(context, RouteGenerator.recycleRoute);
              break;
          }
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  imageUrl,
                  height: 80.0,
                ),
              ),
              Container(
                child: Center(
                    child: SmallText(
                  text: title,
                  size: 14,
                  color: Colors.white,
                )),
                width: width / 2.5,
                height: 23,
                color: Colors.green.shade600,
              )
            ],
          ),
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(blurRadius: 0.3, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
