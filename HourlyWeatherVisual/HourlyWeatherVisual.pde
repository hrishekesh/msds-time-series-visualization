import java.util.Collections;

Weather cityData;
// filter variables
List<String> cityList;
Set<Integer> selectedYearList = new HashSet<Integer>();
Set<String> selectedAttributeList = new HashSet<String>();
String selectedCity = "New York";
float xStart = 50, xEnd, yStart =75, yEnd, bottomMargin = 50;
float pixelSpacingYHum, pixelSpacingYTemp, pixelSpacingYPress;
float numValXaxis, xWidth = 800;
CheckBox cityCheckbox;
Map<String, City> data;
HScrollbar hs;
Map<Integer, Integer> yearToPixelMapping = new HashMap<Integer, Integer>();
int selectedYear = 0;

void setup(){
  text("Loading. Please wait . . . ", 500, 500);
  size(1000, 600);
  cityData = new Weather();
  numValXaxis = (cityData.getMaxDate().getTime() - cityData.getMinDate().getTime())/xWidth;
  pixelSpacingYHum = (height - yStart - bottomMargin)  / (cityData.getHumMax()
                      - cityData.getHumMin());
  pixelSpacingYTemp = (height - yStart - bottomMargin)  / (cityData.getTempMax() 
                      - cityData.getTempMin());
  pixelSpacingYPress = (height - yStart - bottomMargin)  / (cityData.getPressMax() 
                      - cityData.getPressMin());
  yEnd = height - bottomMargin;
  xEnd = xWidth + xStart;
  
  smooth();
  
  data = cityData.getTimeSeriesData();

  cityList = new ArrayList<String>(cityData.getCityList());
  cityCheckbox= new CheckBox();
  
  hs = new HScrollbar(xStart, yEnd +20, xEnd);
}

void draw(){
  background(224);
  fill(255);
  rectMode(CORNERS);
  noStroke( );
  rect(xStart, yStart, xEnd, yEnd);
  drawDataPoints();
  addXaxisLabels();
  drawCitySelectionBoxes();
  
  //title
  textSize(26);
  text("Hourly weather data for United States", xStart + 200 , yStart - 40);
  
  textSize(10);
  if(selectedYear != 0){
    hs.drawScrollBar();
  }
  
  addYAxisLabels();
  addZoomInHighlight();
  
  
}

void drawDataPoints(){
  for(String key : data.keySet()){
    City city = data.get(key);
    if(selectedCity.equals(city.getName())){
      float xVal = 0;
      if (selectedYear != 0){
        String endDate = selectedYear + "-12-31 23:00:00";
        String startDate = selectedYear + "-01-01 00:00:00";
        float denom = (cityData.convertStringToDate(endDate).getTime() 
                      - cityData.convertStringToDate(startDate).getTime())/xWidth;
        if(city.getRecordDate().getYear()+1900 == selectedYear){
          xVal = (city.getRecordDate().getTime() - 
                cityData.convertStringToDate(startDate).getTime()) /denom + xStart;
        }
      }
      else{
        xVal = (city.getRecordDate().getTime() - cityData.getMinDate().getTime()) 
                    /numValXaxis + xStart;
      }
      
      if(xVal > 0){
        float yValHum = yEnd - (city.getHumidity() * pixelSpacingYHum);
        float yValTemp = yEnd - (city.getTemperature() * pixelSpacingYTemp);
        //float yValPres = yEnd - (city.getPressure() * pixelSpacingYPress);
        fill(#0080ff);
        ellipse(xVal, yValHum, 1, 2);
        
        fill(#ffff00);
        ellipse(xVal, yValTemp, 1, 2);
        
        //fill(#00ff40);
        //ellipse(xVal, yValPres, 1, 2);
      }
    }
    
  }
}

void drawCitySelectionBoxes(){
  textAlign(LEFT);
  cityCheckbox.setContainer(xEnd + 30, yStart, xEnd + 10 + 125, yStart + 420);
  cityCheckbox.setValues(cityList);
  cityCheckbox.setName("Select City");
  cityCheckbox.setSelected(selectedCity);
  cityCheckbox.drawSelectBox();
}

void addXaxisLabels(){
  fill(0);
  textAlign(CENTER);
  if (selectedYear == 0){
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
        yearToPixelMapping.put((int)year, (int)xVal);
        text(year, xVal, yEnd+15);
        stroke(126);
        line(xVal, yStart, xVal, yEnd);
    }
  } else {
    List<String> months = new ArrayList<String>();
    Collections.addAll(months, "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
    float monthlyWidth = (xEnd - xStart)/12;
    float xVal = xStart;
    for(String month: months){
        text(month, xVal, yEnd+15);
        stroke(126);
        line(xVal, yStart, xVal, yEnd);
        xVal = xVal + monthlyWidth;
    }
  }
  stroke(126);
}

void addYAxisLabels(){
  fill(0);
  for(float i = yEnd, humVal = cityData.getHumMin(), tempVal = cityData.getTempMin(); 
            i >= yStart; 
            i = i - ((yEnd - yStart)/10), 
            humVal = humVal + ((cityData.getHumMax()- cityData.getHumMin())/10),
            tempVal = tempVal + ((cityData.getTempMax()- cityData.getTempMin())/10)){
              textAlign(RIGHT);
              text((int)humVal, xStart - 2, i+3);
              stroke(126);
              line(xStart, i, xEnd, i);
              textAlign(LEFT);
              text((int)tempVal, xEnd + 2, i+3);
  }
  textAlign(CENTER);
  text("Humidity", xStart, yStart-10);
  text("Temperature", xEnd, yStart-10);
  
}

void mousePressed(){
    //city selection
    if (mouseX > cityCheckbox.getxStart()+5 &&  mouseX < cityCheckbox.getxStart()+15
        && mouseY > cityCheckbox.getyStart()+15 ){
          int probableSelection = (int)(mouseY - (cityCheckbox.getyStart()+15)) / 15;
          int inCheckBox = (int)(mouseY - (cityCheckbox.getyStart()+15)) % 15;
          if (inCheckBox <= 10 && probableSelection < cityList.size()){
            selectedCity = cityList.get(probableSelection);
          }
    }
    
    //year selection
    if(mouseX >= xStart && mouseX <= xEnd && mouseY >= yStart && mouseY <= yEnd){
      if(selectedYear != 0){
        selectedYear = 0;
      } else {
        selectedYear = 1;
        int yearMax = 2012;
        for(Object key : yearToPixelMapping.keySet().toArray()){
          int year = (int)key;
          int limitVal = yearToPixelMapping.get(year);
          if(mouseX > limitVal && yearMax < year){
              yearMax = year;
          }
        }
        selectedYear = yearMax;
      }
    }
  }
  
  void addZoomInHighlight(){
    if(mouseX >= xStart && mouseX <= xEnd && mouseY >= yStart && mouseY <= yEnd){
        if(selectedYear == 0){
        int yearMax = 2012;
          for(Object key : yearToPixelMapping.keySet().toArray()){
            int year = (int)key;
            int limitVal = yearToPixelMapping.get(year);
            if(mouseX > limitVal && yearMax < year){
                yearMax = year;
            }
          }
        int highlightStart = yearToPixelMapping.get(yearMax);
        int highlightEnd = (yearMax<2017)?yearToPixelMapping.get(yearMax +1): (int)xEnd;
        fill(#FBEEE6, 125);
        rect(highlightStart, yStart, highlightEnd, yEnd);
        fill(0);
        text("Click to zoom for "+ yearMax, mouseX, mouseY+20);
       } else {
        fill(0);
        text("Click to zoom out", mouseX, mouseY+20);
      }
    }
  }
