ArrayList<Organism> organism_list; //<>//
ArrayList<Organism> offspring_list;

void setup() {
  background(0);
  textSize(20);
  organism_list = new ArrayList<Organism>();
  offspring_list = new ArrayList<Organism>();
  size(750, 750);
  for (int i = 0; i < 4; i++) {
    organism_list.add(new Organism());
  }
  snowflake();
}

void draw() {
  text("Hover over snowflakes you like best to assign their fitness values", 10, 20);
  text("Press ENTER to breed you flakes", 10, 740);
  for (int h = 1; h < organism_list.size() + 1; h++) {
    if ((mouseX >= (150 * h - 50)) && (mouseX <= (150 * h + 50)) && (mouseY >= (150 * h - 50)) && (mouseY <= (150 * h + 50))) {
      organism_list.get(h - 1).fitness = (organism_list.get(h - 1).fitness + 1);
      delay(200);
      println("The fitness of organism " + (h - 1) + " is " + organism_list.get(h - 1).fitness);
    }
  }
}

int roulette(ArrayList<Organism> list) { //roulette function
  int list_sum = 0;
  int previous_sum, random_num;

  for (int i = 0; i < list.size(); i++) {
    list_sum += list.get(i).fitness;
  }
  previous_sum = 0;
  random_num = floor(random(list_sum + 1));
  for (int index = 0; index < list.size(); index++) {
    if ((random_num > previous_sum) && (random_num <= (previous_sum + list.get(index).fitness))) {
      return index;
    }
    previous_sum += list.get(index).fitness;
  }
  return list.size() - 1;
}


void snowflake() {
  for (int i = 0; i < organism_list.size(); i++) {
    organism_list.get(i).render(150, 150); //render the current parents
  }
  //offspring_list.clear();
}

void keyPressed() {
  if (key == ENTER) {
    clear(); //<>//
    offspring_list = new ArrayList<Organism>();

    for (int i = 0; i < organism_list.size(); i++) { //breed 2 parents of corresponding indecies
      int parentPos1 = roulette(organism_list);
      int parentPos2 = roulette(organism_list);
      Organism offspring = organism_list.get(parentPos1).breed(organism_list.get(parentPos2));
      offspring.render(150, 150);
      offspring_list.add(offspring);
    } 
    organism_list = offspring_list;
  }
}
