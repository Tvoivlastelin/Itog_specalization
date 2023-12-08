import java.util.ArrayList;
import java.util.List;

abstract class Animal {
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