enum DateRangeOptionEnums {
  allTime(title: 'All Time', value: 'allTime'),
  thisWeek(title: 'This Week', value: 'thisWeek'),
  lastWeek(title: 'Last Week', value: 'lastWeek'),
  thisMonth(title: 'This Month', value: 'thisMonth'),
  lastMonth(title: 'Last Month', value: 'lastMonth'),
  thisYear(title: 'This Year', value: 'thisYear'),
  lastYear(title: 'Last Year', value: 'lastYear'),
  custom(title: 'Custom Dates', value: 'custom');

  final String title;
  final String value;

  const DateRangeOptionEnums({required this.title, required this.value});
}
