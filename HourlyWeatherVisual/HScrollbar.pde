class HScrollbar {
  
  private float xStart;
  private float xEnd;
  private float yStart;
  private float yEnd;
  private float barWidth;
  
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
  public float getBarWidth() {
    return barWidth;
  }
  public void setBarWidth(float barWidth) {
    this.barWidth = barWidth;
  }
  
  HScrollbar(float xStart, float yStart, float xEnd){
    this.xStart = xStart;
    this.yStart = yStart;
    this.xEnd = xEnd;
  }
  
  void drawScrollBar(){
    fill(255);
    rect(this.xStart, this.yStart, this.xEnd, this.yStart+15);
  }
  
}
