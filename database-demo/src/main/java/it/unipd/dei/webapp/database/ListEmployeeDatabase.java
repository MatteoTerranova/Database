package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.Employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Lists all the employees in the database.
 */
public final class ListEmployeeDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "SELECT E.FiscalCode, Name, Surname, IBAN, HourlyWage, Role FROM Employee AS E INNER JOIN Contact AS C ON E.FiscalCode = C.FiscalCode";

	/**
	 * The connection to the database
	 */
	private final Connection con;

	/**
	 * Creates a new object for listing all the employees.
	 */
	public ListEmployeeDatabase(final Connection con) {
		this.con = con;
	}

	/**
	 * Lists all the employees in the database.
	 */
	public List<Employee> listEmployee() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// The results of the search
		final List<Employee> employees = new ArrayList<>();

		try {
			pstmt = con.prepareStatement(STATEMENT);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				employees.add(new Employee(rs.getString("FiscalCode"), 
						rs.getString("Name"), rs.getString("Surname"),
						rs.getString("IBAN"), rs.getDouble("HourlyWage"),
						rs.getString("Role")));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}

			if (pstmt != null) {
				pstmt.close();
			}

			con.close();
		}

		return employees;
	}
}
