package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.Document;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public final class CreateDocumentDatabase {

	
	private static final String STATEMENT = "INSERT INTO Document (DocumentID, Title, Content, CurTime, TaskID, Producer) VALUES (?, ?, ?, ?, ?, ?)";

	
	//private final Connection con;

	
	//private final Document document;

	
	/*public CreateDocumentDatabase(final Connection con, final Document document) {
		this.con = con;
		this.document = document;
	}

	
	public Employee createDocument() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// the create employee
		Employee e = null;

		try {
			pstmt = con.prepareStatement(STATEMENT);
			pstmt.setInt(1, employee.getBadge());
			pstmt.setString(2, employee.getSurname());
			pstmt.setInt(3, employee.getAge());
			pstmt.setInt(4, employee.getSalary());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				e = new Employee(rs.getInt("badge"), rs
						.getString("surname"), rs.getInt("age"),
						rs.getInt("salary"));
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

		return e;
	}*/
}