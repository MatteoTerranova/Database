package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Lists all the projects in the database.
 */
public final class ListProjectDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "SELECT ProjectID, Title, StartDate, EndDate, Location, Deadline, EstimatedHours, HoursSpent FROM Project ORDER BY Title ASC";

	/**
	 * The connection to the database
	 */
	private final Connection con;

	/**
	 * Creates a new object for listing all the projetcs.
	 */
	public ListProjectDatabase(final Connection con) {
		this.con = con;
	}

	/**
	 * Lists all the projects in the database.
	 */
	public List<Project> listProject() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// The results of the search
		final List<Project> projects = new ArrayList<>();

		try {
			pstmt = con.prepareStatement(STATEMENT);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				projects.add(new Project(
						rs.getString("ProjectID"), rs.getString("Title"), 
						rs.getString("StartDate"), rs.getString("EndDate"),
						rs.getString("Location"), rs.getString("Deadline"),
						rs.getInt("EstimatedHours"), rs.getDouble("HoursSpent")));
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

		return projects;
	}
}
