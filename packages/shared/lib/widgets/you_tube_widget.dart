// import 'package:shared/imports.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YouTubeWidget extends StatefulWidget {
//   const YouTubeWidget({
//     super.key,
//     required this.id,
//   });
//
//   final String id;
//
//   @override
//   State<YouTubeWidget> createState() => _YouTubeWidgetState();
// }
//
// class _YouTubeWidgetState extends State<YouTubeWidget> {
//   late YoutubePlayerController _controller;
//   late PlayerState _playerState;
//   late YoutubeMetaData _videoMetaData;
//   double _volume = 100;
//   bool _muted = false;
//   bool _isPlayerReady = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.id,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: false,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//         captionLanguage: 'ru',
//       ),
//     )..addListener(listener);
//     _videoMetaData = const YoutubeMetaData();
//     _playerState = PlayerState.unknown;
//   }
//
//   void listener() {
//     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
//       setState(() {
//         _playerState = _controller.value.playerState;
//         _videoMetaData = _controller.metadata;
//       });
//     }
//   }
//
//   @override
//   void deactivate() {
//     _controller.pause();
//     super.deactivate();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       onExitFullScreen: () {
//         SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//       },
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: Colors.blueAccent,
//         topActions: <Widget>[
//           const SizedBox(width: 8.0),
//           Expanded(
//             child: Text(
//               _controller.metadata.title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//               ),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//           ),
//         ],
//         onReady: () {
//           _isPlayerReady = true;
//         },
//         onEnded: (data) {},
//       ),
//       builder: (context, player) => player,
//     );
//   }
//
//   Color _getStateColor(PlayerState state) {
//     switch (state) {
//       case PlayerState.unknown:
//         return Colors.grey[700]!;
//       case PlayerState.unStarted:
//         return Colors.pink;
//       case PlayerState.ended:
//         return Colors.red;
//       case PlayerState.playing:
//         return Colors.blueAccent;
//       case PlayerState.paused:
//         return Colors.orange;
//       case PlayerState.buffering:
//         return Colors.yellow;
//       case PlayerState.cued:
//         return Colors.blue[900]!;
//       default:
//         return Colors.blue;
//     }
//   }
//
//   Widget get _space => const SizedBox(height: 10);
//
//   // Widget _loadCueButton(String action) {
//   //   return Expanded(
//   //     child: MaterialButton(
//   //       color: Colors.blueAccent,
//   //       onPressed: _isPlayerReady
//   //           ? () {
//   //         if (_idController.text.isNotEmpty) {
//   //           var id = YoutubePlayer.convertUrlToId(
//   //             _idController.text,
//   //           ) ??
//   //               '';
//   //           if (action == 'LOAD') _controller.load(id);
//   //           if (action == 'CUE') _controller.cue(id);
//   //           FocusScope.of(context).requestFocus(FocusNode());
//   //         } else {
//   //           _showSnackBar('Source can\'t be empty!');
//   //         }
//   //       }
//   //           : null,
//   //       disabledColor: Colors.grey,
//   //       disabledTextColor: Colors.black,
//   //       child: Padding(
//   //         padding: const EdgeInsets.symmetric(vertical: 14.0),
//   //         child: Text(
//   //           action,
//   //           style: const TextStyle(
//   //             fontSize: 18.0,
//   //             color: Colors.white,
//   //             fontWeight: FontWeight.w300,
//   //           ),
//   //           textAlign: TextAlign.center,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontWeight: FontWeight.w300,
//             fontSize: 16.0,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//         behavior: SnackBarBehavior.floating,
//         elevation: 1.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//       ),
//     );
//   }
// }
