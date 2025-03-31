enum NotificationTypeEnums {
  cityWise(title: 'City Wise ', value: 'CityWise', name: 'CITY_WISE'),
  areaWise(title: 'Area Wise ', value: 'AreaWise', name: 'AREA_WISE');

  const NotificationTypeEnums({
    required this.title,
    required this.value,
    required this.name,
  });

  final String title;
  final String value;
  final String name;
}
