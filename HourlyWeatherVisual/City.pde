import java.util.Date;
import java.util.HashMap;
import java.util.Map;

class City{
  private String name;
  private String country;
  private float latitude;
  private float longitude;

    private float humidity;
    private float pressure;
    private float temperature;
    private float windDirection;
    private float windSpeed;
    private float weatherDescription;
    
    float getHumidity() {
      return humidity;
    }
    void setHumidity(float humidity) {
      this.humidity = humidity;
    }
    float getPressure() {
      return pressure;
    }
    void setPressure(float pressure) {
      this.pressure = pressure;
    }
    float getTemperature() {
      return temperature;
    }
    void setTemperature(float temperature) {
      this.temperature = temperature;
    }
    float getWindDirection() {
      return windDirection;
    }
    void setWindDirection(float windDirection) {
      this.windDirection = windDirection;
    }
    float getWindSpeed() {
      return windSpeed;
    }
    void setWindSpeed(float windSpeed) {
      this.windSpeed = windSpeed;
    }
    float getWeatherDescription() {
      return weatherDescription;
    }
    void setWeatherDescription(float weatherDescription) {
      this.weatherDescription = weatherDescription;
    }
  
  String getName() {
    return name;
  }
  void setName(String name) {
    this.name = name;
  }
  String getCountry() {
    return country;
  }
  void setCountry(String country) {
    this.country = country;
  }
  float getLatitude() {
    return latitude;
  }
  void setLatitude(float latitude) {
    this.latitude = latitude;
  }
  float getLongitude() {
    return longitude;
  }
  void setLongitude(float longitude) {
    this.longitude = longitude;
  }
  
}
