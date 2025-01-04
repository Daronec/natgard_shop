// import 'package:shared/imports.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WebViewWidget extends StatefulWidget {
//   const WebViewWidget({
//     Key? key,
//     required this.link,
//   }) : super(key: key);
//
//   final String link;
//
//   @override
//   State<WebViewWidget> createState() => _WebViewWidgetState();
// }
//
// class _WebViewWidgetState extends State<WebViewWidget> {
//   final urlController = TextEditingController();
//   double progress = 0;
//   PullToRefreshController? pullToRefreshController;
//   InAppWebViewController? webViewController;
//   final GlobalKey webViewKey = GlobalKey();
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return InAppWebView(
//       key: webViewKey,
//       initialUrlRequest: URLRequest(
//         url: WebUri.uri(Uri.parse(widget.link)),
//       ),
//       pullToRefreshController: pullToRefreshController,
//       initialOptions: InAppWebViewGroupOptions(
//         crossPlatform: InAppWebViewOptions(
//           clearCache: true,
//           cacheEnabled: false,
//           transparentBackground: true,
//         ),
//         android: AndroidInAppWebViewOptions(),
//       ),
//       onLoadStart: (controller, url) {},
//       onWebViewCreated: (controller) async {
//         webViewController = controller;
//       },
//       onReceivedServerTrustAuthRequest:
//           (controller, challenge) async {
//         return ServerTrustAuthResponse(
//           action: ServerTrustAuthResponseAction.PROCEED,
//         );
//       },
//       shouldOverrideUrlLoading: (controller, navigationAction) async {
//         var uri = navigationAction.request.url!;
//         if (![
//           "http",
//           "https",
//           "file",
//           "chrome",
//           "data",
//           "javascript",
//           "about"
//         ].contains(uri.scheme)) {
//           if (await canLaunchUrl(uri)) {
//             await launchUrl(
//               uri,
//             );
//             return NavigationActionPolicy.CANCEL;
//           }
//         }
//
//         return NavigationActionPolicy.ALLOW;
//       },
//       onLoadStop: (controller, url) async {
//         setState(() {
//           pullToRefreshController?.endRefreshing();
//         });
//       },
//       onProgressChanged: (controller, progress) {
//         if (progress == 100) {
//           pullToRefreshController?.endRefreshing();
//         }
//         setState(() {
//           this.progress = progress / 100;
//         });
//       },
//       onUpdateVisitedHistory: (controller, url, isReload) async {
//         debugPrint('NEW_URL: ${url?.path}');
//
//         if (url!.path.contains('success')) {
//           print(url.path);
//         }
//         if (url.path.contains('error')) {
//           await webViewController?.clearCache().then((value) {
//             context.pop();
//           });
//         }
//         if (url.path.contains('/payform/undefined')) {
//           await webViewController?.clearCache().then((value) {
//             context.pop();
//           });
//         }
//       },
//       onConsoleMessage: (controller, consoleMessage) {
//         debugPrint(consoleMessage.message);
//       },
//     );
//   }
// }
