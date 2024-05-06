import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MobileDetails extends StatefulWidget {
  final int id;
  final bool isChatOpened;
  final String? messageId;
  final GlobalKey<ScaffoldState> globalKey;
  const MobileDetails({
    super.key,
    required this.id,
    required this.isChatOpened,
    required this.messageId,
    required this.globalKey,
  });

  @override
  State<MobileDetails> createState() => _MobileDetailsState();
}

class _MobileDetailsState extends State<MobileDetails> {
  PersistentBottomSheetController? _controller;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        if (widget.isChatOpened) {
          _showBottomSheet(context);
        } else {
          if (_controller != null) {
            _controller!.close();
          }
        }
      },
    );
    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    _controller = widget.globalKey.currentState?.showBottomSheet(
      (context) => Container(
        height: 200,
        color: Colors.red,
        child: Center(
          child: Text(widget.messageId ?? 'No messages selected'),
        ),
      ),
      backgroundColor: Colors.blue,
    );
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return Container(
    //       height: 200,
    //       color: Colors.red,
    //       child: Center(
    //         child: Text(widget.messageId ?? 'No messages selected'),
    //       ),
    //     );
    //   },
    // ).whenComplete(() => context.go('/home/details/${widget.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.globalKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Curr id is ${widget.id}'),
            ElevatedButton(
              onPressed: () => context.go('/home/details/500?chat'),
              child: Text('Open chat'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/home/details/500'),
              child: Text('Close chat'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.go('/home/details/500?chat&messageId=123123123'),
              child: Text('Open Message'),
            )
          ],
        ),
      ),
    );
  }
}
