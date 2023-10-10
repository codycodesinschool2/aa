boolean[][] wallsX, wallsY;
ArrayList<PVector> visited, stack;

int rows = 400;
int cols = 520;
int w = 5;
int h = 5;
PVector curr;

void setup() {
  size(2600,2000);
  w = width/cols;
  h = height/rows;
  //rows = height/h;
  //cols = width/w;
  println(rows);
  wallsX = new boolean[cols][rows];
  wallsY = new boolean[cols][rows];
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      wallsX[i][j] = true;
      wallsY[i][j] = true;
    }
  }
  
  curr = new PVector(0,0);
  
  visited = new ArrayList<PVector>();
  stack = new ArrayList<PVector>();
  
  visited.add(curr.copy());
  stack.add(curr.copy());
  
    //println("visited: " + visited.size() + " / " + rows*cols);
}


void draw() {
  while(true) {
  for(int k = 0; k < 100; k++) {
  PVector popped = stack.remove(stack.size()-1);
  curr = popped.copy();
  PVector[] neighbors = getNeighbors();
  if(neighbors.length != 0) {
    stack.add(curr.copy());
    int i = floor(random(neighbors.length));
    PVector n = neighbors[i];
    removeWall(n,curr);
    visit(n);
    stack.add(n);
  }
  if(stack.size() == 0) {
    noLoop();
    renderPrint();
    save("maze.png");
    return;
  }
  }
    //println("visited: " + visited.size() + " / " + rows*cols);
}}

void visit(PVector p) {
  for(int i = 1; i < visited.size(); i++) {
    if(visited.get(i).x+visited.get(i).y*cols>p.x+p.y*cols) {
      visited.add(i-1,p.copy());
      return;
    }
  }
  visited.add(p.copy());
}


PVector[] getNeighbors() {
  ArrayList<PVector> l = new ArrayList<PVector>();
  if(curr.x+1<cols)if(!hasVisited((int)curr.x+1,(int)curr.y)) l.add(new PVector((int)curr.x+1,(int)curr.y));
  if(curr.x-1>-1  )if(!hasVisited((int)curr.x-1,(int)curr.y)) l.add(new PVector((int)curr.x-1,(int)curr.y));
  if(curr.y+1<rows)if(!hasVisited((int)curr.x,(int)curr.y+1)) l.add(new PVector((int)curr.x,(int)curr.y+1));
  if(curr.y-1>-1  )if(!hasVisited((int)curr.x,(int)curr.y-1)) l.add(new PVector((int)curr.x,(int)curr.y-1));
  PVector[] a = new PVector[l.size()];
  for(int i = 0; i < l.size(); i++) {
    a[i] = l.get(i);
  }
  return a;

}

void removeWall(PVector p1, PVector p2) {
  if(p1.y == p2.y) {
    if(p1.x > p2.x) {
      wallsX[(int)p1.x][(int)p1.y] = false;
    } else {
      wallsX[(int)p2.x][(int)p2.y] = false;
    }
  } else {
    if(p1.y > p2.y) {
      wallsY[(int)p1.x][(int)p1.y] = false;
    } else {
      wallsY[(int)p2.x][(int)p2.y] = false;
    }
  }
}

boolean hasVisited(int x, int y) {
  for(int i = 0; i < visited.size(); i++) {
    if(visited.get(i).x == x && visited.get(i).y == y) return true;
  }
  return false;
}




void render() {
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < cols; j++) {
      fill(51);
      if(hasVisited(j,i)) fill(156,23,167);
      if(j == curr.x && i == curr.y) fill(13, 178,36);
      if((j == 0 && i == 0) || (j == cols-1 && i == rows-1)) fill(207,23,57);
      noStroke();
      rect(j*w,i*h,w,h);
      stroke(255);
      if(wallsX[j][i]) {
        line(j*w-1,i*h-1,j*w-1,i*h+h-1);
      }
      if(wallsY[j][i]) {
        line(j*w-1,i*h-1,j*w+w-1,i*h-1);
      }
    }
  }
}

void renderPrint() {
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < cols; j++) {
      
      fill(255);

      noStroke();
      rect(j*w,i*h,w,h);
      if((j == 0 && i == 0) || (j == cols-1 && i == rows-1)) {
        noStroke();
        fill(0);
        println(j*w+(w/2),i*h+(h/2));
        circle(j*w+(w/2),i*h+(h/2),min(w,h)/2);
    }
      stroke(0);
      if(wallsX[j][i]) {
        line(j*w-1,i*h-1,j*w-1,i*h+h-1);
      }
      if(wallsY[j][i]) {
        line(j*w-1,i*h-1,j*w+w-1,i*h-1);
      }
    }
  }
}
