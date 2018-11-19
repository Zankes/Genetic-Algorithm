class Organism {
  ArrayList<Float> feats;
  int fitness;
  
  Organism() {    
    fitness = 0;
    feats = new ArrayList<Float>();

    for (int i = 0; i < 10; i++) {
      feats.add(random(255));
    }
    
    //for (int i = 0; i < organism_list.size(); i++) {
    //  ratings.add(random(10));
    //}
  }

  void render(int xpos, int ypos) {
    translate(xpos, ypos);
    stroke(this.feats.get(1), this.feats.get(2), this.feats.get(3));
    for (int j = 0; j < 4; j++) { //for making line groups
      for (int q = 3; q < 9; q++) { //for making line group
        line(0, 0, this.feats.get(q), this.feats.get(q + 1));
      }
      rotate(PI/2);
    }
}
  
  Organism breed(Organism mate) {
    // this - one of the parents
    // mate - one of the patents
    Organism offspring = new Organism();

    for (int i = 0; i < feats.size(); i++) {
      int rando = floor(random(2)); //randomly choose traits between parents
      if (rando == 0) {
        offspring.feats.set(i,this.feats.get(i)); 
      } else {
        offspring.feats.set(i,mate.feats.get(i));
      }
    }
    
    int random_num, previous_sum, list_sum = 0; //mutation chance after breeding
    int[] mutation_rate = {20, 20, 20, 20, 20};
    
    for (int i = 0; i < mutation_rate.length; i++) {
    list_sum += mutation_rate[i];
  }
    previous_sum = 0;
    random_num = floor(random(list_sum + 1));
    for (int i = 0; i < mutation_rate.length; i++) {
      
      if ((random_num > previous_sum) && (random_num <= (previous_sum + mutation_rate[i]))) {        
        if (i == 0) {
          feats.set(floor(random(feats.size())), random(255));
        }
      }
      previous_sum += mutation_rate[i];
    }
    
    return offspring; //return 2 offsprings with traits chosen randomly from both parents combined
  }
}
