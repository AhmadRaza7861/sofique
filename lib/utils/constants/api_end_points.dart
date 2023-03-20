class APIEndPoints {
  // static String get baseUri => 'https://dev.sofiqe.com/rest/V1';
  // static String get baseDefaultUri => 'https://dev.sofiqe.com/rest/default/V1';
  // static String get mybaseUri => 'https://dev.sofiqe.com/index.php/rest/V1';

  // static String get shareBaseUrl => 'https://dev.sofiqe.com/';
  static String get baseUri => 'https://sofiqe.com/rest/V1';

  static String get baseUri1 => 'https://sofiqe.com';

  static String get baseDefaultUri => 'https://sofiqe.com/rest/default/V1';

  static String get mybaseUri => 'https://sofiqe.com/index.php/rest/V1';

  static String get shareBaseUrl => 'https://sofiqe.com/';

  static String nonRecommendedColourProducts(String id) {
    return '$baseUri/products?searchCriteria[filterGroups][0][filters][0][field]=entity_id&searchCriteria[filterGroups][0][filters][0][value]=$id&&searchCriteria[filterGroups][0][filters][0][field]=visibility&searchCriteria[filterGroups][0][filters][0][value]=4&searchCriteria[filterGroups][0][filters][0][condition_type]=eq';
  }

  static String get faceAreasAndParameters {
    return '$baseUri/custom/getFaceSubArea';
  }

  static String get faceAreaCategory {
    return '$baseUri/categories';
  }

  static String get brandNames {
    return '$baseUri/custom/brandFilterTags';
  }

  static String get getproductwarning {
    return '$baseUri/customer/getproductwarning/';
  }

  static String get subscribe {
    return '$baseUri/custom/premiumSubscribe';
  }

  static String get scanProduct {
    return '$baseUri/custom/scanProduct';
  }

  static String get getDealOfTheDay {
    return '$baseUri/custom/getDeals/';
  }

  static String InVoices({required String OrderId}) {
    return '$baseUri/rest/default/V1/order/$OrderId/invoice';
  }

  //-----API 39 Selfie Post
  static String get uploadUserSelfie {
    return '$baseUri/selfie/postSelfie';
  }

  //-----API 40 Selfie Get
  static String get getUserSelfie {
    return '$baseUri/selfie/getSelfie';
  }

  static String get getVendorDealsById {
    return '$baseUri/custom/getVendorDealsById';
  }

  static String get getBestSellersList {
    return '$mybaseUri/custom/bestsellers';
  }

  static String productRecommendedProductsFilteredByApplicationArea(String color, String faceArea, String faceSubArea) {
    return '$baseUri/products?searchCriteria[filterGroups][0][filters][0][field]=face_color&searchCriteria[filterGroups][0][filters][0][condition_type]=eq&searchCriteria[filterGroups][0][filters][0][field]=visibility&searchCriteria[filterGroups][0][filters][0][value]=4&searchCriteria[filterGroups][0][filters][0][value]=$color&searchCriteria[filterGroups][1][filters][0][field]=face_area&searchCriteria[filterGroups][1][filters][0][condition_type]=eq&searchCriteria[filterGroups][1][filters][0][value]=$faceArea&searchCriteria[filterGroups][1][filters][0][field]=face_sub_area&searchCriteria[filterGroups][1][filters][0][condition_type]=eq&searchCriteria[filterGroups][1][filters][0][value]=$faceSubArea';
  }

  static String get getNonRecommendedColors {
    return '$baseUri/custom/getAllColours';
  }

  static String get getRecommendedColors {
    return '$baseUri/custom/searchCentralColor';
  }

  static String get getFreeShippingInfo {
    return '$baseUri/custom/getfreeshippingamount';
  }

  static String get saveProfilePicture {
    return '$baseUri/selfie/postSelfie';
    // return '$baseUri/custom/updateProfileImage';
  }

  static String get countryDetails {
    return '$baseUri/directory/countries';
  }

  static String get questionnaireResponse {
    return '$baseUri/custom/getSaveProfileQuestion';
  }

  static String get productStatic {
    return '$baseUri/custom/getProductStatic/';
  }

  static String get catalogUnfiltereditems {
    return '$baseUri/products?searchCriteria[pageSize]=12&searchCriteria[currentPage]=';
  }

  static String unfilteredFaceAreaItems(int page, int faceArea) {
    return '$baseUri/products?searchCriteria[pageSize]=12&searchCriteria[currentPage]=$page&searchCriteria[filterGroups][0][filters][0][field]=visibility&searchCriteria[filterGroups][0][filters][0][value]=4&searchCriteria[filterGroups][1][filters][0][condition_type]=eq&searchCriteria[filterGroups][1][filters][0][value]=$faceArea&searchCriteria[filterGroups][1][filters][0][field]=category_id';
  }

  static String get searchSkinTone {
    return '$baseUri/custom/searchSkinTone';
  }

  static String get catalogPopularItems {
    return '$baseUri/custom/getPopularProducts';
  }

  static String get brandFilteredItems {
    return '$baseUri/custom/filterByBrand';
  }

  static String get searchedSKinToneItems {
    return '$baseUri/custom/searchSkinTone';
  }

  static String get alternateColorProducts {
    return '$baseUri/custom/searchAlternateColor';
  }

  static String get centralColorProducts {
    return '$baseUri/custom/searchCentralColor';
  }

  static String productItems(int page, int faceSubArea) {
    return '$baseUri/products?searchCriteria[pageSize]=12&searchCriteria[currentPage]=$page&searchCriteria[filterGroups][0][filters][0][field]=visibility&searchCriteria[filterGroups][0][filters][0][value]=4&searchCriteria[filterGroups][1][filters][0][condition_type]=eq&searchCriteria[filterGroups][1][filters][0][value]=$faceSubArea&searchCriteria[filterGroups][1][filters][0][field]=category_id';
  }

  static String get catalogBetweenPriceItems {
    return '$baseUri/custom/filterByPriceRange';
  }

  static String searchedItems(String query) {
    return '$baseUri/custom/products?searchCriteria[filter_groups][0][filters][0][field]=name&searchCriteria[filterGroups][0][filters][0][field]=visibility&searchCriteria[filterGroups][0][filters][0][value]=4&searchCriteria[filter_groups][0][filters][0][value]=%$query%&searchCriteria[filter_groups][0][filters][0][condition_type]=like';
  }

  static String get getWishlist {
    return '$baseUri/wishlist/items/';
  }

  static String get setUserFCMToken {
    return '$baseUri/firebase/set/fcmtoken/';
  }

//160
  static String get getUser {
    return '$baseUri/customers/me';
  }

  static String get resetPassword {
    return '$baseUri/customers/password';
  }

  static String get signup {
    return '$baseUri/customers';
  }

  static String get emailAvailability {
    return '$baseUri/customers/isEmailAvailable';
  }

  static String get login {
    return '$baseUri/integration/customer/token';
  }

  static String get productBySKU {
    return '$baseUri/products/';
  }

  static String getConfigurableProductChildren(String sku) {
    return '$baseUri/configurable-products/$sku/children';
  }

  //for ingredients
  static String get getIngredients {
    // return 'https://dev.sofiqe.com/rest/V1/ingredients';
    return 'https://sofiqe.com/rest/V1/ingredients';
  }

//may be 98....
  static String get shippingAddressByCustomerId {
    return '$baseUri/customers/me/shippingAddress';
  }

  static String get guestCartNewInstance {
    return '$baseUri/guest-carts';
  }

  static String get guestCartDetails {
    return '$baseUri/guest-carts/';
  }

  // Araj 136.a
  static String guestCartList(String cartToken) {
    return '$baseUri/guest-carts/$cartToken/items';
  }

  //Araj Api 151
  static String guestVipToken() {
    return '$baseDefaultUri/rewards/earningRules';
  }

  static String userVipToken({required int cartId}) {
    return '$baseUri/carts/$cartId/totals-information';
  }

  static String getTiersList() {
    return '$baseDefaultUri/rewards/tiers';
  }

  static String spendingRules() {
    return '$baseDefaultUri/rewards/spendingRules';
  }

  //Araj Api 153
  static String getCustomerPoints(customerID) {
    return '$baseDefaultUri/rewards/balances/$customerID';
  }

  static String get userCartDetails {
    return '$baseUri/carts/mine/';
  }

  static String get userCartList {
    return '$baseUri/carts/mine/items';
  }

  static String get questionnaireList {
    return '$baseUri/questionnaire/questions';
  }

  static String get mediaBaseUrl {
    // return 'http://dev.sofiqe.com/media/catalog/product';
    return 'https://sofiqe.com/media/catalog/product';
  }

  static String get addItemToWishList {
    return '$baseUri/wishlist/add/';
  }

  static String get removeItemToWishList {
    return '$baseUri/wishlist/remove/';
  }

  static String get shareWishList {
    return '$baseUri/wishlist/share';
  }

  static String get createReview {
    return '$baseUri/reviews';
  }

  // rate filter api
  static String fetchRatedItems({required int star}) {
    /* rating number */
    return '$baseUri/reviews/filter/$star';
  }

  static String addToCartGuest({required String cartId}) {
    return '$baseUri/guest-carts/$cartId/items';
  }

  static String addToCartCustomer({required String cartId}) {
    return '$baseUri/carts/mine/items';
  }

  // Araj Api 159
  static String addShippingAddress(String cartId) => "$baseUri/guest-carts/$cartId/shipping-information";

  static String addShippingAddressuser(String cartId) => "$baseUri/carts/$cartId/shipping-information";

// Araj Api 159a
  static String estimateShippingCost(var cartId) => "$baseUri/guest-carts/$cartId/estimate-shipping-methods";

  static String removeFromCartCustomer({required String itemId}) => "$baseUri/carts/mine/items/$itemId";

  static String removeFromCartGuest({required String cartId, required String itemId}) =>
      "$baseUri/guest-carts/$cartId/items/$itemId";

  static String removeAllFromCartGuest({required String cartId}) =>
      "$baseUri/guest-carts/$cartId/deletecart";

  static String removeAllFromCartCustomer({required String cartId}) => "$baseUri/carts/$cartId/deletecart";

  //Araj Api 161.Place order, Guest
  static String placeOrder(String cartId) => "$baseUri/guest-carts/$cartId/order";

  //Api 94.b. get Order Details
  static String getOrderDetails(String orderId) => "$baseUri/ms2/orders/order/$orderId";

  //Araj Api 150. Order with reward points
  static String placeCustOrder(int cartId) => "$baseUri/carts/$cartId/order";

  static Map<String, String> headers(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  //Araj for API 148
  static String getPaymentMethods(int cartId) => "$baseUri/carts/$cartId/payment-methods";

//Araj API 160 get payment methods: for guest
  static String getPaymentMethodsForGuest(String cartId) => "$baseUri/guest-carts/$cartId/payment-information";

//API to Set Payment Information
  static String setPaymentInformationForGuest(String cartId) => "$baseUri/guest-carts/$cartId/set-payment-information";

//Araj for API 149a
  static String selectedPaymentMethod(int cartId) => "$baseUri/carts/$cartId/selected-payment-method";

  static String paymentInformationCustomer(int cartId) => "$baseUri/carts/$cartId/payment-information";

//Araj for API 112a
  static String getClearPayToken() => "$baseUri1/rest/default/V1/clearpay/checkout";

//Araj for API 111a
  static String getPaypalToken() => "$baseUri1/rest/default/V1/paypalapi/createpaypalexpresstoken";

//Araj API 113.a. Generate giftcard
  static String generateGiftCard() => "$baseUri/Webkul_GiftCard/Email";

//Araj API 113.b. apply giftcard
  static String applyGiftCard(String giftCard) => "$baseUri/custom/giftcode/$giftCard";

//Araj API 147 apply rewardpoint
  static String applyRewardpoint(int cartId, int rewardPoints) => "$baseUri/rewards/$cartId/apply/$rewardPoints";

//Araj API 146
  static String applyShippingMethod(int cartId) => "$baseUri/carts/$cartId/shipping-information";

  //API 6.C
  static String getShippingaDDres(int CustomerId) => "$baseUri/customers/$CustomerId/shippingAddress";
  //API 6.b
  static String getBillingaDDres(int CustomerId) => "$baseUri/customers/$CustomerId/billingAddress";

  //Araj API 139. Merge Guest cart after a guest has registered
  static String applyGuestHasRegistered(int guestCardId) => "$baseUri/guest-carts/gurstcartID";

  /// Get Active Banner List URL
  static String getActiveBannerListAPI = "${baseUri1}/rest/V1/custom/getactivebannerlist";
}
