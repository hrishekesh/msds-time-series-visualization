import java.util.Date;
import java.util.HashMap;
import java.util.Map;

class City{
  private String name;
  private String country;
  private float latitude;
  private float longitude;
    private Date recordDate;
    private float humidity;
    private float pressure;
    private float temperature;
    private float windSpeed;
    
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
    float getWindSpeed() {
      return windSpeed;
    }
    void setWindSpeed(float windSpeed) {
      this.windSpeed = windSpeed;
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
  Date getRecordDate() {
    return recordDate;
  }
  void setRecordDate(Date recordDate) {
    this.recordDate = recordDate;
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
