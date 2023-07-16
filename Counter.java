public class Counter {
    private int count;

    public void add() {
        count++;
    }

    public int getCount() {
        return count;
    }

    public void resetCount() {
        count = 0;
    }

    public void setValue(Integer count) {
        this.count = count;
    }
}
