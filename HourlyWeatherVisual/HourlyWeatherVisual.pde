
Weather cityData;
// filter variables
Set<String> selectedCityList = new HashSet<String>();
Set<Integer> selectedYearList = new HashSet<Integer>();
Set<String> selectedAttributeList = new HashSet<String>();
String selectedCountry;
float xStart = 50, xEnd, yStart =75, yEnd, bottomMargin = 50;
float pixelSpacingYHum, pixelSpacingYTemp, pixelSpacingX = 0.0000001;
float numValXaxis, xScale = 20;
Map<String, City> data;

void setup(){
  size(1000, 600);
  cityData = new Weather();
  print("Min and max values for each of the attributes are:");
  print("\n");
  print("Humidity ===> Min: " + cityData.getHumMin() + " Max: " +cityData.getHumMax() +"\n");
  print("Pressure ===> Min: " + cityData.getPressMin() + " Max: " +cityData.getPressMax() +"\n");
  print("Temperaturn: " + cityData.getTempMin() + " Max: " +cityData.getTempMax() +"\n");
  print("WindDirection ===> Min: " + cityData.getDirectionMin() + " Max: " +
                cityData.getDirectionMax() +"\n");
  print("WindSpeed ===> Min: " + cityData.getSpeedMin() + " Max: " +cityData.getSpeedMax() +"\n");
  print("Date ===> Min: " + cityData.getMinDate() + " Max: " +cityData.getMaxDate() +"\n");
  
  numValXaxis = (cityData.getMaxDate().getTime() - cityData.getMinDate().getTime())/xScale;
  print(numValXaxis + "\n");
  pixelSpacingYHum = (height - yStart - bottomMargin)  / (cityData.getHumMax()
                      - cityData.getHumMin());
  pixelSpacingYTemp = (height - yStart - bottomMargin)  / (cityData.getTempMax() 
                      - cityData.getTempMin());
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
  addYaxisLabels();
}

void draw(){
  
}

void drawDataPoints(){
  for(String key : data.keySet()){
    City city = data.get(key);
    if("Albuquerque".equals(city.getName())){
      float xVal = (city.getRecordDate().getTime() - cityData.getMinDate().getTime()) 
                    * pixelSpacingX * 3.0+ xStart;
      float yValHum = yEnd - (city.getHumidity() * pixelSpacingYHum);
      float yValTemp = yEnd - (city.getTemperature() * pixelSpacingYTemp);
      //print(city.getHumidity()+"\n");
      fill(#0080ff);
      ellipse(xVal, yValHum, 1, 2);
      
      fill(#ffff00);
      ellipse(xVal, yValTemp, 1, 2);
    }
    
  }
}

void addYaxisLabels(){
  fill(0);
  textAlign(CENTER);
  for (int year: cityData.getYearList()){
    String recordDate = "2012-01-01 00:00:00";
    if (year > 2012){
      recordDate = year + "-01-01 00:00:00";
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
      Date convertedRecordDate = new Date(); 
      try {
        convertedRecordDate= sdf.parse(recordDate);
      } catch (ParseException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
      float xVal = (convertedRecordDate.getTime() - cityData.getMinDate().getTime()) 
                  * pixelSpacingX / xScale + xStart;
      print(year + " | " + xVal + "\n");
      text(year, xVal, yEnd+15);
    }
  }
}
