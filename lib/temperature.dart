class Temperature {

  String main;
  String description;
  String icon;
  var temp;
  var tempMin;
  var tempMax;
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
    this.tempMin = mainMap["temp_min"];
    this.tempMax = mainMap["temp_max"];
    this.pressure = mainMap["pressure"];
    this.humidity = mainMap["humidity"];
  }

}