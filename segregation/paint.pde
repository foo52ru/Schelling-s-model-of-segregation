void drawPeople()
{
  int size=14;
  int distance=16;
  int startx=90;
  int starty=150;
  
  for(int i=0; i<cntx; i++)
  {
    for(int j=0; j<cnty; j++)
    {
      if(people[i][j]==0){
        fill(#e3e3e3);
      } else{ 
          if(people[i][j]==1){
            fill(#FF9F21); stroke(#D37B06);
          } else{
              fill(#574FA2); stroke(#574FA2);
            }
          }
      if(happyness[i][j]==0){
        noStroke();
        rect(startx+i*distance,starty+j*distance,size,size);
      }else{
        strokeWeight(4);
        line(startx+i*distance+2,starty+j*distance+2,startx+i*distance+size-4,starty+j*distance+size-4);
        line(startx+i*distance+size-4,starty+j*distance+2,startx+i*distance+2,starty+j*distance+size-4);
      }
    }
  }
}

float drawStatistic()
{
    float nearLike = (float)likeCount/peopleCount;  
    float nearUnLike = (float)unlikeCount/peopleCount;
    float range= nearLike/(nearLike+nearUnLike);   
    
    fill(100); textSize(16); textAlign(RIGHT); 
    text("количество людей:", 500,50);
    text("количество несчастных:", 500,75);
    text("Оранжевых: "+oPeopleCount, 400,125);
    text("Синих: "+bPeopleCount, 520,125);
    text("Пустых: "+emptyCount, 640,125);
    
    fill(0);
    text((float)100*LengthOfUnHappyList/peopleCount, 700,75);
    fill(100); text("%", 715,75);
    
    text("количество своих по-соседству:", 1160,50);
    text("количество чужих по-соседству:", 1160,75);
    text("соотношение (свои/соседи) в реальности:", 1160,100); 
    text("минимальное соотношение (свои/соседи) для счастья:", 1160,125);
    
    
    fill(0); textSize(20); textAlign(LEFT); 
    text(peopleCount, 520,50);
    text(LengthOfUnHappyList, 520,75);
    text(nearLike, 1180,50);
    text(nearUnLike, 1180,75);
    text(range, 1180,100);    
    text(rateOfHappy, 1180,125); 
    
    noStroke(); fill(255); // кнопка прибавить/убавить уровень терпимости
    rect(1260,110,60,20);
    fill(100); text("-  +", 1270,125); 
    
    fill(100); textSize(16);
    text("количество несчастных:", 1400,830);
    fill(0); textSize(26); 
    text((float)100*LengthOfUnHappyList/peopleCount, 1600,830);
    fill(100); text("%", 1710,830);  
    
    fill(100); textSize(16);
    text("нужно для счастья", 1450,490);      
    text("в реальности", 1640,490); 
    
    fill(0); textSize(26);
    text(rateOfHappy, 1450,520);      
    text(range, 1640,520);
    
    return(range);   
}

void neighborhood(){
  rectMode(CORNER); noStroke();
  fill(250);
  if (deep==1) rect(1480,70,90,90);
  else         rect(1450,40,150,150);
  
  fill(150); rect(1510,100,30,30);

  stroke(200);  strokeWeight(2);
  for( int i = 1; i < 7; i++){
   line(1420,10+i*30,1420+7*30,10+i*30);
   line(1420+i*30,10,1420+i*30,10+7*30);
  }
}

void neighbor8(){
  int like;  
  if(deep == 1){ 
    noStroke();
    for(int k=8; k>1; k--){
      like = calcCountLike(round(rateOfHappy*100), k );
      for( int i = 0; i < k; i++){
        if(i<like) fill(150);
        else       fill(255);
        rect(1640+i*30,10+(8-k)*30,25,25);
      } 
    }
  }else{
    
      fill(80); textSize(20); textAlign(RIGHT);
    for(int k=24; k>17; k--){
      like = calcCountLike(round(rateOfHappy*100), k );
      text(like ,1670,30+(24-k)*30);
      text("|",  1700,30+(24-k)*30);
      text((k-like),1740,30+(24-k)*30);
      println(like);
    }
  }
  
}



int calcCountLike(float proc, float count )
{ 
  proc = proc/100;
  //println(proc + " " + count*proc + " " + ceil(count*proc) );
  return ceil(count*proc); 
}
