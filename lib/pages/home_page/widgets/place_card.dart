import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/models/place_model.dart';
import 'package:garbage_system/router/router.dart';
import 'package:garbage_system/services/bin_service.dart';
import 'package:garbage_system/widgets/normal_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),
      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),
        dragDismissible: false,

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, RouteGenerator.editBinRoute,
                  arguments: place);
            },
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) async {
              await BinService.deleteBin(place.key!);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        tileColor: Colors.white,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.grey.withOpacity(.5), width: .3)),
        onTap: () {
          Navigator.pushNamed(context, RouteGenerator.detailRoute,
              arguments: place);
        },
        leading: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 3),
          child: CircleAvatar(
            backgroundColor: Colors.green.shade600,
            radius: 24.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 21.0,
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(place.binImages.first),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
            ),
            Text(
              place.placeName,
              style: const TextStyle(height: 1.6),
            )
          ],
        ),
        subtitle: Text(
          place.address,
          style: const TextStyle(height: 1.3),
        ),
        trailing: CircularPercentIndicator(
          radius: 18,
          percent: place.filledPercent / 100,
          progressColor: Colors.red,
          animation: true,
          animationDuration: 1500,
          center: SmallText(
            text: '${place.filledPercent}%',
            size: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}


// 'https://assets.nationbuilder.com/toenviro/pages/1184/attachments/original/1426624213/TORSTAR-greenbins-franz-interview-march13.jpg?1426624213'