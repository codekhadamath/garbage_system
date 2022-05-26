import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/dialogs/my_alert_dialog.dart';
import 'package:garbage_system/models/place_model.dart';
import 'package:garbage_system/pages/home_page/widgets/dashboard_card.dart';
import 'package:garbage_system/pages/home_page/widgets/place_card.dart';
import 'package:garbage_system/router/router.dart';
import 'package:garbage_system/services/auth_service.dart';
import 'package:garbage_system/services/firestore_service.dart';
import 'package:garbage_system/widgets/app_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          Navigator.pushNamed(context, RouteGenerator.editBinRoute);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: AppText(
          text: 'Garbage',
          color: Colors.white,
          size: 20,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog(context,
                    title: 'Logout',
                    description:
                        'Are you sure you are going to log out from this application?',
                    onSuccess: () async {
                  await AuthService.signOut;
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteGenerator.wrapperRoute, (route) => false);
                });
              },
              icon: const Icon(Icons.logout))
        ],
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                children: const [
                  DashBoardCard(
                      imageUrl: 'assets/4938754.jpg', title: 'No of Bins'),
                  SizedBox(
                    width: 10.0,
                  ),
                  DashBoardCard(
                      imageUrl: 'assets/23854351.jpg',
                      title: 'No of Locations'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              child: Row(
                children: const [
                  DashBoardCard(
                      imageUrl: 'assets/689408.jpg', title: 'Recycle'),
                  SizedBox(
                    width: 10.0,
                  ),
                  DashBoardCard(
                      imageUrl: 'assets/21056724.jpg', title: 'About'),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            FirebaseAnimatedList(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              query: FirestoreService.postsRef.orderByValue(),
              itemBuilder: (context, snapshot, animation, index) {
                final place =
                    Place.fromJson(snapshot.value as Map<Object?, Object?>);
                place.key = snapshot.key;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                  child: PlaceCard(place: place),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
