import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

abstract class Animal {
    static List<String> possibleAnimalTypes = Arrays.asList("собака", "кошка", "хомяк", "лошадь", "верблюд", "осел");
    String name;
    String birthDate;
    List<String> commands;
    static int animalCount = 0;

    public Animal(String name, String birthDate) {
        this.name = name;
        this.birthDate = birthDate;
        this.commands = new ArrayList<>();
        animalCount++;
    }
    static List<String> possibleCommands = Arrays.asList("сидеть", "лежать", "прыгать", "бегать");

    public void addCommand(String command) {
        this.commands.add(command);
    }

    public List<String> getCommands() {
        return this.commands;
    }

    public static int getAnimalCount() {
        return animalCount;
    }
}