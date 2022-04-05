import 'config.dart';

class Urls {
  static var register2 = "${Config.imApiUrl()}/auth/user_register";
  static var login2 = "${Config.imApiUrl()}/auth/user_token";
  static var importFriends = "${Config.imApiUrl()}/friend/import_friend";
  static var inviteToGroup = "${Config.imApiUrl()}/group/invite_user_to_group";
  static var onlineStatus =
      "${Config.imApiUrl()}/manager/get_users_online_status";
  static var queryAllUsers = "${Config.imApiUrl()}/manager/get_all_users_uid";

  ///
  // static const getVerificationCode = "/cpc/auth/code";
  // static const checkVerificationCode = "/cpc/auth/verify";
  // static const register = "/cpc/auth/password";
  // static const login = "/cpc/auth/login";

  /// 登录注册 独立于im的业务
  static var getVerificationCode = "${Config.appAuthUrl()}/auth/code";
  static var checkVerificationCode = "${Config.appAuthUrl()}/auth/verify";
  static var setPwd = "${Config.appAuthUrl()}/auth/password";
  static var resetPwd = "${Config.appAuthUrl()}/auth/reset_password";
  static var login = "${Config.appAuthUrl()}/auth/login";
  static var upgrade = "${Config.appAuthUrl()}/app/check";

  /// office
  static var getUserTags = "${Config.imApiUrl()}/office/get_user_tags";
  static var createTag = "${Config.imApiUrl()}/office/create_tag";
  static var deleteTag = "${Config.imApiUrl()}/office/delete_tag";
  static var updateTag = "${Config.imApiUrl()}/office/set_tag";
  static var sendMsgToTag = "${Config.imApiUrl()}/office/send_msg_to_tag";
  static var getSendTagLog = "${Config.imApiUrl()}/office/get_send_tag_log";
}
