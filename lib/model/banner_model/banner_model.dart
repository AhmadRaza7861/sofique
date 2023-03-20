class BannerListModel {
  List<String>? sectionId;
  String? sectionName;
  String? bannerId;
  String? bannerName;
  String? bannerContent;
  String? startdatetime;
  String? enddatetime;
  String? cmspageUrl;
  String? redirectUrl;

  BannerListModel(
      {this.sectionId, this.sectionName, this.bannerId, this.bannerName, this.bannerContent, this.startdatetime, this.enddatetime, this.cmspageUrl, this.redirectUrl});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'].cast<String>();
    sectionName = json['section_name'];
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    bannerContent = json['banner_content'];
    startdatetime = json['startdatetime'];
    enddatetime = json['enddatetime'];
    cmspageUrl = json['cmspage_url'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_id'] = this.sectionId;
    data['section_name'] = this.sectionName;
    data['banner_id'] = this.bannerId;
    data['banner_name'] = this.bannerName;
    data['banner_content'] = this.bannerContent;
    data['startdatetime'] = this.startdatetime;
    data['enddatetime'] = this.enddatetime;
    data['cmspage_url'] = this.cmspageUrl;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
