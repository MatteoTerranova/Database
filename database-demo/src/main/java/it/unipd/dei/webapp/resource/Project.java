package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * TimeSlot of the Ennedue Studio
 */
public class Project extends Resource {

	// Project title
	private final String title;

	// Start date of the project
	private final String startDate;
	
	// End date of the project
	private final String endDate;

	// Location of the project
	private final String location;
	
	// Deadline of the project
	private final String deadline;
	
	// Estimated hours to complete the project
	private final int estimatedHours;
	
	// Totala amount of hours spent on the project
	private final double hoursSpent;
	
	// Creates new Project
	public Project(final String title, final String startDate, final String endDate, final String location, final String deadline, final int estimatedHours, final double hoursSpent){
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.location = location;
		this.deadline = deadline;
		this.estimatedHours = estimatedHours;
		this.hoursSpent = hoursSpent;
	}


	public final String getTitle() {
		return title;
	}

	
	public final String getStartDate() {
		return startDate;
	}
	
	public final String getEndDate() {
		return endDate;
	}
	
	public final String getLocation() {
		return location;
	}
	
	public final String getDeadline() {
		return deadline;
	}
	
	public final int getEstimatedHours() {
		return estimatedHours;
	}
	
	public final double getHoursSpent() {
		return hoursSpent;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("project");

		jg.writeStartObject();

		jg.writeStringField("title", title);

		jg.writeStringField("startdate", startDate);
		
		jg.writeStringField("enddate", endDate);

		jg.writeStringField("location", location);
		
		jg.writeStringField("deadline", deadline);
		
		jg.writeNumberField("estimatedhours", estimatedHours);
		
		jg.writeNumberField("hoursspent", hoursSpent);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}
