import 'package:flutter/material.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'no_internet_widget.dart';

class NetworkAwareWidget extends StatefulWidget {
  final Widget child;

  const NetworkAwareWidget({super.key, required this.child});

  @override
  State<NetworkAwareWidget> createState() => _NetworkAwareWidgetState();
}

class _NetworkAwareWidgetState extends State<NetworkAwareWidget> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    DataConnectionChecker().onStatusChange.listen((status) {
      final connected = status == DataConnectionStatus.connected;
      if (mounted && connected != _isConnected) {
        setState(() {
          _isConnected = connected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child, // ✅ Keep the app always alive
        if (!_isConnected)
          const Positioned.fill(
            child: NoInternetWidget(), // 🚫 Overlay on top when disconnected
          ),
      ],
    );
  }
}
