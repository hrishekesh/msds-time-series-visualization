class CheckBox{
  private String name;
  private String type;
  private float xStart;
  private float xEnd;
  private float yStart;
  private float yEnd;
  private String selected;
  private boolean multiSelect;
  private List<String> values = new ArrayList<String>();
  
  
  public List<String> getValues() {
    return values;
  }
  public void setValues(List<String> values) {
    this.values = values;
  }
  public String getSelected() {
    return selected;
  }
  public void setSelected(String selected) {
    this.selected = selected;
  }
  public boolean isMultiSelect() {
    return multiSelect;
  }
  public void setMultiSelect(boolean multiSelect) {
    this.multiSelect = multiSelect;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getType() {
    return type;
  }
  public void setType(String type) {
    this.type = type;
  }
  public float getxStart() {
    return xStart;
  }
  public void setxStart(float xStart) {
    this.xStart = xStart;
  }
  public float getxEnd() {
    return xEnd;
  }
  public void setxEnd(float xEnd) {
    this.xEnd = xEnd;
  }
  public float getyStart() {
    return yStart;
  }
  public void setyStart(float yStart) {
    this.yStart = yStart;
  }
  public float getyEnd() {
    return yEnd;
  }
  public void setyEnd(float yEnd) {
    this.yEnd = yEnd;
  }
  
  void setContainer(float xStart, float yStart, float xEnd, float yEnd){
    this.xStart = xStart;
    this.yStart = yStart;
    this.xEnd = xEnd;
    this.yEnd = yEnd;
  }
  
  void drawSelectBox() {
    fill(255);
    noStroke();
    rect(this.getxStart(), this.getyStart(), this.getxEnd(), this.getyEnd());
    fill(0);
    float boxXStart = xStart + 5;
    float boxYStart = yStart;
    text(this.name, boxXStart, boxYStart + 10);
    fill(255);
    for (String city: this.getValues()){
      boxYStart = boxYStart +15;
      if (city.equals(this.getSelected())){
        fill(0);
      }
      else{
        fill(255);
      }
      stroke(126);
      rect(boxXStart, boxYStart, boxXStart+10, boxYStart+10);
      fill(0);
      text(city, boxXStart + 14, boxYStart +10);
    }
  }
  
}
