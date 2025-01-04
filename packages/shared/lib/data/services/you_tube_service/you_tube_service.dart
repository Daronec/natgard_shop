import 'package:retrofit/retrofit.dart';
import 'package:shared/imports.dart';

part 'you_tube_service.g.dart';

@RestApi()
abstract class YouTubeService {
  factory YouTubeService(Dio dio, {String baseUrl}) = _YouTubeService;


  @GET('https://www.youtube.com/{channelId}/videos')
  Future<String?> fetchChannelData(String channelId);

}
