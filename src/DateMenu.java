import java.sql.SQLException;
import java.sql.Statement;

/**
 * This menu requires the user to enter a date for appointment.
 * Singleton Design Pattern
 */
public class DateMenu implements Menu{
    private static DateMenu menu= new DateMenu();
    public static Menu getInstance(){
        return menu;
    }
    private DateMenu(){};

    public boolean displayMenu(){
        System.out.println("Please enter the date (YYYY-MM-DD) for appointment list [E] to exit: ");
        return true;
    }
    public void runCommand(String command, User U, Statement aStatement){
        //If command is quit, reset User information and quit
        if(command.equals("E")){
            U.quitProgram();
        }
        else{
            try {
                U.setSelectedDate(command);
                U.addMenu(new AptMenu(command, aStatement, U));
            }catch (Exception e){
                if(U.getCurrentMenu() instanceof AptMenu){
                    U.getCurrentMenu().quitMenu(U);
                    System.out.println("Invalid input.");
                }
            }
        }
    }
    /**
     * This method will return the current menu to previous one.
     * @param aUser the user of current program
     */
    @Override
    public void quitMenu(User aUser) {
        aUser.setId(null);
        aUser.backToPreMenu();
    }



}
