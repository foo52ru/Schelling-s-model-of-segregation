void setPeople(int orange, int blue)
{
  peopleCount=0;
  for(int i=0; i<cntx; i++)
  { 
    for(int j=0; j<cnty; j++)
    { 
      float r = random(100);
      if(r < orange){
        people[i][j] = 1; peopleCount++; oPeopleCount++;
      } else {if(r < orange+blue){
          people[i][j] = 2; peopleCount++; bPeopleCount++;
        } else{ people[i][j] = 0; emptyCount++;}
      }
    }
  }
}

void setPeople2(int empty){
  peopleCount=count;
  for(int i=0; i<cntx; i++){ 
    for(int j=0; j<cnty; j++){ 
      people[i][j] = 1+((i+j) % 2); 
      if(people[i][j] == 1){oPeopleCount++;}
      else {bPeopleCount++;}
    }
  }

  while(emptyCount<empty){
    int r=int(random(count));
    int t = people[p2x(r)][p2y(r)];
    if(t==1){
      people[p2x(r)][p2y(r)]=0;
      peopleCount--; oPeopleCount--; emptyCount++;
    }
    if(t==2){
      people[p2x(r)][p2y(r)]=0;
      peopleCount--; bPeopleCount--; emptyCount++;
    }  
    
  }
  
  

}

void setPeople3(int empty){
  for(int i=0; i<50; i++){ 
    for(int j=0; j<cnty; j++){ 
      people[i][j] = 1+((i+j) % 2); 
    }
  }
  int em = int(empty*count/100);
  for(int e=0; e<em; e++){
    int x=int(random(50));
    int y=int(random(cnty));
      people[x][y]=0;
  }
  peopleCount=0;
  for(int i=0; i<cntx; i++){ 
    for(int j=0; j<cnty; j++){ 
      if(people[i][j]>0){ peopleCount++;}
    }
  }
}



void GetStatistic(int type)
{
  likeCount=0; unlikeCount=0;  LengthOfUnHappyList=0;  LengthOfEmptyList=0;
  int x, y;
  
  for( int i=0; i<count; i++)
  {
    x=p2x(i); y=p2y(i);
    if(people[x][y]==0){
      //---   заполняем список пустых локаций  --------
      EmptyList[LengthOfEmptyList] = i;
      LengthOfEmptyList++ ;
      happyness[x][y]=0;
    } else{
      // -- проверяем людей на счастье  ---------------
      if(type==1)      { happyness[x][y]=testHappyness8(x,y);}
      else{if(type==2){ happyness[x][y]=testHappyness24(x,y);} }
      if(happyness[x][y]==1){
        // -- заполняем список несчастных -------------
        UnHappyList[LengthOfUnHappyList] = i;
        LengthOfUnHappyList++ ;
      }
    }
  }
  UnHappyForMove = UnHappyList[floor(random(LengthOfUnHappyList))];
  EmptyForMove   =   EmptyList[floor(random(LengthOfEmptyList))];  
}


int testHappyness8(int x,int y)
{
  int like = 0;
  int unlike = 0;
  int person = people[x][y];
  
  if(people[cdX(x-1)][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y-1)] != 0 ) { unlike++; } }
  if(people[cdX(x  )][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x  )][cdY(y-1)] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y-1)] != 0 ) { unlike++; } }
  
  if(people[cdX(x-1)][cdY(y  )] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y  )] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y  )] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y  )] != 0 ) { unlike++; } }
  
  if(people[cdX(x-1)][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y+1)] != 0 ) { unlike++; } }
  if(people[cdX(x  )][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x  )][cdY(y+1)] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y+1)] != 0 ) { unlike++; } }

  likeCount+=like; unlikeCount+=unlike;

  if(like+unlike == 0) return 1;
  else{
    if(like >= calcCountLike(round(rateOfHappy*100), like+unlike ))
         { return 0; } 
    else { return 1; }
  }
}

int testHappyness24(int x,int y)
{
  int like = 0;
  int unlike = 0;
  int person = people[x][y];

  if(people[cdX(x-2)][cdY(y-2)] == person ) { like++; }
  else{ if(people[cdX(x-2)][cdY(y-2)] != 0 ) { unlike++; } } 
  if(people[cdX(x-1)][cdY(y-2)] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y-2)] != 0 ) { unlike++; } }
  if(people[cdX(x  )][cdY(y-2)] == person ) { like++; }
  else{ if(people[cdX(x  )][cdY(y-2)] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y-2)] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y-2)] != 0 ) { unlike++; } }
  if(people[cdX(x+2)][cdY(y-2)] == person ) { like++; }
  else{ if(people[cdX(x+2)][cdY(y-2)] != 0 ) { unlike++; } }  
  
  if(people[cdX(x-2)][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x-2)][cdY(y-1)] != 0 ) { unlike++; } } 
  if(people[cdX(x-1)][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y-1)] != 0 ) { unlike++; } }
  if(people[cdX(x  )][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x  )][cdY(y-1)] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y-1)] != 0 ) { unlike++; } }
  if(people[cdX(x+2)][cdY(y-1)] == person ) { like++; }
  else{ if(people[cdX(x+2)][cdY(y-1)] != 0 ) { unlike++; } }

  if(people[cdX(x-2)][cdY(y  )] == person ) { like++; }
  else{ if(people[cdX(x-2)][cdY(y  )] != 0 ) { unlike++; } }  
  if(people[cdX(x-1)][cdY(y  )] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y  )] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y  )] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y  )] != 0 ) { unlike++; } }
  if(people[cdX(x+2)][cdY(y  )] == person ) { like++; }
  else{ if(people[cdX(x+2)][cdY(y  )] != 0 ) { unlike++; } }

  if(people[cdX(x-2)][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x-2)][cdY(y+1)] != 0 ) { unlike++; } }  
  if(people[cdX(x-1)][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y+1)] != 0 ) { unlike++; } }
  if(people[cdX(x  )][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x  )][cdY(y+1)] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y+1)] != 0 ) { unlike++; } }
  if(people[cdX(x+2)][cdY(y+1)] == person ) { like++; }
  else{ if(people[cdX(x+2)][cdY(y+1)] != 0 ) { unlike++; } }
  
  if(people[cdX(x-2)][cdY(y+2)] == person ) { like++; }
  else{ if(people[cdX(x-2)][cdY(y+2)] != 0 ) { unlike++; } }  
  if(people[cdX(x-1)][cdY(y+2)] == person ) { like++; }
  else{ if(people[cdX(x-1)][cdY(y+2)] != 0 ) { unlike++; } }
  if(people[cdX(x  )][cdY(y+2)] == person ) { like++; }
  else{ if(people[cdX(x  )][cdY(y+2)] != 0 ) { unlike++; } }
  if(people[cdX(x+1)][cdY(y+2)] == person ) { like++; }
  else{ if(people[cdX(x+1)][cdY(y+2)] != 0 ) { unlike++; } }
  if(people[cdX(x+2)][cdY(y+2)] == person ) { like++; }
  else{ if(people[cdX(x+2)][cdY(y+2)] != 0 ) { unlike++; } }  

  likeCount+=like; unlikeCount+=unlike;


  if(like+unlike == 0) return 1;
  else{
    if(like >= calcCountLike(round(rateOfHappy*100), like+unlike ))
         { return 0; } 
    else { return 1; }
  }
}

void swapPeople(int p1, int p2)
{
  int x1 = p2x(p1); int y1 = p2y(p1);
  int x2 = p2x(p2); int y2 = p2y(p2);  
  int t = people[x1][y1];
  people[x1][y1]=people[x2][y2];
  people[x2][y2]=t;
}


int cdX(int x){
  if(x>=cntx){ return(x-cntx); }
  if(x<0    ){ return(cntx+x); }
  return(x);
}

int cdY(int y){
  if(y>=cnty){ return(y-cnty); }
  if(y<0    ){ return(cnty+y); }
  return(y);
}

int p2x(int p) { return p % cntx; }

int p2y(int p) { return floor(p/cntx); }
