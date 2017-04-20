class Ship{
  PVector pos;
  PVector vel;
  PVector acc;
  PShape s;
  float rotation;
  float heading;
  Bullet b;
  float maxBoost;
  
  Ship(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    s = build();
    rotation = 0;
    heading = rotation;
    maxBoost = 2;
  }
  
  void update(){
    vel.add(acc);
    if(vel.mag() > maxBoost){
      vel.setMag(maxBoost);
    }
    pos.add(vel);
    if(pos.x > width+s.getWidth()){
      pos.x = 0 - s.getWidth()/2;
    }
    if(pos.y > height+s.getWidth()){
      pos.y = 0 - s.getWidth()/2;
    }
    if(pos.x < 0 - s.getWidth()){
      pos.x = width+s.getWidth()/2;
    }
    if (pos.y < 0 - s.getWidth()){
      pos.y = height+s.getHeight()/2;;
    }
    acc.mult(0);
    
    if(b!= null){
      if(b.pos.x > width+s.getWidth()){
        b = null;
        }
      else if(b.pos.y > height+s.getWidth()){
        b = null;
        }
      else if(b.pos.x < 0 - s.getWidth()){
        b = null;
        }
      else if (b.pos.y < 0 - s.getWidth()){
        b = null;
        }
  
    }
    
    if(b != null){
      b.update();
      b.show();
    }
  }
  
  void show(){
    s.rotate(rotation);
    heading += rotation;
    rotation = 0;
    shape(s, pos.x, pos.y);
    stroke(255);
  } 
  
  PShape build(){
    PShape r = createShape();
    r.beginShape();
    r.noFill();
    r.stroke(0, 255, 0);
    r.vertex(0, -7);
    r.vertex(6, 7);
    r.vertex(-6, 7);
    r.endShape(CLOSE);
    return r;
  }
  void boost(){
    PVector dir = new PVector(sin(-heading), cos(-heading));
    dir.setMag(.5);
    acc.sub(dir);
  }
  void shoot(){
    if(b==null){
      b = new Bullet(pos.x, pos.y, sin(-heading), cos(-heading));  
    }
  }
}

class Bullet{
  PVector pos;
  PVector vel;
  PVector prevPos;
  
  Bullet(float x, float y, float vx, float vy){
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    prevPos = new PVector(x,y);
  }
  
  void update(){
    collision();  //Collision is not working properly
    vel.setMag(2);
    prevPos = pos.copy();
    pos.sub(vel);
  }
  
  void collision(){
    for(int i = 0; i < asteroids.size(); i++){
      Asteroid as = asteroids.get(i);
      for(Line l: as.lines){
        println(pos, prevPos);
        println(l.pos1, l.pos2);
        if(doIntersect(pos, prevPos, l.pos1, l.pos2)){
          println("HIT");
        }
      }
    }
  }
  
  void show(){
    strokeWeight(3);
    point(pos.x, pos.y);
    strokeWeight(1);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
  }
}