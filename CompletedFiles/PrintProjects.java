import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This method prints all the Tasks associated to a Job
 * 
 * @author Winniest Team
 * @version 1.00
 */
public class PrintProjects {
	
	/**
	 * The JDBC driver to be used
	 */
	private static final String DRIVER = "org.postgresql.Driver";
	
	/**
	 * The URL of the database to be accessed
	 */
	private static final String DATABASE = "jdbc:postgresql://localhost/ennedue";

	/**
	 * The username for accessing the database
	 */
	private static final String USER = "postgres";
	
	/**
	 * The SQL statement to be executed
	 */
	private static final String SQL = "SELECT name, surname, title, StartDate, EndDate, Location, Deadline, EstimatedHours, HoursSpent FROM Customer AS Cu INNER JOIN Contact AS Co ON Cu.FiscalCode = Co.FiscalCode INNER JOIN Request AS R ON Cu.FiscalCode = R.FiscalCode INNER JOIN Project as P ON R.ProjectID = P.ProjectID;";

	/**
	 * The password for accessing the database, initialized during runtime
	 */
	private static String password;

	/**
	 * List all the projects in the database with the customer that as demanded it
	 * 
	 * @param args
	 *            command-line arguments used for inserting the password.
	 */
	public static void main(String[] args) {
		
		// Retrive the password from the input
		if (args.length < 1){
			
			// Exit the program with a generic error
			System.out.printf("ERROR: Insert a password in the input.%n");
			System.exit(-1);
		}
		
		// Get the password from the input
		password = args[0];
		
		// The connection to the DBMS
		Connection con = null;

		// The statement to be executed
		Statement stmt = null;

		// The results of the statement execution
		ResultSet result = null;
		
		// Start time of a statement
		long start;

		// End time of a statement
		long end;

		// Variables for saving the result from the database
		// Data about the project
		String name = null;
		String surname = null;
		String title = null;
		String startDate = null;
		String endDate = null;
		String location = null;
		String deadline = null;
		int estimatedHours = -1;
		double hoursSpent = -1.0;
		
		// Register the JDBC driver
		try {
			
			Class.forName(DRIVER);

			System.out.printf("Driver %s successfully registered.%n", 
				DRIVER);
		} catch (ClassNotFoundException e) {
			System.out.printf("Driver %s not found: %s.%n", 
				DRIVER, e.getMessage());

			// Exit with an error code
			System.exit(-1);
		}
		
		// Connect to the database
		try {
			
			// Count the necessary time for the conection
			start = System.currentTimeMillis();			
			
			con = DriverManager.getConnection(DATABASE, USER, password);								
			
			// Stop timing
			end = System.currentTimeMillis();

			System.out.printf(
				"Connection to database %s successfully established in %,d milliseconds.%n",
				DATABASE, end-start);

			// Create the statement to execute the query and count the time
			start = System.currentTimeMillis();

			stmt = con.createStatement();

			// Stop timing
			end = System.currentTimeMillis();

			System.out.printf(
				"Statement successfully created in %,d milliseconds.%n",
				end-start);

			// Execute the query
			start = System.currentTimeMillis();

			result = stmt.executeQuery(SQL);

			end = System.currentTimeMillis();

			System.out.printf("Query: %n%s%nsuccessfully executed in %,d milliseconds.%n",
				SQL, end - start);

			System.out.printf("%nQUERY RESULT:%n");

			// Print all the result of the query
			while (result.next()) {

				// Read the customer's data
				name = result.getString("name");
				surname = result.getString("surname");
				
				// Read the project's data
				title = result.getString("title");
				startDate = result.getString("startDate");
				endDate = result.getString("endDate");
				location = result.getString("location");
				deadline = result.getString("deadline");
				estimatedHours = result.getInt("estimatedHours");
				hoursSpent = result.getDouble("hoursSpent");
		
				// Print result
				// EndDate can be null if the project is still in progress so we can have two different kind of responses
				if (endDate == null){
					// The project is still in progress
					System.out.printf("%nCustomer: %s %s %nTitle: %s, %s %nstarted on %s and still in progress%ndue on %s%nStatistics: %.2f / %d%n%n", 
						name, surname, title, location, startDate, deadline, hoursSpent, estimatedHours);
				} else {
					// The project is completed
					System.out.printf("%nCustomer: %s %s %nTitle: %s, %s %nstarted on %s and ended on %s%ndue on %s%nStatistics: %.2f / %d%n%n", 
						name, surname, title, location, startDate, endDate, deadline, hoursSpent, estimatedHours);
				}
			}
		} catch (SQLException e) {
			System.out.printf("ERROR: Database access error%n");
			printErrorMessages(e);
		} finally {
			
			// Close all the connection in the reverse order of their creation
			try { 
				
				// Close the used resources
				if (result != null) {
					
					// Count time
					start = System.currentTimeMillis();
					
					result.close();
					
					// Stop timing
					end = System.currentTimeMillis();
					
					System.out.printf("Result set successfully closed in %,d milliseconds.%n",
						end-start);
				}
				
				if (stmt != null) {
					
					// Count time
					start = System.currentTimeMillis();
					
					stmt.close();
					
					// Stop timing
					end = System.currentTimeMillis();
					
					System.out.printf("Statement successfully closed in %,d milliseconds.%n",
						end-start);
				}
				
				if (con != null) {
					
					// Count time
					start = System.currentTimeMillis();
					
					con.close();
					
					// Stop timing
					end = System.currentTimeMillis();
					
					System.out.printf("Connection successfully closed in %,d milliseconds.%n",
							end-start);
				}
				
				System.out.printf("All the resources successfully released.%n");
				
			} catch (SQLException e) {
				System.out.printf("Error while releasing resources:%n");
				printErrorMessages(e);

			} finally {

				// Release resources to the garbage collector
				result = null;
				stmt = null;
				con = null;

				System.out.printf("Resources released to the garbage collector.%n");
			}
		}
		
		System.out.printf("Program ended.%n");
		
	}
	
	private static void printErrorMessages(SQLException e){
		// Get all the errors
		while (e != null) {
			System.out.printf("Message: %s%n", e.getMessage());
			System.out.printf("SQL status code: %s%n", e.getSQLState());
			System.out.printf("SQL error code: %s%n", e.getErrorCode());
			System.out.printf("%n");
			e = e.getNextException();
		}
	}
}
