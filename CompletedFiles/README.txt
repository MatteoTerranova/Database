# INSTRUCTIONS (Windows Prompt)
## SQL commands
`psql -U postgres < db_creation.sql`
`psql -U postgres < db_trigger.sql`
`psql -U postgres < db_population.sql`
`psql -U postgres < stored_procedure.sql`
`psql -U postgres < query.sql`

## JAVA code
`javac -cp .;postgresql-9.4-1201.jdbc4.jar PrintProjects.java`
`java -cp .;postgresql-9.4-1201.jdbc4.jar PrintProjects password`