class WeatherTab{
  public WeatherTab(String name, float xStart, float yStart, float xEnd, float yEnd, int tabNum) {
    this.name = name;
    this.xStart = xStart;
    this.yStart = yStart;
    this.xEnd = xEnd;
    this.yEnd = yEnd;
    this.tabNum = tabNum;
  }
  private String name;
  private float xStart;
  private float yStart;
  private float xEnd;
  private float yEnd;
  private int tabNum;
  
  public int getTabNum() {
    return tabNum;
  }
  public void setTabNum(int tabNum) {
    this.tabNum = tabNum;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public float getxStart() {
    return xStart;
  }
  public void setxStart(float xStart) {
    this.xStart = xStart;
  }
  public float getyStart() {
    return yStart;
  }
  public void setyStart(float yStart) {
    this.yStart = yStart;
  }
  public float getxEnd() {
    return xEnd;
  }
  public void setxEnd(float xEnd) {
    this.xEnd = xEnd;
  }
  public float getyEnd() {
    return yEnd;
  }
  public void setyEnd(float yEnd) {
    this.yEnd = yEnd;
  }
  
  void fillTab(){
    if(this.getName().equals(selectedTab)){
      fill(#f24f7c);
    }
    else {
      fill(#3bc0c3);
    }
    if(mouseX >= this.getxStart() && mouseX <= this.getxEnd() 
      && mouseY >= this.getyStart() && mouseY <= this.getyEnd() ){
        fill(#716cb0);
      }
    rect(this.getxStart(), this.getyStart(), this.getxEnd(), this.getyEnd());
    fill(255);
    text(this.getName(), this.getxStart()+tabWidth/2, this.getyStart()+15);
  }
  
}
