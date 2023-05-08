import java.sql.Statement;

/**
 * Interface for menu classes.
 * Each manu the user could visit should implement the basic methods.
 */
public interface Menu {
    /**
     * Display the current menu and ready for taking input.
     * @return true if and only if the user input the valid command.
     */
    public boolean displayMenu();

    /**
     * Run the command input by the current user
     * @param command the input command
     * @param U current User
     * @param aStatement a Statement object for executing queries.
     */
    public void runCommand(String command, User U, Statement aStatement);

    /**
     * This method is used to clear the information that may stored by visiting current menu.
     * Pop out the page from the user's visitStack.
     * @param aUser the current User.
     */
    public void quitMenu(User aUser);
}
