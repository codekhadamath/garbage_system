import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/models/bin_model.dart';
import 'package:garbage_system/models/place_model.dart';
import 'package:garbage_system/services/firestore_service.dart';
import 'package:garbage_system/widgets/app_text.dart';
import 'package:garbage_system/widgets/normal_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailPage extends StatefulWidget {
  final Place place;
  const DetailPage({Key? key, required this.place}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> _binImages = [];

  bool _isArrowLeft = true;

  @override
  void initState() {
    _binImages = widget.place.binImages.map((image) => '$image').toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  FontAwesome5.arrow_alt_circle_left,
                  color: Colors.black87,
                )),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    _binImages.first,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0)))))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.01,
            ),
          ),

          // Filled percent indicator
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverToBoxAdapter(
              child: LinearPercentIndicator(
                width: 300,
                percent: widget.place.filledPercent / 100,
                barRadius: const Radius.circular(5),
                alignment: MainAxisAlignment.start,
                leading: SmallText(
                  text: '${widget.place.filledPercent}%',
                  size: 12,
                ),
                animation: true,
                animationDuration: 1500,
                progressColor: Colors.red,
                lineHeight: 12,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.03,
            ),
          ),

          // Address detail
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Pickup Address',
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  Text(
                    '${widget.place.placeName}\n${widget.place.address} - ${widget.place.pinCode}',
                    style: const TextStyle(
                        fontSize: 15.0, height: 1.5, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.02,
            ),
          ),

          // Detail of bins
          SliverToBoxAdapter(
            child: StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: InkWell(
                      onTap: () {
                        setState(() => _isArrowLeft = !_isArrowLeft);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Number Of Bins',
                                ),
                                SizedBox(
                                  height: height * 0.006,
                                ),
                                SmallText(text: '${widget.place.binsCount}'),
                              ],
                            ),
                            Icon(_isArrowLeft
                                ? Entypo.right_open_mini
                                : Entypo.down_open_mini)
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: _isArrowLeft ? 0.0 : 80.0,
                    child: FirebaseAnimatedList(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 16.0, 25.0, 0.0),
                        scrollDirection: Axis.horizontal,
                        query: FirestoreService.postsRef
                            .child('${widget.place.key!}/bins'),
                        itemBuilder: (context, snapshot, animation, index) {
                          final bin = Bin.fromJson(
                              snapshot.value as Map<Object?, Object?>);

                          return Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Column(
                              children: [
                                CircularPercentIndicator(
                                  radius: 18,
                                  percent: bin.filledPercent / 100,
                                  progressColor: Colors.red,
                                  animation: true,
                                  animationDuration: 1500,
                                  center: SmallText(
                                    text: '${bin.filledPercent}%',
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(bin.name)
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            }),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.02,
            ),
          ),

          // Distance from current location to this location
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                          ),
                          SizedBox(
                            width: height * 0.006,
                          ),
                          AppText(text: '5 kms away'),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 22),
                        child: SmallText(
                          text: '10 min',
                          size: 15,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColor.primary,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: AppText(
                            text: 'Go',
                            color: Colors.white,
                            size: 22,
                          )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.03,
            ),
          ),

          // Bin images
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverToBoxAdapter(
              child: AppText(
                text: 'Photos Of Junk',
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.03,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                ..._binImages.map(
                  (imageUrl) => Row(
                    children: [
                      ClipRRect(
                          child: Image.network(imageUrl,
                              width: 80, height: 80, fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      SizedBox(
                        width: width * 0.02,
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
