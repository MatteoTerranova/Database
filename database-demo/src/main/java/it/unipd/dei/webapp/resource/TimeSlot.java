package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * TimeSlot of the Ennedue Studio
 */
public class TimeSlot extends Resource {

	// Project associated to the TimeSlot
	private final String projectTitle;

	// TemplateID associate to the TimeSlot
	private final String templateID;

	// TimeStamp of the TimeSlot
	private final String timestamp;
	
	// Note on the TimeSlot
	private final String note;
	
	// Hourly wage of the TimeSlot
	private final double hourlyWage;
	
	// Number of hours reported in the TimeSlot
	private final double numHours;
	
	// Creates new TimeSlot
	public TimeSlot(final String projectTitle, final String templateID, final String timestamp, final String note, final double hourlyWage, final double numHours){
		this.projectTitle = projectTitle;
		this.templateID = templateID;
		this.timestamp = timestamp;
		this.note = note;
		this.hourlyWage = hourlyWage;
		this.numHours = numHours;
	}


	public final String getProjectTitle() {
		return projectTitle;
	}

	
	public final String getTemplateID() {
		return templateID;
	}
	
	public final String getTimestamp() {
		return timestamp;
	}
	
	public final String getNote() {
		return note;
	}
	
	public final double getHourlyWage() {
		return hourlyWage;
	}
	
	public final double getNumHours() {
		return numHours;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("timeslot");

		jg.writeStartObject();

		jg.writeStringField("title", projectTitle);

		jg.writeStringField("template", templateID);
		
		jg.writeStringField("timestamp", timestamp);

		jg.writeStringField("note", note);
		
		jg.writeNumberField("hourlywage", hourlyWage);
		
		jg.writeNumberField("hours", numHours);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}
