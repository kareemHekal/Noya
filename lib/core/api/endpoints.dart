class EndPoint {


  static const String bundleEndpoint = "/api/Bundle";
  static String getProductById(num? productId) =>
      "/api/Product/$productId";

}
