
Weather cityData;
// filter variables
Set<String> selectedCityList = new HashSet<String>();
Set<Integer> selectedYearList = new HashSet<Integer>();
Set<String> selectedAttributeList = new HashSet<String>();
String selectedCountry;
float xStart = 50, xEnd, yStart =75, yEnd, bottomMargin = 50;
float pixelSpacingYHum, pixelSpacingYTemp, pixelSpacingX = 0.01;
float numValXaxis = 6*12*31*24;
Map<String, City> data;

void setup(){
  size(800, 600);
  cityData = new Weather();
  print("Min and max values for each of the attributes are:");
  print("\n");
  print("Humidity ===> Min: " + cityData.getHumMin() + " Max: " +cityData.getHumMax() +"\n");
  print("Pressure ===> Min: " + cityData.getPressMin() + " Max: " +cityData.getPressMax() +"\n");
  print("Temperature ===> Min: " + cityData.getTempMin() + " Max: " +cityData.getTempMax() +"\n");
  print("WindDirection ===> Min: " + cityData.getDirectionMin() + " Max: " +cityData.getDirectionMax() +"\n");
  print("WindSpeed ===> Min: " + cityData.getSpeedMin() + " Max: " +cityData.getSpeedMax() +"\n");
  print("Date ===> Min: " + cityData.getMinDate() + " Max: " +cityData.getMaxDate() +"\n");
  
  pixelSpacingYHum = (height - yStart - bottomMargin)  / (cityData.getHumMax()- cityData.getHumMin());
  pixelSpacingYTemp = (height - yStart - bottomMargin)  / (cityData.getTempMax()- cityData.getTempMin());
  yEnd = height - bottomMargin;
  xEnd = (numValXaxis)* pixelSpacingX + xStart;
  print(yEnd + "\n");
  print(xEnd + "\n");
  smooth();
  
  for(int year: cityData.getYearList()){
    print(year + "\n");
  }
  
  for(String city: cityData.getCityList()){
    print(city + "\n");
  }
  
  for(String country: cityData.getCountryList()){
    print(country + "\n");
  }
  
  for(String attribute: cityData.getAttributeList()){
    print(attribute + "\n");
  }
  
  // we can use the data as below:
  data = cityData.getTimeSeriesData();
  int count = 1;
  for(String key : data.keySet()){
    print(key);
    print("\n");
    City city = data.get(key);
    print(city.getHumidity());
    print("\n");
    print(city.getPressure());
    print("\n");
    print(city.getRecordDate());
    print("\n");
    count++;
    if (count>10){
      break;
    }
  }
  background(224);
  fill(255);
  rectMode(CORNERS);
  noStroke( );
  rect(xStart, yStart, xEnd, yEnd);
  
  //Plot humidity
  drawDataPoints();
}

void draw(){
  
}

void drawDataPoints(){
  for(String key : data.keySet()){
    City city = data.get(key);
    if("Albuquerque".equals(city.getName())){
      float xVal = calculateXPos(city.getRecordDate()) * pixelSpacingX + xStart;
      float yValHum = yEnd - (city.getHumidity() * pixelSpacingYHum);
      float yValTemp = yEnd - (city.getTemperature() * pixelSpacingYTemp);
      //print(city.getHumidity()+"\n");
      fill(#0080ff);
      ellipse(xVal, yValHum, 1, 2);
    }
    
  }
}

// TODO: remove deprecated methods
float calculateXPos(Date currentDate){
  float xPos = (currentDate.getYear()-cityData.getMinDate().getYear()) * 12*31*24 +
                (currentDate.getMonth() - cityData.getMinDate().getMonth()) *31*24 +  
                (currentDate.getDate() - cityData.getMinDate().getDate()) * 24 +
                (currentDate.getHours() - cityData.getMinDate().getHours());
                //print(currentDate + " | "+xPos + "\n");
  return xPos;
}
