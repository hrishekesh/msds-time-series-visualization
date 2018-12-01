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
//int key00x = xEnd + 30, key02y = yStart + 430, key00w = xEnd + 135, key02h = yStart + 420;
float key00x, key00w, key01y, key01h, key02y, key02h, key03y, key03h; 
boolean button = true;
color c1, c2;
String selectedTitle = "Hourly Weather Data for the United States";
String y1axisTitle = "Humidity";
String y2axisTitle = "Temperature";
//String y3axisTitle = "Pressure";
//String y4axisTitle = "Wind Speed";
List<String> months = new ArrayList<String>();
float scrollPercent = 0;

void setup(){
  size(2000, 600);
  c1 = color(#0080ff); // blue
  c2 = color(#FF0000); // red
  text("Loading. Please wait . . . ", 500, 500);
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
  
  // Set default x-position and width of plot keys
  key00x = xEnd + 30;
  key00w = xEnd + 135;
  
  // Set unique y-positions and heights of plot keys
  key01y = yStart;
  key01h = yStart + 420;
  
  key02y = key01h + 10;
  key02h = key02y + 50;
  
  key03y = key02h + 10;
  key03h = key03y + 20;
  
  smooth();
  
  data = cityData.getTimeSeriesData();

  cityList = new ArrayList<String>(cityData.getCityList());
  cityCheckbox= new CheckBox();
  
  hs = new HScrollbar(xStart, yEnd +20, xEnd);
  Collections.addAll(months, "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
}

void draw(){
  background(255);
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(xStart, yStart, xEnd, yEnd);
  stroke(0);
  line(xStart, yStart, xStart, yEnd);
  line(xStart, yEnd, xEnd, yEnd);
  line(xEnd, yStart, xEnd, yEnd);
  noStroke();
  drawDataPoints();
  addXaxisLabels();
  drawCitySelectionBoxes();
  drawLegend();
  drawGridlineToggle();
  
  //title
  textSize(26);
  text(selectedTitle, xStart + 200 , yStart - 40);
  
  textSize(10);
  if(selectedYear != 0){
    hs.drawScrollBar();
  }
  
  addYAxisLabels();
  addZoomInHighlight();
}

void drawDataPoints(){
  float xVal = 0;
  for(String key : data.keySet()){
    City city = data.get(key);
    if(selectedCity.equals(city.getName())){
      xVal = 0;
      if (selectedYear != 0){
        String endDate = selectedYear + "-12-31 23:00:00";
         String startDate = selectedYear + "-01-01 00:00:00";
         float denom = (cityData.convertStringToDate(endDate).getTime() 
                      - cityData.convertStringToDate(startDate).getTime())/(xWidth*2);
        if(city.getRecordDate().getYear()+1900 == selectedYear){
          xVal = (city.getRecordDate().getTime() - 
                cityData.convertStringToDate(startDate).getTime())/denom + xStart 
                - (xWidth)*hs.scrollPercent;
        }
      }
      else{
        xVal = (city.getRecordDate().getTime() - cityData.getMinDate().getTime()) 
                    /numValXaxis + xStart;        
      }
      
      if(xVal >= 50 && xVal <= xEnd){
        float yValHum = yEnd - (city.getHumidity() * pixelSpacingYHum);
        float yValTemp = yEnd - (city.getTemperature() * pixelSpacingYTemp);
        //float yValPres = yEnd - (city.getPressure() * pixelSpacingYPress);
        fill(c1);
        ellipse(xVal, yValHum, 2, 2);
        
        fill(c2);
        ellipse(xVal, yValTemp, 2, 2);
        
        //fill(#00ff40);
        //ellipse(xVal, yValPres, 1, 2);
      }
    }
    
  }
}

void drawCitySelectionBoxes(){
  textAlign(LEFT);
  //cityCheckbox.setContainer(xEnd + 30, yStart, xEnd + 10 + 125, yStart + 420);
  cityCheckbox.setContainer(key00x, key01y, key00w, key01h);
  cityCheckbox.setValues(cityList);
  cityCheckbox.setName("Select a city");
  cityCheckbox.setSelected(selectedCity);
  cityCheckbox.drawSelectBox();
}

void drawLegend(){
  fill(255);
  rect(key00x, key02y, key00w, key02h);
  fill(0);
  text("Legend",key00x + 5, key02y + 10);
  
  fill(0);
  text(y1axisTitle,key00x + 15, key02y + 25);
  fill(c1);
  ellipse(key00x + 10, key02y + 20, 4, 4);
  
  fill(0);
  text(y2axisTitle,key00x + 15, key02y + 45);
  fill(c2);
  ellipse(key00x + 10, key02y + 40, 4, 4);
}

void drawGridlineToggle(){
  fill(0,255,0);
  rect(key00x, key03y, key00w, key03h, 7);
  fill(0);
  text("Gridlines: ",key00x + 5, key03y + 15);
  if(button){
    //fill(0,255,0);
    text("On",key00x + 65, key03y + 15);
  } else {
    //fill(200);
    text("Off",key00x + 65, key03y + 15);
  }
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
        if (button){
          line(xVal, yStart, xVal, yEnd);
        }
    }
  } else {
    float monthlyWidth = xWidth*2/12;
    float xVal = xStart - (xWidth)*hs.scrollPercent;
    for(String month: months){
        if(button && xVal <= xEnd && xVal >= 50){
          text(month, xVal, yEnd+15);
          stroke(126);
          line(xVal, yStart, xVal, yEnd);
        }
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
              if (button){
                line(xStart, i, xEnd, i);
              }
              textAlign(LEFT);
              text((int)tempVal, xEnd + 2, i+3);
  }
  textAlign(CENTER);
  text(y1axisTitle, xStart, yStart-10);
  text(y2axisTitle, xEnd, yStart-10);
  
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
    
    //axis label toggle
    if (mouseX >= key00x && mouseX <= key00x+key00w && mouseY >= key03y && mouseY <= key03y+key03h) {
      fill(0);
      //textSize(8);
      textAlign(CENTER);
      text("Click to toggle gridlines on/off",(key00x + key00w)/2, key03y + 30);
      button = !button;
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
  
  void mouseDragged(){
    //scrolling
    if(mouseX >= hs.xStart && mouseX <= hs.xEnd && mouseY >= hs.yStart 
        && mouseY <= hs.yEnd && selectedYear > 0){
       hs.scroll(mouseX);
     }
  }
