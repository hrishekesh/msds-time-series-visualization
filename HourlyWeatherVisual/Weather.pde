import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

class Weather{
  private Map<String, City> timeSeriesData = new HashMap<String, City>();
  
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
      }
                                                         
    }
  }
}
