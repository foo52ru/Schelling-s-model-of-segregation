class GraphHappy{
  int X, Y, W, H;
  float Happy;
  
  FloatList Y2X;
  color lnColor, grColor, hColor;
  
  GraphHappy(int x, int y, int w, int h){
    X=x; Y=y; W=w; H=h; Happy = rateOfHappy;
    Y2X = new FloatList();
    lnColor = #aaaaaa;
    grColor = #0822FF;
    hColor = #EAA7FF;
  }

  void add(float n){
    Y2X.append(n);
  }
  
  
  void render(){
    Happy = rateOfHappy;
    rectMode(CORNER); noStroke(); 
    fill(255);  rect(X,Y-H,W,H);
    
    fill(#FFC4F5);  rect(X,Y-H*Happy,W,H*Happy);
    
    stroke(lnColor); strokeWeight(3);
    line(X,Y,X,Y-H); line(X,Y,X+W,Y);
    
    fill(0); textSize(14); textAlign(RIGHT,TOP);
    text(Y2X.size(),X+W,Y+3);
    textAlign(RIGHT,CENTER);
    text(Y2X.get(Y2X.size()-1),X+W+45,Y-Y2X.get(Y2X.size()-1)*H);
    
    stroke(grColor);
    float cx = float(W)/float(Y2X.size());
    if(cx>=1.0){cx=1.0;}
   
    for(int x=0; x<Y2X.size(); x++){
      point(X+x*cx,Y-Y2X.get(x)*H);
    }
  }
}
