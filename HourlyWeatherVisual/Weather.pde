import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

class Weather{
  private Map<String, City> timeSeriesData = new HashMap<String, City>();
  
  private float tempMax = 0.0;
  private float tempMin = 0.0;
  private float humMax = 0.0;
  private float humMin = 0.0;
  private float pressMax = 0.0;
  private float pressMin = 0.0;
  private float directionMax = 0.0;
  private float directionMin = 0.0;
  private float speedMax = 0.0;
  private float speedMin = 0.0;
  
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
  float getDirectionMax() {
    return directionMax;
  }
  void setDirectionMax(float directionMax) {
    this.directionMax = directionMax;
  }
  float getDirectionMin() {
    return directionMin;
  }
  void setDirectionMin(float directionMin) {
    this.directionMin = directionMin;
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
  
  Weather(){
    String[] cityAttributes = loadStrings("city_attributes.csv");
    String[] humidity = loadStrings("humidity.csv");
    String[] pressure = loadStrings("pressure.csv");
    String[] temperature = loadStrings("temperature.csv");
    String[] weatherDesc = loadStrings("weather_description.csv");
    String[] windDirection = loadStrings("wind_direction.csv");
    String[] windSpeed = loadStrings("wind_speed.csv");
    
    //All sheets have same number of rows and columns in the dataset
    int numRows = humidity.length;
    for (int i=1; i<numRows; i++){
      List<String> humidityRow = Arrays.asList(humidity[i].split(","));
      List<String> pressureRow = Arrays.asList(pressure[i].split(","));
      List<String> temperatureRow = Arrays.asList(temperature[i].split(","));
      List<String> windDirectionRow = Arrays.asList(windDirection[i].split(","));
      List<String> windSpeedRow = Arrays.asList(windSpeed[i].split(","));
      
      for (int j=1; j < cityAttributes.length; j++){
        List<String> row = Arrays.asList(cityAttributes[j].split(","));
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
        city.setWindDirection((j<windDirectionRow.size() && windDirectionRow.get(j) != null && !windDirectionRow.get(j).isEmpty())
                                                      ?Float.parseFloat(windDirectionRow.get(j)):0);
        city.setWindSpeed((j<windSpeedRow.size() && windSpeedRow.get(j) != null && !windSpeedRow.get(j).isEmpty())
                                                      ?Float.parseFloat(windSpeedRow.get(j)):0);
        String mapKey = humidityRow.get(0) + " | " + city.getName();
        timeSeriesData.put(mapKey, city);
        
        //determine maximum and minimum values  for each field
        humMax = (city.getHumidity() > humMax)?city.getHumidity():humMax;
        pressMax = (city.getPressure() > pressMax)?city.getPressure():pressMax;
        tempMax = (city.getTemperature() > tempMax)?city.getTemperature():tempMax;
        directionMax = (city.getWindDirection() > directionMax)?city.getWindDirection():directionMax;
        speedMax = (city.getWindSpeed() > speedMax)?city.getWindSpeed():speedMax;
        
        humMin = (city.getHumidity() < humMin)?city.getHumidity():humMin;
        pressMin = (city.getPressure() < pressMin)?city.getPressure():pressMin;
        tempMin = (city.getTemperature() < tempMin)?city.getTemperature():tempMin;
        directionMin = (city.getWindDirection() < directionMin)?city.getWindDirection():directionMin;
        speedMin = (city.getWindSpeed() < speedMin)?city.getWindSpeed():speedMin;
      }
                                                         
    }
  }
}
