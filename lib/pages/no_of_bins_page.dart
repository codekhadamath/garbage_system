import 'package:flutter/material.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/services/bin_service.dart';
import 'package:garbage_system/widgets/app_text.dart';

class NoOfBinsPage extends StatefulWidget {
  const NoOfBinsPage({Key? key}) : super(key: key);

  @override
  _NoOfBinsPageState createState() => _NoOfBinsPageState();
}

class _NoOfBinsPageState extends State<NoOfBinsPage> {
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
            child: AppText(
                text: 'Number Of \nBins', size: 30, color: Colors.black87),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 390,
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/binfinal.png'),
                        fit: BoxFit.cover)),
              ),
            ],
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
              future: BinService.numberOfBins,
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
