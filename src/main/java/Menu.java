import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Scanner;

public class Menu {
    public static void main(String[] args) {
        AnimalRegistry registry = new AnimalRegistry();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("1. Добавить животное");
            System.out.println("2. Вывести список команд животного");
            System.out.println("3. Обучить новую команду");
            System.out.println("4. Вывести список животных по дате рождения");
            System.out.println("5. Вывести общее количество созданных животных");
            System.out.println("6. Удалить животное");
            System.out.println("7. Выход");

            String choice = scanner.nextLine();

            switch (choice) {
                case "1":
                    System.out.println("Введите имя животного:");
                    String name = scanner.nextLine();
                    if (name.isEmpty()) {
                        System.out.println("Имя не может быть пустым. Пожалуйста, попробуйте еще раз.");
                        break;
                    }
                    System.out.println("Выберите тип животного из следующего списка:");
                    for (String animalType : Animal.possibleAnimalTypes) {
                        System.out.println(animalType);
                    }
                    String type = scanner.nextLine();
                    if (!Animal.possibleAnimalTypes.contains(type)) {
                        System.out.println("Введенный тип животного некорректен. Пожалуйста, попробуйте еще раз.");
                        break;
                    }
                    System.out.println("Введите дату рождения животного в формате ГГГГ-ММ-ДД:");
                    String birthDate = scanner.nextLine();
                    try {
                        LocalDate date = LocalDate.parse(birthDate);
                        if (date.isAfter(LocalDate.now())) {
                            System.out.println("Дата рождения не может быть в будущем. Пожалуйста, попробуйте еще раз.");
                        } else {
                            Animal animal = null;
                            switch (type) {
                                case "собака":
                                    animal = new Dog(name, birthDate);
                                    break;
                                case "кошка":
                                    animal = new Cat(name, birthDate);
                                    break;
                                case "хомяк":
                                    animal = new Hamster(name, birthDate);
                                    break;
                                case "лошадь":
                                    animal = new Horse(name, birthDate);
                                    break;
                                case "верблюд":
                                    animal = new Camel(name, birthDate);
                                    break;
                                case "осел":
                                    animal = new Donkey(name, birthDate);
                                    break;
                                default:
                                    System.out.println("Неверный тип животного. Пожалуйста, попробуйте еще раз.");
                                    break;
                            }
                            if (animal != null) {
                                registry.addAnimal(animal);
                            }
                            break;
                        }
                    } catch (DateTimeParseException e) {
                        System.out.println("Дата рождения введена некорректно. Пожалуйста, попробуйте еще раз.");
                    }
                case "2":
                    System.out.println("Введите имя животного:");
                    name = scanner.nextLine();
                    Animal animal3 = registry.findAnimalByName(name);
                    if (animal3 == null) {
                        System.out.println("Животное с таким именем не найдено.");
                        break;
                    }
                    List<String> commands = registry.getAnimalCommands(name);
                    if (commands.isEmpty()) {
                        System.out.println("Животное не обучено никаким командам.");
                    } else {
                        System.out.println(commands);
                    }
                    break;
                case "3":
                    System.out.println("Введите имя животного:");
                    name = scanner.nextLine();
                    Animal animal1 = registry.findAnimalByName(name);
                    if (animal1 == null) {
                        System.out.println("Животное с таким именем не найдено.");
                        break;
                    }
                    System.out.println("Выберите команду для обучения из следующего списка:");
                    for (String command : Animal.possibleCommands) {
                        System.out.println(command);
                    }
                    String command = scanner.nextLine();
                    if (!Animal.possibleCommands.contains(command)) {
                        System.out.println("Введенная команда некорректна.");
                        break;
                    }
                    registry.teachCommand(name, command);
                    System.out.println(name + " успешно изучил "+ command);
                    break;
                case "4":
                    List<Animal> animals = registry.getAnimalsByBirthDate();
                    if (animals.isEmpty()) {
                        System.out.println("Животных нет.");
                    } else {
                        for (Animal animal2 : animals) {
                            System.out.println(animal2.name + " " + animal2.birthDate + " " + animal2.getClass().getSimpleName());
                        }
                    }
                    break;
                case "5":
                    System.out.println(registry.getTotalAnimals());
                    break;
                case "6":
                    System.out.println("Введите имя животного, которое вы хотите удалить:");
                    String name1 = scanner.nextLine();
                    registry.removeAnimal(name1);
                    System.out.println("Животное " + name1 + " было удалено.");
                    break;
                case "7":
                    return;
                default:
                    System.out.println("Неверный выбор. Пожалуйста, попробуйте еще раз.");
            }
        }
    }
}