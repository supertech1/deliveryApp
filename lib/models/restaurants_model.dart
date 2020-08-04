class Restaurant {
  final String vendorId;
  final String storeName;
  final String address;
  final String logo;
  final String regionId;
  final String openingTime, closingTime, restaurantId;
  final String
      arrangement; //NB: arrangement used to determine popular restaurants in the app for the first 4

  Restaurant(
      {this.vendorId,
      this.storeName,
      this.address,
      this.logo,
      this.regionId,
      this.openingTime,
      this.closingTime,
      this.arrangement,
      this.restaurantId});
}
