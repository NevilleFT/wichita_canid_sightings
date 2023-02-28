library(DBI)

# Establish a database connection ----
sighting_db <- dbConnect(RSQLite::SQLite(), "sighting_db.db")

class(sighting_db)

#  Sending queries to the DB ----
## dragons <- dbGetQuery(conn = sighting_db, statement = "SELECT * FROM dragons;")

#Modifying the database ----

dbExecute(sighting_db, "CREATE TABLE species (
          species varchar(10) PRIMARY KEY CHECK (species IN ('Coyote', 'Red Fox', 'Bobcat', 'Other')),
          species_latin varchar(10) CHECK (species_latin IN ('latrans', 'vulpes', 'rufus')),
          genus_latin varchar(10) CHECK (genus_latin IN ('Canis', 'Vulpes', 'Lynx')),
          family_latin varchar(10) CHECK (family_latin IN ('Canidae', 'Felidae'))
          );")

dbExecute(sighting_db, "CREATE TABLE zip_code (
          zip_code integer(5) PRIMARY KEY,
          avg_income double,
          building_density double,
          proportion_white double
          );")

dbExecute(sighting_db, "CREATE TABLE date (
          date text PRIMARY KEY,
          temp_in_ICT float,
          precip_in_ICT float
          );")

dbExecute(sighting_db, "CREATE TABLE sighting_reports (
          sighting_id integer PRIMARY KEY AUTOINCREMENT,
          species varchar(10) CHECK (species IN ('Coyote', 'Red Fox', 'Bobcat', 'Other')),
          utm_x float,
          utm_y float,
          date text,
          time text,
          action varchar(10),
          habitat varchar(10),
          count varchar(10),
          offspring varchar(100),
          feeling varchar(100),
          zip_code integer(5),
          FOREIGN KEY (date) REFERENCES date(date)
          FOREIGN KEY (species) REFERENCES species(species)
          FOREIGN KEY (zip_code) REFERENCES zip_code(zip_code)
          );")
