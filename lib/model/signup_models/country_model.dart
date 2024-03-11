class Country {
  String countryName;
  String countryImage;
  bool selected;

  Country({
    required this.countryName,
    required this.countryImage,
    this.selected = false,
  });
}
