package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Searches timeslots by employees' fiscal code.
*/
public final class SearchTimeSlotByFiscalCodeDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "SELECT Hours, HourlyWage, Notes, CurTime, Title, TemplateID FROM TimeSlot AS S INNER JOIN TASK AS T ON S.TaskID = T.TaskID INNER JOIN Compose AS C ON T.TaskID = C.Child INNER JOIN Project ON C.ProjectID = Project.ProjectID WHERE FiscalCode = ? ORDER BY CurTime ASC";

	/**
	 * The connection to the database
	 */
	private final Connection con;

	/**
	 * The fiscal code of the employee
	 */
	private final String fiscalCode;

	/**
	 * Creates a new object for searching timeslots by employees' fiscal code.
	 */
	public SearchTimeSlotByFiscalCodeDatabase(final Connection con, final String fiscalCode) {
		this.con = con;
		this.fiscalCode = fiscalCode;
	}

	/**
	 * Searches timeslots by employees' fiscalcode.
	 */
	public List<TimeSlot> searchTimeSlotByFiscalCode() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// the results of the search
		final List<TimeSlot> timeslots = new ArrayList<>();

		try {
			pstmt = con.prepareStatement(STATEMENT);
			pstmt.setString(1, fiscalCode);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				timeslots.add(new TimeSlot(rs.getString("Title"), 
						rs.getString("TemplteID"), rs.getString("CurTime"),
						rs.getString("Notes"), rs.getDouble("HourlyWage"),
						rs.getDouble("Hours")));
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

		return timeslots;
	}
}
