class Temperature {

  String main;
  String description;
  String icon;
  var temp;
  var temp_min;
  var temp_max;
  var pressure;
  var humidity;

  Temperature(Map map) {
    List weather = map["weather"];

    Map weatherMap = weather.first;
    this.main = weatherMap["main"];
    this.description = weatherMap["description"];
    this.icon = weatherMap["icon"];

    Map mainMap = map["main"];
    this.temp = mainMap["temp"];
    this.temp_min = mainMap["temp_min"];
    this.temp_max = mainMap["temp_max"];
    this.pressure = mainMap["pressure"];
    this.humidity = mainMap["humidity"];
  }

}