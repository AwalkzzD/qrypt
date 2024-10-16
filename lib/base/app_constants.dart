class Constants {
  static const String identityServerUri = "https://identity.classter.com/";
  static const String clientId = "63774826-4c6c-4535-a7a0-bc5e2526c0b4";
  static const String clientSecret = "a8f6d768-20bd-4c1d-91ec-6aa06760eb5d";

/*  static const String clientId = "f3f80cf0-0ed1-43fc-aba8-ba2bd1a88941";
  static const String clientSecret = "891bde08-3c7d-49c3-ba8f-9dd376a0dcd8";*/

  static const String responseType = "code id_token";
  static const String scope = "openid profile roles consumer_api offline_access mobile";

  static const String authorizeEndPoint = "${identityServerUri}ids/connect/authorize";
  static const String tokenEndpoint = "${identityServerUri}ids/connect/token";
  static const String sessionEndpoint = "${identityServerUri}ids/connect/endsession";

  static const String logInCallBack = "m-app://15814b16-c2ae-44b2-a644-8291bb5b0996/";
  static const String logOutCallBack = "m-app://c3a41f45-ef86-44c9-83a7-c7132f443dc4/";

  static const String placeHolderText = "-";

  /// social media pages
  static const String infoContactPhone = "+30 2510 242632";
  static const String infoContactEmail = "info@classter.com";
  static const String infoFbPageApp = "fb://page/208158912648105";
  static const String infoFbPageWeb = "https://www.facebook.com/ClassterPage/";
  static const String infoTwitterApp = "twitter://user?user_id=4557030377";
  static const String infoTwitterWeb = "https://twitter.com/ClassterCom";
  static const String infoYoutubeWeb = "https://www.youtube.com/channel/UC_ECo2Of69Zz2NZaxtFzWHg";
  static const String infoLinkedInWeb = "https://www.linkedin.com/company/classter";

  /// File limitations and compress constants
  static const int limitPerMessage = 15728640;  // 15 MB
  static const int limitPerFile = 2621440;  // 2.5 MB
  static const int noCompressSize = 524288; //0.5 MB
  static const int maximumCompressionPerc = 80;
  static const int minimumCompressionPerc = 30;

  /// Consent files
  static const int limitAllFilesSize = 13107200;  // 12.5 MB
  static const int limitFilesCount = 5;

}