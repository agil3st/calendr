class CountryDetails {
  final String country;
  final String countryCode;
  final int year;

  CountryDetails({
    this.country = 'Indonesia',
    this.countryCode = 'id',
    this.year = 2010,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) => CountryDetails(
    country: json['country'],
    countryCode: json['country_code'],
    year: json['year'],
  );
}
