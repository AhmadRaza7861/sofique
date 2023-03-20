class ShareWishListModel {
  final String emails;
  final String message;
  ShareWishListModel({required this.emails, required this.message});
  ShareWishListModel.fromJson(Map<String, dynamic> json)
      : emails = json['emails'],
        message = json['message'];

  static Map<String, dynamic> toJson(ShareWishListModel value) =>
      {'emails': value.emails, 'message': value.message};
}