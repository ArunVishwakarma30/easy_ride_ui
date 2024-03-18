class Config {
  static const String apiUrl =
      'https://easyrideserver-production.up.railway.app';
  static const String signupUrl = '/register';
  static const String loginUrl = '/login';
  static const String userUrl = '/user';
  static const String vehicleUrl = '/vehicle';
  static const String getVehicleUrl = '/vehicle/user';
  static const String createRideUrl = '/createRide';
  static const String getAllCreatedRides = '/createRide/allRides';
  static const String searchRideUrl = '/createRide/search';
  static const String requestRide = '/requestRide';
  static const String getAllRequestedRides = '/requestRide/allRequestRides';
  static const String sendNotification = '/notification/sendNotificationToDevice';
  static const String sendBroadcastNotification = '/notification/sendNotification';
  static const String oneSignalAppId = '2834421f-d872-47bc-a6bf-2a2eacf04413';
  static const String chatUrl = '/chats';
  static const String messagingUrl = "/messages";
  static const String sendOTPUrl = "/otp/createOtp";
  static const String verifyOTPURL = "/otp/verifyOtp";

}
