import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:openim_enterprise_chat/src/models/emoji_info.dart';
import 'package:openim_enterprise_chat/src/utils/data_persistence.dart';
import 'package:openim_enterprise_chat/src/utils/http_util.dart';
import 'package:openim_enterprise_chat/src/widgets/loading_view.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner build --delete-conflicting-outputs
///
class CacheController extends GetxController {
  var favoriteList = <EmojiInfo>[].obs;
  late Box favoriteBox;

  String get userID => DataPersistence.getLoginCertificate()!.userID;

  void addFavoriteFromUrl(String? url, int? width, int? height) {
    var emoji = EmojiInfo(url: url, width: width, height: height);
    favoriteList.insert(0, emoji);
    favoriteBox.put(userID, favoriteList);
  }

  void addFavoriteFromPath(String path, int width, int height) async {
    var url = await LoadingView.singleton.wrap(
      asyncFunction: () => HttpUtil.uploadImageForMinio(path: path),
    );
    var emoji = EmojiInfo(url: url, width: width, height: height);
    favoriteList.insert(0, emoji);
    favoriteBox.put(userID, favoriteList);
  }

  void delFavorite(String url) {
    favoriteList.removeWhere((element) => element.url == url);
    favoriteBox.put(userID, favoriteList);
  }

  void delFavoriteList(List<String> urlList) {
    for (final url in urlList) {
      favoriteList.removeWhere((element) => element.url == url);
    }
    favoriteBox.put(userID, favoriteList);
  }

  initFavoriteEmoji() {
    var list = favoriteBox.get(userID, defaultValue: <EmojiInfo>[]);
    favoriteList.assignAll((list as List).cast());
  }

  List<String> get urlList => favoriteList.map((e) => e.url!).toList();

  @override
  void onClose() {
    Hive.close();
    super.onClose();
  }

  @override
  void onInit() async {
    // Register Adapter
    Hive.registerAdapter(EmojiInfoAdapter());
    // open
    favoriteBox = await Hive.openBox<List>('favoriteEmoji');
    super.onInit();
  }
}
