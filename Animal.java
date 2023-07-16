public class Animal {
    private String name;
    private String commands;
    
    public String getCommands() {
        return commands;
    }

    public void setCommands(String commands) {
        this.commands = commands;
        System.out.println("Новая команда - изучена\n");
    }

    private String birthDay;
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(String birthDay) {
        this.birthDay = birthDay;
    }

    public Animal(String name, String type, String birthDay, String commands) {
        this.name = name;
        this.birthDay = birthDay;
        this.type = type;
        this.commands = commands;
    }

    public String getName() {
        return name;
    }

    public String writeElement() {
        return (this.type + "," + this.name + "," + this.birthDay + "," + this.getCommands());
    }
}
