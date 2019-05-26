import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This method prints all the Tasks associated to a Job
 * 
 * @author Alessandro Cattapan
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
	 * The password for accessing the database, initialized during runtime
	 */
	private String PASSWORD;
	
	/**
	 * The SQL statement to be executed
	 */
	private static final String SQL = "SELECT name, surname, title FROM Customer AS Cu INNER JOIN Contact AS Co ON Cu.FiscalCode = Co.FiscalCode INNER JOIN Request AS R ON Cu.FiscalCode = R.FiscalCode INNER JOIN Project as P ON R.ProjectID = P.ProjectID;";


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
			System.out.println("ERROR: Insert a password in the input.");
			System.exit(-1);
		}
		
		// The connection to the DBMS
		Connection con = null;

		// The statement to be executed
		Statement stmt = null;

		// The results of the statement execution
		ResultSet rs = null;
		
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
		
		
		try {
			// register the JDBC driver
			Class.forName(DRIVER);

			System.out.printf("Driver %s successfully registered.%n", DRIVER);
		} catch (ClassNotFoundException e) {
			System.out.printf(
					"Driver %s not found: %s.%n", DRIVER, e.getMessage());

			// terminate with a generic error code
			System.exit(-1);
		}

		try {

			// connect to the database
			start = System.currentTimeMillis();			
			
			con = DriverManager.getConnection(DATABASE, USER, PASSWORD);								
			
			end = System.currentTimeMillis();

			System.out.printf(
					"Connection to database %s successfully established in %,d milliseconds.%n",
					DATABASE, end-start);

			// create the statement to execute the query
			start = System.currentTimeMillis();

			stmt = con.createStatement();

			end = System.currentTimeMillis();

			System.out.printf(
					"Statement successfully created in %,d milliseconds.%n",
					end-start);

			// execute the query
			start = System.currentTimeMillis();

			rs = stmt.executeQuery(SQL);

			end = System.currentTimeMillis();

			System.out
					.printf("Query %s successfully executed %,d milliseconds.%n",
							SQL, end - start);

			System.out
					.printf("Query results:%n");

			// cycle on the query results and print them
			while (rs.next()) {

				// read visit identifier
				visitId = rs.getString("visitId");

				// read the diagnosis
				diagnosis = rs.getString("diagnosis");

				// read the date scheduled for the visit
				date = rs.getString("date");

				System.out.printf("- %s, %s, %s%n", 
						visitId, diagnosis, date);

			}
		} catch (SQLException e) {
			System.out.printf("Database access error:%n");

			// cycle in the exception chain
			while (e != null) {
				System.out.printf("- Message: %s%n", e.getMessage());
				System.out.printf("- SQL status code: %s%n", e.getSQLState());
				System.out.printf("- SQL error code: %s%n", e.getErrorCode());
				System.out.printf("%n");
				e = e.getNextException();
			}
		} finally {
			try { 
				
				// close the used resources
				if (rs != null) {
					
					start = System.currentTimeMillis();
					
					rs.close();
					
					end = System.currentTimeMillis();
					
					System.out
					.printf("Result set successfully closed in %,d milliseconds.%n",
							end-start);
				}
				
				if (stmt != null) {
					
					start = System.currentTimeMillis();
					
					stmt.close();
					
					end = System.currentTimeMillis();
					
					System.out
					.printf("Statement successfully closed in %,d milliseconds.%n",
							end-start);
				}
				
				if (con != null) {
					
					start = System.currentTimeMillis();
					
					con.close();
					
					end = System.currentTimeMillis();
					
					System.out
					.printf("Connection successfully closed in %,d milliseconds.%n",
							end-start);
				}
				
				System.out.printf("Resources successfully released.%n");
				
			} catch (SQLException e) {
				System.out.printf("Error while releasing resources:%n");

				// cycle in the exception chain
				while (e != null) {
					System.out.printf("- Message: %s%n", e.getMessage());
					System.out.printf("- SQL status code: %s%n", e.getSQLState());
					System.out.printf("- SQL error code: %s%n", e.getErrorCode());
					System.out.printf("%n");
					e = e.getNextException();
				}

			} finally {

				// release resources to the garbage collector
				rs = null;
				stmt = null;
				con = null;

				System.out.printf("Resources released to the garbage collector.%n");
			}
		}
		
		System.out.printf("Program end.%n");
		
	}
}
