package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.*;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


public final class CreateTimeSlotDatabase {

	
	private static final String STATEMENT = "INSERT INTO TimeSlot (TimeSlotID, TaskID, CurTime, FiscalCode, Notes, Hours, HourlyWage) VALUES (?::UUID, ?::UUID, ?::TIMESTAMP, ?, ?, ?, ?) RETURNING *";

	private final Connection con;

	private final TimeSlot timeslot;

	
	public CreateTimeSlotDatabase(final Connection con, final TimeSlot ts) {
		this.con = con;
		this.timeslot = ts;
	}

	
	public TimeSlot createTimeSlot() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// Create TimeSlot
		TimeSlot ts = null;

		try {
			
			pstmt = con.prepareStatement(STATEMENT);
			
			UUID uuid = UUID.randomUUID();
			
			pstmt.setObject(1, uuid);
			pstmt.setObject(2, UUID.fromString(timeslot.getTaskUUID()));
			pstmt.setString(3, timeslot.getTimestamp());
			pstmt.setString(4, timeslot.getFiscalCode());
			pstmt.setString(5, timeslot.getNote());
			pstmt.setDouble(6, timeslot.getNumHours());
			pstmt.setDouble(7, timeslot.getHourlyWage());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				ts = new TimeSlot(rs.getDouble("Hours"), 
						rs.getString("TaskID"), rs.getString("CurTime"),
						rs.getString("FiscalCode"), rs.getString("Notes"),
						rs.getDouble("HourlyWage"));
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

		return ts;
	}
}