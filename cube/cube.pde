color red, green, blue, yellow, orange, white, bg;
color[][][] c = new color[6][3][3];
color[][][] d = new color[6][3][3];
char kkey;
float t=0, r_t=0, r_fin=15, r_a=0;
float l = 60;
float r = 10;
float s = 10;
float move = l+s*2, move_amp = l+s*2;
float fmove = move+l/2+s, fmove_amp = move+l/2+s;

void setup(){
  size(1024, 768, P3D);
  red = color(#AE5B52);
  orange = color(#B8835C);
  yellow = color(#C4C25E);
  green = color(#95B371);
  blue = color(#6787A1);
  white = color(#F1F0EF);
  bg = color(#1A1A18);
  background(bg);
  stroke(bg);
  strokeWeight(2);
  reset_color();
  
}

void draw(){
  translate(width/2, height/2, 0);
  t+=.001;
  clear();
  fill(bg);
  pushMatrix();
  translate(0, 0, -300);
  rect(-width, -height, width*4, height*4);
  move = move_amp*(1+.04*sin(t*50));
  fmove = fmove_amp*(1+.03*sin(t*50));
  popMatrix();
  
  pushMatrix();
  
  rotateY(-t);
  rotateZ(-PI/10);
  if(r_t == 0)cube();
  else if(r_t==r_fin){
    r_t=0;
    if(kkey == 'b') switch_side(0, true);
    else if(kkey == 'f') switch_side(1, true);
    else if(kkey == 'l') switch_side(2, true);
    else if(kkey == 'r') switch_side(3, true);
    else if(kkey == 'd') switch_side(4, true);
    else if(kkey == 'u') switch_side(5, true);
    cube();
  }
  else {
    r_a=HALF_PI*sin(r_t/r_fin)*1.2;
    r_t++;
    if(kkey == 'b') turn_side(0, true);
    else if(kkey == 'f') turn_side(1, true);
    else if(kkey == 'l') turn_side(2, true);
    else if(kkey == 'r') turn_side(3, true);
    else if(kkey == 'd') turn_side(4, true);
    else if(kkey == 'u') turn_side(5, true);
  }
  
  popMatrix();
  
}

void keyTyped(){
  if(r_t == 0 && (key=='b'||key=='f'||key=='l'||key=='r'||key=='d'||key=='u')){
    r_t=1;
    kkey = key;
    if(kkey == 'b') switch_whole(0, true);
    else if(kkey == 'f') switch_whole(1, true);
    else if(kkey == 'l') switch_whole(2, true);
    else if(kkey == 'r') switch_whole(3, true);
    else if(kkey == 'd') switch_whole(4, true);
    else if(kkey == 'u') switch_whole(5, true);
  }
}

void cube(){
  
  //back
  pushMatrix();
  rotateY(PI);
  face(c[0]);
  popMatrix();
  
  //front
  pushMatrix();
  face(c[1]);
  popMatrix();
  
  //left
  pushMatrix();
  rotateY(-HALF_PI);
  face(c[2]);
  popMatrix();
  
  //right
  pushMatrix();
  rotateY(HALF_PI);
  face(c[3]);
  popMatrix(); 
  
  //down
  pushMatrix();
  rotateX(-HALF_PI);
  face(c[4]);
  popMatrix();
  
  //up
  pushMatrix();
  rotateX(HALF_PI);
  face(c[5]);
  popMatrix();
    
}

void face(color cc[][]){
  translate(0, 0, fmove);
  pushMatrix();
  row(cc[1]);
  translate(move, 0, 0);
  row(cc[0]);
  translate(-move*2, 0, 0);
  row(cc[2]);
  popMatrix();
}

void row(color ccc[]){
  pushMatrix();
  sticker(ccc[1]);
  translate(0, move, 0);
  sticker(ccc[0]);
  translate(0, -move*2, 0);
  sticker(ccc[2]);
  popMatrix();
}

void sticker(color cccc){
  fill(cccc);
  rect(-l/2, -l/2, l, l, r);
}

void reset_color(){
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      c[0][i][j]=green;
    }
  }
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      c[1][i][j]=blue;
    }
  }
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      c[2][i][j]=orange;
    }
  }
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      c[3][i][j]=red;
    }
  }
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      c[4][i][j]=white;
    }
  }
  for(int i=0;i<3;i++){
    for(int j=0;j<3;j++){
      c[5][i][j]=yellow;
    }
  }
}

void test_color(){
  /*
  for(int i=0;i<6;i++){
    for(int j=0;j<3;j++){
      for(int k=0;k<3;k++){
        c[i][j][k] = color(i*47, j*47, k*47);
      }
    }
  }
  */
  int k=5;
  c[k][0][0] = white;
  c[k][1][0] = yellow;
  c[k][0][2] = green;
}

void switch_side(int fac, boolean dir){
  
  color[] c1 = new color[8];
  color[] c2 = new color[3];
  //clockwise
  if(dir == true){
    
    c1[0] = c[fac][0][1];
    c1[1] = c[fac][1][2];
    c1[2] = c[fac][2][1];
    c1[3] = c[fac][1][0];
    c1[4] = c[fac][0][2];
    c1[5] = c[fac][2][2];
    c1[6] = c[fac][2][0];
    c1[7] = c[fac][0][0];
    c[fac][1][0] = c1[0];
    c[fac][0][1] = c1[1];
    c[fac][1][2] = c1[2];
    c[fac][2][1] = c1[3];
    c[fac][0][0] = c1[4];
    c[fac][0][2] = c1[5];
    c[fac][2][2] = c1[6];
    c[fac][2][0] = c1[7];
    
    //back
    if(fac == 0){
      for(int i=0;i<3;i++) c2[i] = c[5][2-i][2];
       for(int i=0;i<3;i++){
         c[5][2-i][2] = c[3][0][2-i];
         c[3][0][2-i] = c[4][i][0];
         c[4][i][0] = c[2][2][i];
       }
       for(int i=0;i<3;i++) c[2][2][i] = c2[i];
    }
    //front
    else if(fac == 1){
      for(int i=0;i<3;i++) c2[i] = c[5][2-i][0];
       for(int i=0;i<3;i++){
         c[5][2-i][0] = c[2][0][2-i];
         c[2][0][2-i] = c[4][2-i][2];
         c[4][2-i][2] = c[3][2][i];
       }
       for(int i=0;i<3;i++) c[3][2][i] = c2[i];
    }
    //left
    else if(fac == 2){
      for(int i=0;i<3;i++) c2[i] = c[5][2][i];
       for(int i=0;i<3;i++){
         c[5][2][i] = c[0][0][2-i];
         c[0][0][2-i] = c[4][2][i];
         c[4][2][i] = c[1][2][i];
       }
       for(int i=0;i<3;i++) c[1][2][i] = c2[i];
    }
    //right
    else if(fac == 3){
      for(int i=0;i<3;i++) c2[i] = c[5][0][i];
       for(int i=0;i<3;i++){
         c[5][0][i] = c[1][0][i];
         c[1][0][i] = c[4][0][i];
         c[4][0][i] = c[0][2][2-i];
       }
       for(int i=0;i<3;i++) c[0][2][2-i] = c2[i];
    }
    //down
    else if(fac == 4){
      for(int i=0;i<3;i++) c2[i] = c[1][i][0];
       for(int i=0;i<3;i++){
         c[1][i][0] = c[2][i][0];
         c[2][i][0] = c[0][i][0];
         c[0][i][0] = c[3][i][0];
       }
       for(int i=0;i<3;i++) c[3][i][0] = c2[i];
    }
    //up
    else if (fac == 5){
       for(int i=0;i<3;i++) c2[i] = c[1][i][2];
       for(int i=0;i<3;i++){
         c[1][i][2] = c[3][i][2];
         c[3][i][2] = c[0][i][2];
         c[0][i][2] = c[2][i][2];
       }
       for(int i=0;i<3;i++) c[2][i][2] = c2[i];
    }
    
  }
  
  else {
    
    c1[0] = c[fac][0][1];
    c1[1] = c[fac][1][2];
    c1[2] = c[fac][2][1];
    c1[3] = c[fac][1][0];
    c1[4] = c[fac][0][2];
    c1[5] = c[fac][2][2];
    c1[6] = c[fac][2][0];
    c1[7] = c[fac][0][0];
    c[fac][1][2] = c1[0];
    c[fac][2][1] = c1[1];
    c[fac][1][0] = c1[2];
    c[fac][0][1] = c1[3];
    c[fac][2][2] = c1[4];
    c[fac][2][0] = c1[5];
    c[fac][0][0] = c1[6];
    c[fac][0][2] = c1[7];
    
  }
}
void switch_whole_rotate_face(int ffac, int dir){
  if(dir==1){
    d[ffac][1][0] = c[ffac][0][1];
    d[ffac][0][1] = c[ffac][1][2];
    d[ffac][1][2] = c[ffac][2][1];
    d[ffac][2][1] = c[ffac][1][0];
    d[ffac][0][0] = c[ffac][0][2];
    d[ffac][0][2] = c[ffac][2][2];
    d[ffac][2][2] = c[ffac][2][0];
    d[ffac][2][0] = c[ffac][0][0];
    d[ffac][1][1] = c[ffac][1][1];
  }
  else if(dir==-1){
    d[ffac][1][0] = c[ffac][2][1];
    d[ffac][0][1] = c[ffac][1][0];
    d[ffac][1][2] = c[ffac][0][1];
    d[ffac][2][1] = c[ffac][1][2];
    d[ffac][0][0] = c[ffac][2][0];
    d[ffac][0][2] = c[ffac][0][0];
    d[ffac][2][2] = c[ffac][0][2];
    d[ffac][2][0] = c[ffac][2][2];
    d[ffac][1][1] = c[ffac][1][1];
  }
  else if(dir==2){
    d[ffac][1][0] = c[ffac][1][2];
    d[ffac][0][1] = c[ffac][2][1];
    d[ffac][1][2] = c[ffac][1][0];
    d[ffac][2][1] = c[ffac][0][1];
    d[ffac][0][0] = c[ffac][2][2];
    d[ffac][0][2] = c[ffac][2][0];
    d[ffac][2][2] = c[ffac][0][0];
    d[ffac][2][0] = c[ffac][0][2];
    d[ffac][1][1] = c[ffac][1][1];
  }
}
void switch_whole(int fac, boolean dir){
  if(dir){
    if(fac==0){
      for(int j=0;j<3;j++){
        for(int k=0;k<3;k++){
          d[3][j][k] = c[0][j][k];
          d[0][j][k] = c[2][j][k];
          d[2][j][k] = c[1][j][k];
          d[1][j][k] = c[3][j][k];
        }
      }
      switch_whole_rotate_face(5, 1);
      switch_whole_rotate_face(4, -1);
    }
    else if(fac==1){for(int j=0;j<3;j++){
        for(int k=0;k<3;k++){
          d[3][j][k] = c[1][j][k];
          d[0][j][k] = c[3][j][k];
          d[2][j][k] = c[0][j][k];
          d[1][j][k] = c[2][j][k];
        }
      }
      switch_whole_rotate_face(5, -1);
      switch_whole_rotate_face(4, 1);
    }
    else if(fac==2){
      for(int j=0;j<3;j++){
        for(int k=0;k<3;k++){
          d[3][j][k] = c[2][j][k];
          d[0][j][k] = c[1][j][k];
          d[2][j][k] = c[3][j][k];
          d[1][j][k] = c[0][j][k];
        }
      }
      switch_whole_rotate_face(5, 2);
      switch_whole_rotate_face(4, 2);
    }
    else if(fac==3){
      for(int i=0;i<6;i++){
        for(int j=0;j<3;j++){
          for(int k=0;k<3;k++){
            d[i][j][k] = c[i][j][k];
          }
        }
      }
    }
    else if(fac==4){
      for(int j=0;j<3;j++){
        for(int k=0;k<3;k++){
          d[3][j][k] = c[4][2-k][j];
          d[4][j][k] = c[2][2-k][j];
          d[2][j][k] = c[5][2-k][j];
          d[5][j][k] = c[3][2-k][j];
        }
      }
      switch_whole_rotate_face(1, -1);
      switch_whole_rotate_face(0, 1);
    }
    else if(fac==5){
      for(int j=0;j<3;j++){
        for(int k=0;k<3;k++){
          d[4][2-k][j] = c[3][j][k];
          d[2][2-k][j] = c[4][j][k];
          d[5][2-k][j] = c[2][j][k];
          d[3][2-k][j] = c[5][j][k];
        }
      }
      switch_whole_rotate_face(1, 1);
      switch_whole_rotate_face(0, -1);
    }
  }
}

void turn_side(int fac, boolean dir){
  
  pushMatrix();
  
  if(dir){
    if(fac==0) rotateY(HALF_PI);
    else if(fac==1) rotateY(-HALF_PI);
    else if(fac==2) rotateY(PI);
    else if(fac==4) rotateZ(HALF_PI);
    else if(fac==5) rotateZ(-HALF_PI);
    
    //left
    pushMatrix();
    rotateY(-HALF_PI);
    face(d[2]);
    popMatrix();
    
    //right
    pushMatrix();
    rotateY(HALF_PI);
    rotateZ(r_a);
    face(d[3]);
    popMatrix();
    
    //back
    pushMatrix();
    rotateY(PI);
    translate(0, 0, fmove);
    pushMatrix();
    row(d[0][1]);
    translate(move, 0, 0);
    row(d[0][0]);
    popMatrix();
    translate(0, 0, -fmove);
    rotateX(-r_a);
    translate(0, 0, fmove);
    translate(-move, 0, 0);
    row(d[0][2]);
    popMatrix();
    
    //front
    pushMatrix();
    translate(0, 0, fmove);
    pushMatrix();
    row(d[1][1]);
    translate(-move, 0, 0);
    row(d[1][2]);
    popMatrix();
    translate(0, 0, -fmove);
    rotateX(r_a);
    translate(0, 0, fmove);
    translate(move, 0, 0);
    row(d[1][0]);
    popMatrix();
    
    //down
    pushMatrix();
    rotateX(-HALF_PI);
    translate(0, 0, fmove);
    pushMatrix();
    row(d[4][1]);
    translate(-move, 0, 0);
    row(d[4][2]);
    popMatrix();
    translate(0, 0, -fmove);
    rotateX(r_a);
    translate(0, 0, fmove);
    translate(move, 0, 0);
    row(d[4][0]);
    popMatrix();
    
    //up
    pushMatrix();
    rotateX(HALF_PI);
    translate(0, 0, fmove);
    pushMatrix();
    row(d[5][1]);
    translate(-move, 0, 0);
    row(d[5][2]);
    popMatrix();
    translate(0, 0, -fmove);
    rotateX(r_a);
    translate(0, 0, fmove);
    translate(move, 0, 0);
    row(d[5][0]);
    popMatrix();
    
  }
  else{
  }
  
  popMatrix();
  
}
