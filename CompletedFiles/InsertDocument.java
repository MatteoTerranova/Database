import java.io.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.UUID;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Reads data inside a file to be inserted to the database
 * 
 * @author Winniest Team
 * @version 1.00
 */
public class InsertDocument {

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
	 * The default input file for reading the data
	 */
	private static final String DEFAULT_INPUT_FILE = "data.txt";
	
	/**
	 * The SQL statement for inserting/retrieving data into/from the Document table.
	 */
	private static final String INSERT_DOCUMENT = "INSERT INTO Document (DocumentID, Title, Content, CurTime, TaskID, Producer) VALUES (?, ?, ?, ?, ?, ?)";
	private static final String RETRIEVE = "SELECT Content, Title FROM Document WHERE DocumentID = '6fd2ef9f-3812-4317-914b-b4bb5b685686'";


	/**
	 * The password for accessing the database, initialized during runtime
	 */
	private static String password;
	 
	/**
	 * List all the projects in the database with the customer that as demanded it
	 * 
	 * @param args
	 *            command-line arguments used for inserting the password and eventually the filepath to the file with all the data to be inserted.
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

		// The SQL statement to be executed
		PreparedStatement pstmt = null;
		Statement ret_stmt = null;

		// Start time of a statement
		long start;

		// End time of a statement
		long end;
		
		// The input file from which data are read
		Reader input = null;
		
		// A scanner for parsing the content of the input file
		Scanner s = null;
		
		// Current line number in the input file
		int l = 0;
		
		// The data about the document
		
		UUID id = null;
		String title = null;
		String filename = null;
		int len = 0;
		java.sql.Timestamp timeStamp = null;
		UUID taskID = null;
		String producer = null;
		
		// The results of the statement execution
		ResultSet result = null;


		try {
			// Register the JDBC driver
			Class.forName(DRIVER);

			System.out.printf("Driver %s successfully registered.%n", DRIVER);
		} catch (ClassNotFoundException e) {
			System.out.printf(
					"Driver %s not found: %s.%n", DRIVER, e.getMessage());

			// Terminate with a generic error code
			System.exit(-1);
		}

		try {

			// Connect to the database
			start = System.currentTimeMillis();			
			
			con = DriverManager.getConnection(DATABASE, USER, password);								
			
			end = System.currentTimeMillis();

			System.out.printf(
					"Connection to database %s successfully established in %,d milliseconds.%n",
					DATABASE, end-start);

			// Create the statements for inserting the data
			start = System.currentTimeMillis();
			
			pstmt = con.prepareStatement(INSERT_DOCUMENT);

			
			end = System.currentTimeMillis();
			
			System.out.printf(
					"Statements successfully created in %,d milliseconds.%n",
					end-start);

		} catch (SQLException e) {
			System.out.printf("Connection error:%n");

			// Get all the exceptions
			while (e != null) {
				System.out.printf("Message: %s%n", e.getMessage());
				System.out.printf("SQL status code: %s%n", e.getSQLState());
				System.out.printf("SQL error code: %s%n", e.getErrorCode());
				System.out.printf("%n");
				e = e.getNextException();
			}
			
			// Terminate with a generic error code
			System.exit(-1);
		}

		// If there are no input arguments, use the default input file
		if (args.length <= 1) {

			// get the class loader
			ClassLoader cl = InsertDocument.class.getClassLoader();
			if (cl == null) {
				cl = ClassLoader.getSystemClassLoader();
			}

			// Get the stream for reading the configuration file
			InputStream is = cl.getResourceAsStream(DEFAULT_INPUT_FILE);

			if (is == null) {
				System.out.printf("Input file %s not found.%n", DEFAULT_INPUT_FILE);
				
				// Terminate with a generic error code
				System.exit(-1);
			}
			
			input = new BufferedReader(new InputStreamReader(is));
			
			System.out.printf("Input file %s successfully opened.%n", DEFAULT_INPUT_FILE);
			
		} else {
			
			try {
				input = new BufferedReader(new FileReader(args[1]));
				
				System.out.printf("Input file %s successfully opened.%n", args[1]);
			} catch (IOException ioe) {
				System.out.printf(
						"Impossible to read input file %s: %s%n", args[1],
						ioe.getMessage());
				
				// Terminate with a generic error code
				System.exit(-1);
			}
		}

		// Create the input file parser
		s = new Scanner(input);

		// Set the delimiter for the fields in the input file
		s.useDelimiter("##");
	
		try {
			
			// While the are lines to be read from the input file
			while (s.hasNext()) {
				
				// Increment the line number counter
				l++;
				
				System.out.printf("%n--------------------------------------------------------%n");
				
				// Read one line from the input file
				start = System.currentTimeMillis();
				
				// Create the arrays for containing document data  
				id = UUID.fromString(s.next());
				title = s.next();
				filename = s.next();
				java.util.Date today = new java.util.Date();
				timeStamp = new java.sql.Timestamp(today.getTime());
				taskID = UUID.fromString(s.next());
				producer = s.next();

				// Go to the next line
				s.nextLine();
				
				end = System.currentTimeMillis();
				
				System.out.printf(
						"Line %,d successfully read in %,d milliseconds.%n",
						l, end-start);
				
				// Insert one line from the input file into the database
				start = System.currentTimeMillis();
				
				// Insert the document
				try {
					File file = new File(filename);
            		FileInputStream fis = new FileInputStream(file);
            		len = (int)file.length();
					pstmt.setObject(1, id);
					pstmt.setString(2, title);
					pstmt.setBinaryStream(3, fis, len);
					pstmt.setTimestamp(4, timeStamp);
					pstmt.setObject(5, taskID);
					pstmt.setString(6, producer);
					pstmt.execute();

				} catch (SQLException e) {

					if (e.getSQLState().equals("23505")) {
						System.out
								.printf("Document %s already inserted, skip it. [%s]%n",
										title,
										e.getMessage());
					} else {
						System.out
								.printf("Unrecoverable error while inserting document %s:%n",
										title);
						System.out.printf("Message: %s%n", e.getMessage());
						System.out.printf("SQL status code: %s%n", e.getSQLState());
						System.out.printf("SQL error code: %s%n", e.getErrorCode());
						System.out.printf("%n");
					}
				} catch (IOException e) {

					System.out.println("Exception while streaming the file to the database");
				}
				
				end = System.currentTimeMillis();
				
				System.out.printf(
						"Line %,d successfully inserted into the database in %,d milliseconds.%n%n",
						l, end-start);

			}
		} finally {

			// Close the scanner and the input file
			s.close();

			System.out.printf("%nInput file successfully closed.%n");

			try {

				// Create the statement to execute the query and count the time
				start = System.currentTimeMillis();

				ret_stmt = con.createStatement();

				// Stop timing
				end = System.currentTimeMillis();

				System.out.printf(
					"Statement successfully created in %,d milliseconds.%n",
					end-start);

				// Execute the query
				start = System.currentTimeMillis();

				result = ret_stmt.executeQuery(RETRIEVE);

				end = System.currentTimeMillis();

				System.out.printf("Query: %n%s%nsuccessfully executed in %,d milliseconds.%n",
					RETRIEVE, end - start);

				byte[] fileBytes;
				String PDFName;

				try {

					result.next();
					fileBytes = result.getBytes("Content");
					PDFName = result.getString("Title");

					OutputStream targetFile=  new FileOutputStream(PDFName+".pdf");
		                targetFile.write(fileBytes);
		                targetFile.close();

                	System.out.println("Document successfully retrieved");

	            } catch (Exception e) {
	            	e.printStackTrace();
	       		}
       		} catch (Exception e) {
				e.printStackTrace();
			}	

			try {

				// Close the statements
				if (pstmt != null) {						
					
					start = System.currentTimeMillis();
						
					pstmt.close();
					
					
					end = System.currentTimeMillis();

					System.out
						.printf("Prepared statements successfully closed in %,d milliseconds.%n",
								end-start);
				
				}

				// Close the connection to the database
				if(con != null) {
					
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

				// Get all the exceptions
				while (e != null) {
					System.out.printf("Message: %s%n", e.getMessage());
					System.out.printf("SQL status code: %s%n", e.getSQLState());
					System.out.printf("SQL error code: %s%n", e.getErrorCode());
					System.out.printf("%n");
					e = e.getNextException();
				}
			}

		}

	}
}