import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const SecondPage();
            }));
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SliverFlexibleAppBar(),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        color: (index.isEven ? Colors.blue : Colors.green)
                            .withOpacity(0.5),
                        height: 100,
                        child: Text('$index'),
                      ),
                  childCount: 100),
            )
          ],
        ),
      ),
    );
  }
}

class SliverFlexibleAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {


    TextPainter textPainter = TextPainter(text: const TextSpan(text:'Hello'),textDirection: TextDirection.ltr);

    textPainter.layout();

    print(textPainter.height);

    bool isHidden = shrinkOffset >= maxExtent - (minExtent);

    return AppBar(
      backgroundColor: isHidden ? Colors.pink : Colors.yellow,
      title: isHidden ? const Text('Title',) : null,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      flexibleSpace: isHidden
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(maxExtent - minExtent),
              child:  Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: maxExtent - (minExtent) - shrinkOffset,
                  width: MediaQuery.sizeOf(context).width,
                  child: const Padding(
                    padding: EdgeInsets.only(left:16.0),
                    child: Text('Hello',style: TextStyle(fontSize: 30),),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
