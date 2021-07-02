  int fileN = 0;
  int saveEvery = 3;   // записывать только каждый saveEvery кадр
  boolean rec = false; // если нужно сохранять скриншоты, то =true , иначе =false

//--- как много должно быть похожих людей в окружении ---
//--- похожие разделить на всех  
// если полученное значение больше, то человек счастлив ---
  float rateOfHappy=0.26;
//------ сколько слоев соведей рассматривать 1 или 2 ------
  int deep = 1;
//--------  способ размещения людей ---------------------------------------------
//--------  либо используя процент ( typeOfSetting = 1 )  -----------------------
//-------- либо в шахматном порядке заполняем всё поле ( typeOfSetting = -1 ) ---
//-------- а затем убираем некоторых (empty) ------------------------------------
  int typeOfSetting = 1;

//---  процент оранжевых и синих и количество пустых клеток ----------------
  int orange=48; int blue=48; // это нужно при typeOfSetting = 1; проценты примерно
  int empty = 2;             // это нужно при typeOfSetting = -1;

//---   статистика   ----------------------------
  int likeCount=0;
  int unlikeCount=0;
  int peopleCount=0;
  int bPeopleCount=0;
  int oPeopleCount=0;
  int emptyCount;

//----- размер мира ------------------------------
  int cntx = 80;  int cnty = 50;
//---------------------------------------------
  int count = cntx*cnty;
//--- клетки 0-пустая, 1-оранжевый, 2-синий ------
  int[][] people  = new int[cntx][cnty];
//--- счастье 0-счастлив, 1-несчастен   ----------
  int[][] happyness  = new int[cntx][cnty];

//-----   несчастные  ----------------------------
  int LengthOfUnHappyList = 0;
  int[] UnHappyList  = new int[count];
  int UnHappyForMove;
//-----   пустые места  ----------------------------
  int LengthOfEmptyList = 0;
  int[] EmptyList  = new int[count];
  int EmptyForMove;
  
  
  int w,b;
  int state = 1;

  GrafDin    unhappyGraph;
  GraphHappy unhappyProcent; 

//=============================================================
void setup()
{
  orientation(LANDSCAPE);
  size(1920,1080); 

  
  unhappyProcent = new GraphHappy(width-500,450,400,200);
  
  unhappyGraph = new GrafDin(width-500,780,400,200);
  unhappyGraph.setColor(#aaaaaa,#FF0000);
 
  neighborhood();
  neighbor8();

  background(#e3e3e3); smooth();
  if(typeOfSetting==1){ setPeople( orange, blue ); }
  else{ setPeople2(empty); }
}


//============================================================
void draw()
{ 
  background(#e3e3e3);
  GetStatistic(deep);
  drawPeople();
  if(LengthOfUnHappyList>0) swapPeople(UnHappyForMove, EmptyForMove);
  float range = drawStatistic();
  
  unhappyGraph.add(LengthOfUnHappyList);  
  unhappyProcent.add(range);
  neighborhood();
  neighbor8();
  
  unhappyGraph.render();
  unhappyProcent.render(); 
  if(rec){
    if( (frameCount == 1)||(frameCount % saveEvery == 0) ){ 
      saveFrame("files/"+fileN+".png"); fileN++;  
    }
  }
  if(LengthOfUnHappyList==0){
    if(rec) saveFrame("files/"+fileN+".png");  
    noLoop();
  }
}

void mousePressed()
{ //rect(1260,110,60,20);
  if((mouseY>110 &&  mouseY<130 )){
    if(mouseX>1260 &&  mouseX<1290 ) {rateOfHappy=rateOfHappy-0.01;}
    if(mouseX>1290 &&  mouseX<1320 )  {rateOfHappy=rateOfHappy+0.01;}
  }
  loop();

}
