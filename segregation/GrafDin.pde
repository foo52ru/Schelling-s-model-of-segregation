class GrafDin{
  int X, Y, W, H;
  int maxY, curY;
  IntList Y2X;
  color lnColor, grColor;
  
  GrafDin(int x, int y, int w, int h){
    X=x; Y=y; W=w; H=h;
    maxY=H; curY=0;
    Y2X = new IntList();
    lnColor = #aaaaaa;
    grColor = 0;
  }

  void setColor(color l, color g){
    lnColor = l;
    grColor = g;
  }


  void add(int n){
    curY=n;
    Y2X.append(n);
    if(n>maxY){maxY=n;}
  }
  
  void render(){
    fill(255);  rectMode(CORNER); noStroke();    
    rect(X,Y-H,W,H);
    stroke(lnColor); strokeWeight(3);
    line(X,Y,X,Y-H); line(X,Y,X+W,Y);
    fill(0); textSize(14); textAlign(RIGHT,TOP);
    text(Y2X.size(),X+W,Y+3);
    text(maxY,X-3,Y-H);
    
    

    float cx = float(W)/float(Y2X.size());
    if(cx>=1.0){cx=1.0;}
    float cy = float(H)/float(maxY);
    if(cy>=1.0){cy=1.0;}  
    text(curY,X+W+35,Y-curY*cy);
    
    stroke(grColor);    
    for(int x=0; x<Y2X.size(); x++){
      point(X+x*cx,Y-Y2X.get(x)*cy);
    }
  }
}
