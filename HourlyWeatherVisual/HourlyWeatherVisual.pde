
Weather cityData;

void setup(){
  cityData = new Weather();
  
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
