import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
class AnimalRegistry {
    List<HomePet> homePets;
    List<PackAnimal> packAnimals;

    public AnimalRegistry() {
        this.homePets = new ArrayList<>();
        this.packAnimals = new ArrayList<>();
    }
    public void removeAnimal(String name) {
        Iterator<HomePet> iterator = homePets.iterator();
        while (iterator.hasNext()) {
            Animal animal = iterator.next();
            if (animal.name.equals(name)) {
                iterator.remove();
                Animal.animalCount--;
                return;
            }
        }
        Iterator<PackAnimal> iterator1 = packAnimals.iterator();
        while (iterator1.hasNext()) {
            Animal animal = iterator1.next();
            if (animal.name.equals(name)) {
                iterator1.remove();
                Animal.animalCount--;
                return;
            }
        }
    }
    public void addAnimal(Animal animal) {
        if (animal instanceof HomePet) {
            this.homePets.add((HomePet) animal);
        } else if (animal instanceof PackAnimal) {
            this.packAnimals.add((PackAnimal) animal);
        }
    }

    public List<String> getAnimalCommands(String name) {
        for (Animal animal : homePets) {
            if (animal.name.equals(name)) {
                return animal.getCommands();
            }
        }
        for (Animal animal : packAnimals) {
            if (animal.name.equals(name)) {
                return animal.getCommands();
            }
        }
        return null;
    }

    public void teachCommand(String name, String command) {
        for (Animal animal : homePets) {
            if (animal.name.equals(name)) {
                animal.addCommand(command);
            }
        }
        for (Animal animal : packAnimals) {
            if (animal.name.equals(name)) {
                animal.addCommand(command);
            }
        }
    }

    public List<Animal> getAnimalsByBirthDate() {
        List<Animal> sortedAnimals = new ArrayList<>();
        sortedAnimals.addAll(homePets);
        sortedAnimals.addAll(packAnimals);
        sortedAnimals.sort(Comparator.comparing(a -> a.birthDate));
        return sortedAnimals;
    }

    public int getTotalAnimals() {
        return Animal.getAnimalCount();
    }

    public Animal findAnimalByName(String name) {
        for (Animal animal : homePets) {
            if (animal.name.equals(name)) {
                return animal;
            }
        }
        for (Animal animal : packAnimals) {
            if (animal.name.equals(name)) {
                return animal;
            }
        }
        return null;
    }
}