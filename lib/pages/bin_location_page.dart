import 'package:flutter/material.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/services/bin_service.dart';
import 'package:garbage_system/widgets/app_text.dart';
import 'package:garbage_system/widgets/normal_text.dart';

class BinLocationPage extends StatefulWidget {
  const BinLocationPage({Key? key}) : super(key: key);

  @override
  _BinLocationPageState createState() => _BinLocationPageState();
}

class _BinLocationPageState extends State<BinLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycle'),
        backgroundColor: AppColor.primary,
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 20),
            child: AppText(text: 'Locations', size: 30, color: Colors.black87),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 390,
                height: 380,
                decoration: const BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    image: DecorationImage(
                        image: AssetImage('assets/location.png'),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AppText(
              text: 'count',
              size: 20,
              color: Colors.black87,
            ),
          ),
          FutureBuilder(
              future: BinService.numberOfPlaces,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: AppText(
                    text: '${snapshot.data}',
                    size: 60,
                    color: Colors.amber,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
