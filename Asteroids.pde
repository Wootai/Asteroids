Asteroid a;
Ship ship;
ArrayList<Asteroid> asteroids;

void setup(){
  size(800, 600);
  asteroids = new ArrayList<Asteroid>();

  for(int i = 0; i < 1; i++){
    a = new Asteroid(random(width), random(height), 10);
    asteroids.add(a);
  }
  
  ship = new Ship(width*.5, height*.5);
}

void draw(){
  background(0);
  for(Asteroid a: asteroids){
    a.show();
    a.update();
  }
  ship.show();
  ship.update();
}