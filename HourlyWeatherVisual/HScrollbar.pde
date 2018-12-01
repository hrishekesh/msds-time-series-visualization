class HScrollbar {
  
  private float xStart;
  private float xEnd;
  private float yStart;
  private float yEnd;
  private float barWidth;
  private float barStart;
  private float barEnd;
  private float scrollPercent;
  
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
  
  public float getBarStart() {
    return barStart;
  }
  public void setBarStart(float barStart) {
    this.barStart = barStart;
  }
  public float getBarEnd() {
    return barEnd;
  }
  public void setBarEnd(float barEnd) {
    this.barEnd = barEnd;
  }
  public float getScrollPercent() {
    return scrollPercent;
  }
  public void setcrollPercent(float scrollPercent) {
    this.scrollPercent = scrollPercent;
  }
  
  HScrollbar(float xStart, float yStart, float xEnd){
    this.xStart = xStart;
    this.yStart = yStart;
    this.xEnd = xEnd;
    this.yEnd = yStart+15;
    this.barStart = xStart;
    this.barWidth = (xEnd - xStart)/4;
    this.barEnd = this.barStart + this.barWidth;
  }
  
  void drawScrollBar(){
    fill(255);
    rect(this.xStart, this.yStart, this.xEnd, this.yEnd);
    fill(150);
    rect(this.barStart, this.yStart, this.barEnd, this.yEnd);
  }
  
  void scroll(float x){
    this.barStart = (x<(this.xEnd-this.barWidth))?x:(this.xEnd-this.barWidth);
    this.barEnd = this.barWidth + this.barStart;
    fill(150);
    rect(this.barStart, this.yStart, this.barEnd, this.yEnd);
    this.scrollPercent = 1 - (650 - this.barStart)/600;
  }
}
