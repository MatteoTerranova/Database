/*
 * Copyright 2018 University of Padua, Italy
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.Employee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Deletes an employee from the database.
 * 
 * @author Nicola Ferro (ferro@dei.unipd.it)
 * @version 1.00
 * @since 1.00
 */
public final class DeleteEmployeeDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "DELETE FROM Ferro.Employee WHERE badge = ? RETURNING *";

	/**
	 * The connection to the database
	 */
	private final Connection con;

	/**
	 * The badge of the employee
	 */
	private final int badge;

	/**
	 * Creates a new object for deleting an employee.
	 * 
	 * @param con
	 *            the connection to the database.
	 * @param badge
	 *            the badge of the employee.
	 */
	public DeleteEmployeeDatabase(final Connection con, final int badge) {
		this.con = con;
		this.badge = badge;
	}

	/**
	 * Deletes an employee from the database.
	 * 
	 * @return the {@code Employee} object matching the badge.
	 * 
	 * @throws SQLException
	 *             if any error occurs while deleting the employee.
	 */
	public Employee deleteEmployee() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// the deleted employee
		Employee e = null;

		try {
			pstmt = con.prepareStatement(STATEMENT);
			pstmt.setInt(1, badge);

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
	}
}
