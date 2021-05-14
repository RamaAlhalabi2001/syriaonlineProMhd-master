class ServicesModel {
  ServicesModel(
      {this.serviceId,
      this.accountId,
      this.serviceName,
      this.serviceDescription,
      this.x,
      this.y,
      this.mangerAccept,
      this.picture,
      this.servicePhoneNumber,
      this.serviceCatogaryId,
      this.createdAt,
      this.updatedAt});

  final int serviceId;
  final String accountId;
  final String serviceName;
  final String serviceDescription;
  final String x;
  final String y;
  final String mangerAccept;
  final String picture;
  final String servicePhoneNumber;
  final String serviceCatogaryId;
  final String createdAt;
  final String updatedAt;

//to get service///////////////

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        serviceId: json["service_id"],
        accountId: json["account_id"],
        serviceName: json["service_name"],
        serviceDescription: json["service_description"],
        x: json["x"],
        y: json["y"],
        mangerAccept: json["manger_accept"],
        picture: json["picture"],
        servicePhoneNumber: json["service_phone_number"],
        serviceCatogaryId: json["service_catogary_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
//to add service///////////////
  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "service_name": serviceName,
        "service_description": serviceDescription,
        "x": x,
        "y": y,
        "manger_accept": mangerAccept,
        "picture": picture,
        "service_phone_number": servicePhoneNumber,
        "service_catogary_id": serviceCatogaryId,
      };
}
