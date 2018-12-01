import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;
import java.util.HashSet;

class Weather{
  // map to maintain all attributes against time
  private Map<String, City> timeSeriesData = new HashMap<String, City>();
  
  private float tempMax = 0.0;
  private float tempMin = 0.0;
  private float humMax = 0.0;
  private float humMin = 0.0;
  private float pressMax = 0.0;
  private float pressMin = 0.0;
  private float speedMax = 0.0;
  private float speedMin = 0.0;
  private Date minDate;
  private Date maxDate;
  //start date
  private String defaultDate = "2012-10-01 12:00:00";
  // unique cities in data
  Set<String> cityList = new HashSet<String>();
  // unique years in data
  Set<Integer> yearList = new HashSet<Integer>();

  public Set<String> getCityList() {
    return cityList;
  }
  public void setCityList(Set<String> cityList) {
    this.cityList = cityList;
  }
  
  public Set<Integer> getYearList() {
    return yearList;
  }
  public void setYearList(Set<Integer> yearList) {
    this.yearList = yearList;
  }
  
  public Date getMinDate() {
    return minDate;
  }
  public void setMinDate(Date minDate) {
    this.minDate = minDate;
  }
  public Date getMaxDate() {
    return maxDate;
  }
  public void setMaxDate(Date maxDate) {
    this.maxDate = maxDate;
  }
  
  
  float getTempMax() {
    return tempMax;
  }
  void setTempMax(float tempMax) {
    this.tempMax = tempMax;
  }
  float getTempMin() {
    return tempMin;
  }
  void setTempMin(float tempMin) {
    this.tempMin = tempMin;
  }
  float getHumMax() {
    return humMax;
  }
  void setHumMax(float humMax) {
    this.humMax = humMax;
  }
  float getHumMin() {
    return humMin;
  }
  void setHumMin(float humMin) {
    this.humMin = humMin;
  }
  float getPressMax() {
    return pressMax;
  }
  void setPressMax(float pressMax) {
    this.pressMax = pressMax;
  }
  float getPressMin() {
    return pressMin;
  }
  void setPressMin(float pressMin) {
    this.pressMin = pressMin;
  }
  float getSpeedMax() {
    return speedMax;
  }
  void setSpeedMax(float speedMax) {
    this.speedMax = speedMax;
  }
  float getSpeedMin() {
    return speedMin;
  }
  void setSpeedMin(float speedMin) {
    this.speedMin = speedMin;
  }
  
  Map<String, City> getTimeSeriesData() {
    return timeSeriesData;
  }
  void setTimeSeriesData(Map<String, City> timeSeriesData) {
    this.timeSeriesData = timeSeriesData;
  }
  
  Date convertStringToDate(String recordDate) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date convertedRecordDate = new Date(); 
    try {
      convertedRecordDate= sdf.parse(recordDate);
    } catch (ParseException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return convertedRecordDate;
  }
  
  
  Weather(){
    setMinDate(convertStringToDate(defaultDate));
    setMaxDate(convertStringToDate(defaultDate));
    String[] cityAttributes = loadStrings("city_attributes.csv");
    String[] humidity = loadStrings("humidity.csv");
    String[] pressure = loadStrings("pressure.csv");
    String[] temperature = loadStrings("temperature.csv");
    String[] windSpeed = loadStrings("wind_speed.csv");
    
    //All sheets have same number of rows and columns in the dataset
    int numRows = humidity.length;
    SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
    for (int i=1; i<numRows; i++){
      List<String> humidityRow = Arrays.asList(humidity[i].split(","));
      List<String> pressureRow = Arrays.asList(pressure[i].split(","));
      List<String> temperatureRow = Arrays.asList(temperature[i].split(","));
      List<String> windSpeedRow = Arrays.asList(windSpeed[i].split(","));
      
      for (int j=1; j < cityAttributes.length; j++){
        List<String> row = Arrays.asList(cityAttributes[j].split(","));
        // filter data only for US
        if(row.get(1).equals("United States")){
          City city = new City();
        city.setName(row.get(0));
        city.setCountry(row.get(1));
        city.setLatitude(Float.parseFloat(row.get(2)));
        city.setLongitude(Float.parseFloat(row.get(3)));
        city.setHumidity((j<humidityRow.size() && humidityRow.get(j) != null && !humidityRow.get(j).isEmpty())
                                                      ?Float.parseFloat(humidityRow.get(j)):0);
        city.setPressure((j<pressureRow.size() && pressureRow.get(j) != null && !pressureRow.get(j).isEmpty())
                                                      ?Float.parseFloat(pressureRow.get(j)):0);
        city.setTemperature((j<temperatureRow.size() && temperatureRow.get(j) != null && !temperatureRow.get(j).isEmpty())
                                                      ?Float.parseFloat(temperatureRow.get(j)):0);
        city.setWindSpeed((j<windSpeedRow.size() && windSpeedRow.get(j) != null && !windSpeedRow.get(j).isEmpty())
                                                      ?Float.parseFloat(windSpeedRow.get(j)):0);
        Date recDate = convertStringToDate(humidityRow.get(0));
        city.setRecordDate(recDate);
        // ensure we have a unique key for all record sets.
        String mapKey = city.getRecordDate() + " | " + city.getName();
        
        cityList.add(city.getName());
        yearList.add(Integer.parseInt(yearFormat.format(recDate)));
        
        timeSeriesData.put(mapKey, city);
        
        //determine maximum and minimum values  for each field
        if(recDate.before(getMinDate())) {
          setMinDate(recDate);
        }
        if(recDate.after(getMaxDate())) {
          setMaxDate(recDate);
        }
        humMax = (city.getHumidity() > humMax)?city.getHumidity():humMax;
        pressMax = (city.getPressure() > pressMax)?city.getPressure():pressMax;
        tempMax = (city.getTemperature() > tempMax)?city.getTemperature():tempMax;
        speedMax = (city.getWindSpeed() > speedMax)?city.getWindSpeed():speedMax;
        
        
        humMin = (city.getHumidity() < humMin)?city.getHumidity():humMin;
        pressMin = (city.getPressure() < pressMin)?city.getPressure():pressMin;
        tempMin = (city.getTemperature() < tempMin)?city.getTemperature():tempMin;
        speedMin = (city.getWindSpeed() < speedMin)?city.getWindSpeed():speedMin;
        }
      }
                                                         
    }
  }
}
