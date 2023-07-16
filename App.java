import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class App {
    final static String DATE_FORMAT = "dd.MM.yyyy";

    public static void main(String[] args) throws FileNotFoundException, IOException, ParseException {
        List<Animal> animalsList = new ArrayList<>();
        boolean flag = true;
        Counter counter = new Counter();
        String[] words;

        try (BufferedReader reader = new BufferedReader(new FileReader("base.txt"))) {
            System.out.println("Сейчас у вас есть:\n");
            String line = reader.readLine();
            counter.setValue(0);
            String commandsForInitialInput = "";
            while (line != null) {
                words = line.split(",");
                System.out.println(String.join(";", words));
                for (int i = 3; i < words.length; i++) {
                    if (i < words.length - 1) {
                        commandsForInitialInput = commandsForInitialInput + words[i] + ",";
                    } else
                        commandsForInitialInput = commandsForInitialInput + words[i];
                }
                switch (words[0]) {
                    case "Dog":
                        animalsList.add(new Dog(words[1], words[0], words[2], commandsForInitialInput));
                        counter.add();
                        break;
                    case "Cat":
                        animalsList.add(new Cat(words[1], words[0], words[2], commandsForInitialInput));
                        counter.add();
                        break;
                    case "Hamster":
                        animalsList.add(new Hamster(words[1], words[0], words[2], commandsForInitialInput));
                        counter.add();
                        break;
                    case "Horse":
                        animalsList.add(new Horse(words[1], words[0], words[2], commandsForInitialInput));
                        counter.add();
                        break;
                    case "Camel":
                        animalsList.add(new Camel(words[1], words[0], words[2], commandsForInitialInput));
                        counter.add();
                        break;
                    case "Donkey":
                        animalsList.add(new Donkey(words[1], words[0], words[2], commandsForInitialInput));
                        counter.add();
                        break;

                }
                ;
                line = reader.readLine();
                commandsForInitialInput = "";
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Общее количество животных в питомнике - " + counter.getCount() + "\n");
        }

        try (Scanner scanner = new Scanner(System.in)) {
            while (flag == true) {
                System.out.println("Выберите команду:");
                System.out.println("1. Добавить животное");
                System.out.println("2. Получить список команд");
                System.out.println("3. Учить новые команды");
                System.out.println("4. Выход");
                System.out.println("5. Сохранить все изменения");
                System.out.print("Введите номер команды: ");
                int choice = scanner.nextInt();
                switch (choice) {
                    case 1:
                        counter.add();
                        System.out.println("Введите тип животного: ");
                        String type = scanner.next();
                        System.out.println("Введите имя животного: ");
                        String name = scanner.next();
                        System.out.println("Введите дату рождения (дд.мм.гггг): ");
                        String initialBirthday = scanner.next();
                        Boolean dateValidation = isDateValid(initialBirthday);
                        if (dateValidation != true) {
                            throw new RuntimeException("Дата не корретна");
                        }
                        System.out.println("Введите команды которые знает животное: ");
                        String commandString = scanner.next();
                        switch (type) {
                            case "Dog":
                                animalsList.add(new Dog(name, type, initialBirthday, commandString));
                                counter.add();
                                break;
                            case "Cat":
                                animalsList.add(new Cat(name, type, initialBirthday, commandString));
                                counter.add();
                                break;
                            case "Hamster":
                                animalsList.add(new Hamster(name, type, initialBirthday, commandString));
                                counter.add();
                                break;
                            case "Horse":
                                animalsList.add(new Horse(name, type, initialBirthday, commandString));
                                counter.add();
                                break;
                            case "Camel":
                                animalsList.add(new Camel(name, type, initialBirthday, commandString));
                                counter.add();
                                break;
                            case "Donkey":
                                animalsList.add(new Donkey(name, type, initialBirthday, commandString));
                                counter.add();
                                break;
                            default:
                                System.out.println("Таких животных мы не обслуживаем");
                                break;
                        }
                        break;
                    case 2:
                        System.out.println("Введите Имя животного: ");
                        String aName = scanner.next();
                        Animal fAnimal = animalsList.stream()
                                .filter(a -> a.getName().equals(aName))
                                .findFirst()
                                .orElse(null);
                        if (fAnimal == null) {
                            System.out.println("Такого животного нет");
                            break;
                        }
                        System.out.println("Животное знает следующие команды: " + fAnimal.getCommands() + "\n");
                        break;
                    case 3:
                        System.out.println("Введите Имя животного");
                        String animalName = scanner.next();
                        Animal foundAnimal = animalsList.stream()
                                .filter(a -> a.getName().equals(animalName))
                                .findFirst()
                                .orElse(null);
                        if (foundAnimal == null) {
                            System.out.println("Такого животного нет");
                            break;
                        }
                        String initialCommand = foundAnimal.getCommands();
                        System.out.println("Введите новую команду: ");
                        String commandForAdd = scanner.next();
                        String command = initialCommand + "," + commandForAdd;
                        foundAnimal.setCommands(command);
                        break;
                    case 4:
                        flag = false;
                    case 5:
                        try (FileWriter writer = new FileWriter("base.txt", false)) {
                            String toWrite = "";
                            for (int i = 0; i < animalsList.size(); i++) {
                                toWrite = toWrite + animalsList.get(i).writeElement() + '\n';
                            }
                            writer.write(toWrite);
                        } catch (Exception error) {
                            System.out.println(error);
                        }
                        break;
                    default:
                        System.out.println("Нет такой команды");
                        break;
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean isDateValid(String date) {
        try {
            DateFormat df = new SimpleDateFormat(DATE_FORMAT);
            df.setLenient(false);
            df.parse(date);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }
}
