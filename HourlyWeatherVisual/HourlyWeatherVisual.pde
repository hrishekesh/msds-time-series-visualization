
Weather cityData;
// filter variables
List<String> cityList;
Set<Integer> selectedYearList = new HashSet<Integer>();
Set<String> selectedAttributeList = new HashSet<String>();
String selectedCity = "New York";
float xStart = 50, xEnd, yStart =75, yEnd, bottomMargin = 50;
float pixelSpacingYHum, pixelSpacingYTemp;
float numValXaxis, xWidth = 800;
CheckBox cityCheckbox;
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
  
  numValXaxis = (cityData.getMaxDate().getTime() - cityData.getMinDate().getTime())/xWidth;
  print(numValXaxis + "\n");
  pixelSpacingYHum = (height - yStart - bottomMargin)  / (cityData.getHumMax()
                      - cityData.getHumMin());
  pixelSpacingYTemp = (height - yStart - bottomMargin)  / (cityData.getTempMax() 
                      - cityData.getTempMin());
  yEnd = height - bottomMargin;
  xEnd = xWidth + xStart;
  
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
  cityList = new ArrayList<String>(cityData.getCityList());
  cityCheckbox= new CheckBox();
}

void draw(){
  background(224);
  fill(255);
  rectMode(CORNERS);
  noStroke( );
  rect(xStart, yStart, xEnd, yEnd);
  //Plot humidity
  drawDataPoints();
  addYaxisLabels();
  textAlign(LEFT);
  cityCheckbox.setContainer(xEnd + 10, yStart, xEnd + 10 + 125, yStart + 415);
  cityCheckbox.setValues(cityList);
  cityCheckbox.setName("Select City");
  cityCheckbox.setSelected(selectedCity);
  cityCheckbox.drawSelectBox();
}

void drawDataPoints(){
  for(String key : data.keySet()){
    City city = data.get(key);
    if(selectedCity.equals(city.getName())){
      float xVal = (city.getRecordDate().getTime() - cityData.getMinDate().getTime()) 
                    /numValXaxis + xStart;
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
    String recordDate;
    float xVal = 0 + xStart;
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
      xVal = (convertedRecordDate.getTime() - cityData.getMinDate().getTime())/numValXaxis 
                   + xStart;
    }
      print(year + " | " + xVal + "\n");
      text(year, xVal, yEnd+15);
      stroke(126);
      line(xVal, yStart, xVal, yEnd);
  }
}

void mousePressed(){
    //print(mouseX + " | " + mouseY + "\n");
    if (mouseX > cityCheckbox.getxStart()+5 &&  mouseX < cityCheckbox.getxStart()+15
        && mouseY > cityCheckbox.getyStart()+15 ){
          int probableSelection = (int)(mouseY - (cityCheckbox.getyStart()+15)) / 15;
          int inCheckBox = (int)(mouseY - (cityCheckbox.getyStart()+15)) % 15;
          if (inCheckBox <= 10 && probableSelection < cityList.size()){
            selectedCity = cityList.get(probableSelection);
          }
    }
  }
