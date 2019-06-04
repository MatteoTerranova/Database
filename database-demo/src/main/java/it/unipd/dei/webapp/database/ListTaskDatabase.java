package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Lists all the projects in the database.
 */
public final class ListTaskDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "WITH RECURSIVE proj_subpart AS (SELECT Parent, Child, ProjectID, 1 AS Depth FROM Task as t INNER JOIN Compose AS C  ON t.taskID = C.Child WHERE isRoot = TRUE UNION ALL SELECT C.Parent, C.Child, C.ProjectID, Depth + 1 FROM proj_subpart AS pr INNER JOIN Compose AS C ON C.Parent = pr.Child) SELECT p.ProjectID AS Project_Name, tmt.TemplateID AS Task_Description, Depth, tmt.Description AS General_task_description FROM Project AS p INNER JOIN proj_subpart AS ps ON p.ProjectID = ps.ProjectID INNER JOIN Task AS t ON ps.Child = t.taskID INNER JOIN Template AS tmt ON t.TemplateID = tmt.TemplateID WHERE p.ProjectID = ? AND depth < 3 ORDER BY p.ProjectID, Depth ASC";

	/**
	 * The connection to the database
	 */
	private final Connection con;
	
	/**
	 * The uuid of the project to search
	 */
	private final String uuid;

	/**
	 * Creates a new object for listing all the projetcs.
	 */
	public ListTaskDatabase(final Connection con, final String uuid) {
		this.con = con;
		this.uuid = uuid;
	}

	/**
	 * Lists all the projects in the database.
	 */
	public List<Task> listTask() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// The results of the search
		final List<Task> tasks = new ArrayList<>();
		
		try {
			
			UUID id = UUID.fromString(uuid);
			
			pstmt = con.prepareStatement(STATEMENT);
			pstmt.setObject(1, id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				tasks.add(new Task( 
						rs.getString("task_description"), rs.getString("general_task_description"),
						rs.getInt("Depth")));
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

		return tasks;
	}
}
