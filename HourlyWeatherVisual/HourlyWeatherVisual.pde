
Weather cityData;

void setup(){
  cityData = new Weather();
  print("Min and max values for each of the attributes are:");
  print("\n");
  print("Humidity ===> Min: " + cityData.getHumMin() + " Max: " +cityData.getHumMax() +"\n");
  print("Pressure ===> Min: " + cityData.getPressMin() + " Max: " +cityData.getPressMax() +"\n");
  print("Temperature ===> Min: " + cityData.getTempMin() + " Max: " +cityData.getTempMax() +"\n");
  print("WindDirection ===> Min: " + cityData.getDirectionMin() + " Max: " +cityData.getDirectionMax() +"\n");
  print("WindSpeed ===> Min: " + cityData.getSpeedMin() + " Max: " +cityData.getSpeedMax() +"\n");
  
  // we can use the data as below:
  Map<String, City> data = cityData.getTimeSeriesData();
  int count = 1;
  for(String key : data.keySet()){
    print(key);
    print("\n");
    City city = data.get(key);
    print(city.getHumidity());
    print("\n");
    print(city.getPressure());
    print("\n");
    count++;
    if (count>10){
      break;
    }
  }
}

void draw(){
  
}
