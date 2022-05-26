import 'package:flutter/material.dart';
import 'package:garbage_system/contstants/style.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({Key? key}) : super(key: key);

  @override
  _RecyclePageState createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycle'),
        backgroundColor: AppColor.primary,
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 90,
                ),
                Container(
                  width: 200,
                  height: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/recycle.png'))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Recycling\t',
                          style: TextStyle(color: Colors.green, fontSize: 30)),
                      TextSpan(
                          text:
                              'recovery and reprocessing of waste materials for use in new products. The basic phases in recycling are the collection of waste materials, their processing or manufacture into new products, and the purchase of those products, which may then themselves be recycled. Typical materials that are recycled include iron and steel scrap, aluminum cans, glass bottles, paper, wood, and plastics. The materials reused in recycling serve as substitutes for raw materials obtained from such increasingly scarce natural resources as petroleum, natural gas, coal, mineral ores, and trees. Recycling can help reduce the quantities of solid waste deposited in landfills, which have become increasingly expensive. Recycling also reduces the pollution of air, water, and land resulting from waste disposal')
                    ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.britannica.com/explore/savingearth/wp-content/uploads/sites/4/2019/04/0000143482-1200x800.jpg'))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Importance Of Recycling\n',
                          style: TextStyle(color: Colors.green, fontSize: 25)),
                      TextSpan(
                          text:
                              'Recycling is important in today’s world if we want to leave this planet for our future generations. It is good for the environment since we are making new products from the old products which are of no use to us. Recycling begins at home. If you are not throwing away any of your old products and instead utilizing it for something new, then you are actually recycling.\n When you think of recycling, you should really think about the whole idea; reduce, reuse and recycle. We’ve been careless up to this point with the way we’ve treated the Earth, and it’s time to change, not just the way we do things but the way we think.')
                    ]),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.conserve-energy-future.com/wp-content/uploads/2014/07/earth-globe-recycling-sustainable-living.jpg'))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'What People Can do?\n',
                          style: TextStyle(color: Colors.green, fontSize: 25)),
                      TextSpan(
                          text:
                              'There are handful number of things that you could do to save this planet.\n\n'),
                      TextSpan(
                          text:
                              '1.Throw away all the garbage in your house that is of no use to you, or you think you can’t utilize it in some other way. If you don’t have these boxes, you can easily purchase a suitable container for each recyclable product (e.g., paper, plastic, and glass), and then take these down to your local recycling center.\n'),
                      TextSpan(
                          text:
                              '\n2.Try to avoid the use of plastic bags and plastic paper as much as possible. They not only pollute the environment but also helps in filling landfills. Also, when you shop, try to look out for the products that have the least packaging. Every million dollars are spent only on the packaging of these products, which ultimately go to the garbage sites.\n'),
                      TextSpan(
                          text:
                              '\n3.Buying recycled products could provide the recycling industry with a huge boost. Buying recycled paper or glass products not only helps in reducing the amount of waste being produced, but it also helps in promoting the recycling industry.\n'),
                      TextSpan(
                          text:
                              '\n4.It is essential that we take some steps all by ourselves without being dependent on anybody else. We could carry the recyclable wastes all by ourselves to the nearest recycling center. Everyone needs to do their bit in making recycling a success.\n'),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
