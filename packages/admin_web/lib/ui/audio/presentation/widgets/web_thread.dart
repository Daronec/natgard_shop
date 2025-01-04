import 'package:dart_thread/dart_thread.dart';

class WebThread extends DartThread {
  static WebThread newInstance() => WebThread();

  @override
  String jsFileName() {
    return 'WebThread';
  }

  @override
  Future<void> onExecute(Function(dynamic message) sendMessage) async {
    while (true) {
      sendMessage('WORKER');
    }
  }

  @override
  Future<void> onGetMessage(message, Function(dynamic message) sendMessage) async {
    print('Receive message from main thread: $message');
    sendMessage(message);
  }
}

