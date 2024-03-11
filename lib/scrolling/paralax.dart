import 'package:fluter_ui_kit/scrolling/scale_on_scroll.dart';
import 'package:flutter/material.dart';

class SingleParalaxObject extends StatefulWidget {
  const SingleParalaxObject({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<SingleParalaxObject> createState() => _SingleParalaxObjectState();
}

class _SingleParalaxObjectState extends State<SingleParalaxObject> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var renderObject;
    // ignore: prefer_typing_uninitialized_variables
    var offsetY;
    // ignore: prefer_typing_uninitialized_variables
    var screenHeight;
    double relativePosition = 0.5;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        renderObject = context.findRenderObject() as RenderBox;
        offsetY = renderObject.localToGlobal(Offset.zero).dy;
        screenHeight = MediaQuery.of(context).size.height;
        relativePosition = offsetY / screenHeight;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(70),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.cover,
            alignment: Alignment(0, relativePosition - (0.9)),
          ),
        ),
      ),
    );
  }
}

//list view paralax

class ParalaxListView extends StatefulWidget {
  const ParalaxListView({super.key});

  @override
  State<ParalaxListView> createState() => _ParalaxListViewState();
}

class _ParalaxListViewState extends State<ParalaxListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 50,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) => ScalOnScrollWrapper(
            scrollController: _scrollController,
            child: Image.network(
                'https://picsum.photos/seed/${index + 1}/200/300'),
          ),
        );
      },
    );
  }
}
