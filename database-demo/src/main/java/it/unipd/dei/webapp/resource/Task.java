package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * TimeSlot of the Ennedue Studio
 */
public class Task extends Resource {

	// Department of the task
	private final String department;

	// TemplateID of the task
	private final String name;
	
	// Description of the task
	private final String description;

	// Level of the node
	private final int level;
	
	// Creates new Task
	public Task(final String department, final String name, final String description, final int level){
		this.department = department;
		this.name = name;
		this.description = description;
		this.level = level;
	}


	public final String getDepartment() {
		return department;
	}

	
	public final String getName() {
		return name;
	}
	
	public final String getDescription() {
		return description;
	}
	
	public final int getLevel() {
		return level;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("task");

		jg.writeStartObject();

		jg.writeStringField("department", department);

		jg.writeStringField("name", name);
		
		jg.writeStringField("description", description);

		jg.writeNumberField("level", level);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}
