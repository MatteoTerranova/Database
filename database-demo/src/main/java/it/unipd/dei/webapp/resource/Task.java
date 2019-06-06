package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;
import java.util.UUID;

/**
 * TimeSlot of the Ennedue Studio
 */
public class Task extends Resource {

	// TemplateID of the task
	private final String name;
	
	// Task UUID
	private final UUID uuidTask;
	
	// Description of the task
	private final String description;

	// Level of the node
	private final int level;
	
	// Creates new Task
	public Task(final String name, final UUID uuidTask,final String description, final int level){
		this.name = name;
		this.uuidTask = uuidTask;
		this.description = description;
		this.level = level;
	}
	
	public final UUID getTaskID(){
		return uuidTask;
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
		
		jg.writeStringField("taskuuid", uuidTask.toString());

		jg.writeStringField("name", name);
		
		jg.writeStringField("description", description);

		jg.writeNumberField("level", level);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}
