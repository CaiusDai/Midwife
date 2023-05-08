import java.util.Stack;

/**
 * This class represent the current user of the app.
 * It contains important information the user has selected and store a stack
 * structure to capture the menus the user has visited.
 */

public class User {
    private String id;
    private String selectedDate;
    private Stack<Menu> visitStack=new Stack<>();

    /**
     * Constructor
     * Initialize the stack and push in the login menu
     */
    public User(){
        visitStack.push(LoginMenu.getInstance());
    }

    /**
     *
     * @return the topmost menu in the stack
     */
    public Menu getCurrentMenu(){
        return visitStack.peek();
    }

    /**
     * Clear the stack.
     */
    public void quitProgram(){
        visitStack.clear();
    }

    /**
     * Indicate if the user has log out
     * @return true if and only if the menu stack is empty
     */
    public boolean isQuit(){
        return visitStack.empty();
    };

    /**
     * When this function is called, it's means the user has entered the next menu.
     * @param m a Menu
     * @pre m!=null
     */
    public void addMenu(Menu m){
        assert m!=null;
        visitStack.push(m);
    }

    /**
     * This method will
     */
    public void backToPreMenu(){
        assert this.visitStack.peek()!=LoginMenu.getInstance();
        visitStack.pop();
    }

    public void setId(String id){this.id=id;};
    public String getId(){return id;};
    public void setSelectedDate(String date){selectedDate=date;};
    public String getSelectedDate(){return selectedDate;};


}
