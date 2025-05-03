class EndPoint {


  static const String bundleEndpoint = "/api/Bundle";
  static const String workersEndpoint = "/api/Worker";
  static const String materialEndpoint = "/api/Material";
  static const String categoriesEndpoint = "/api/Category/with-products";
  static String getProductById(num? productId) =>
      "/api/Product/$productId";

}
