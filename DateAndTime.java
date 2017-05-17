import java.util.*;

public class DateAndTime {

    static Scanner in = new Scanner(System.in);

    public static void main(String[] args) {

        int month = in.nextInt();
        int day = in.nextInt();
        int year = in.nextInt();

        in.close();

        Calendar cal = Calendar.getInstance();

        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month-1);
        cal.set(Calendar.DAY_OF_MONTH, day);

        int dayInWeek = cal.get(Calendar.DAY_OF_WEEK);
        String solutionDay;

        switch(dayInWeek) {
            case 1: solutionDay = "SUNDAY";
                    break;
            case 2: solutionDay = "MONDAY";
                    break;
            case 3: solutionDay = "TUESDAY";
                    break;
            case 4: solutionDay = "WEDNESDAY";
                    break;
            case 5: solutionDay = "THURSDAY";
                    break;
            case 6: solutionDay = "FRIDAY";
                    break;
            case 7: solutionDay = "SATURDAY";
                    break;
            default: solutionDay = "Invalid Day!";
                    break;
        }

        System.out.println(solutionDay);

    }
}
