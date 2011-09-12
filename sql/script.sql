SET search_path TO library;

CREATE SEQUENCE seq_groups_id START 5;

CREATE TABLE groups (
  group_id integer DEFAULT NEXTVAL('seq_groups_id'),
  title varchar(100)
) tablespace librarydata;

ALTER TABLE groups
  ADD CONSTRAINT nn_groups_groupid CHECK(group_id IS NOT NULL);
ALTER TABLE groups
  ADD CONSTRAINT nn_groups_title CHECK(title IS NOT NULL);

ALTER TABLE groups
  ADD CONSTRAINT uq_groups_title UNIQUE(title) USING INDEX tablespace libraryindex;

ALTER TABLE groups
  ADD CONSTRAINT pk_groups_groupid PRIMARY KEY(group_id) USING INDEX tablespace libraryindex;



COMMENT ON TABLE groups IS 'Tabla que guarda los grupos de los usuarios';
COMMENT ON COLUMN groups.group_id IS 'Primary Key tabla usergroups';
COMMENT ON COLUMN groups.title IS 'Título del grupo';

INSERT INTO groups (group_id,title) VALUES (1,'Administrador');
INSERT INTO groups (group_id,title) VALUES (2,'Publicista');
INSERT INTO groups (group_id,title) VALUES (3,'Editor');
INSERT INTO groups (group_id,title) VALUES (4,'Usuario');

CREATE SEQUENCE seq_users_id;

CREATE TABLE users (
  user_id integer DEFAULT NEXTVAL('seq_users_id'),
  name varchar(255),
  email varchar(100),
  password varchar(100),
  group_id integer DEFAULT 4,
  avatar varchar(20),
  register timestamp without time zone DEFAULT now(),
  lastvisit timestamp without time zone DEFAULT now()
) tablespace librarydata;

ALTER TABLE users 
  ADD CONSTRAINT nn_users_userid CHECK(user_id IS NOT NULL);
ALTER TABLE users 
  ADD CONSTRAINT nn_users_name CHECK(name IS NOT NULL);
ALTER TABLE users 
  ADD CONSTRAINT nn_users_email CHECK(email IS NOT NULL);
ALTER TABLE users 
  ADD CONSTRAINT nn_users_password CHECK(password IS NOT NULL);
ALTER TABLE users 
  ADD CONSTRAINT nn_users_groupid CHECK(group_id IS NOT NULL);
ALTER TABLE users 
  ADD CONSTRAINT nn_users_register  CHECK(register IS NOT NULL);
ALTER TABLE users 
  ADD  CONSTRAINT nn_users_lastvisit CHECK(lastvisit IS NOT NULL);

ALTER TABLE users 
  ADD CONSTRAINT uq_users_email UNIQUE(email) USING INDEX tablespace libraryindex;

ALTER TABLE users 
  ADD CONSTRAINT fk_users_groups FOREIGN KEY(group_id) REFERENCES groups(group_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE users
  ADD CONSTRAINT pk_users_userid PRIMARY KEY(user_id) USING INDEX tablespace libraryindex;
  

COMMENT ON TABLE users IS 'Tabla que guarda los usuarios';
COMMENT ON COLUMN users.user_id IS 'Primary Key tabla users';
COMMENT ON COLUMN users.name IS 'Nombre del usuario';
COMMENT ON COLUMN users.email IS 'Correo electronico del usuario';
COMMENT ON COLUMN users.password IS 'Contraseña encriptada del usuario';
COMMENT ON COLUMN users.register IS 'Fecha de registro';
COMMENT ON COLUMN users.lastvisit IS 'Fecha de ultima visita';
COMMENT ON COLUMN users.avatar IS 'Imagen del usuario';


--Clave serverkaos
INSERT INTO users (name,email,password,group_id) VALUES ('Juan Pinilla','dark@shamain.com.ar','1578D9C4C6892218A1943DB9320B0075',1);

CREATE SEQUENCE seq_books_id;

CREATE TABLE books (
  book_id integer DEFAULT NEXTVAL('seq_books_id'),
  title varchar(100),
  author varchar(100),
  description text,
  isbn varchar(100),
  editorial varchar(30),
  pages integer,
  url numeric(20)
) tablespace librarydata;


ALTER TABLE books 
  ADD CONSTRAINT nn_books_bookid CHECK(book_id IS NOT NULL);
ALTER TABLE books 
  ADD CONSTRAINT nn_books_title CHECK(title IS NOT NULL);
ALTER TABLE books 
  ADD CONSTRAINT nn_books_author CHECK(author IS NOT NULL);
ALTER TABLE books 
  ADD CONSTRAINT nn_books_description CHECK(description IS NOT NULL);
ALTER TABLE books 
  ADD CONSTRAINT nn_books_isbn CHECK(isbn IS NOT NULL);
ALTER TABLE books 
  ADD CONSTRAINT nn_books_editorial CHECK(editorial IS NOT NULL);
ALTER TABLE books 
  ADD CONSTRAINT nn_books_pages  CHECK(pages IS NOT NULL);
ALTER TABLE books 
  ADD  CONSTRAINT nn_books_url CHECK(url IS NOT NULL);

ALTER TABLE books
  ADD CONSTRAINT uq_books_isbn UNIQUE(isbn) USING INDEX tablespace libraryindex;

ALTER TABLE books
  ADD CONSTRAINT pk_books_bookid PRIMARY KEY(book_id) USING INDEX tablespace libraryindex;
  

COMMENT ON TABLE books IS 'Tabla que guarda los libros';
COMMENT ON COLUMN books.book_id IS 'Primary Key tabla books';
COMMENT ON COLUMN books.title IS 'Nombre del libro';
COMMENT ON COLUMN books.author IS 'Nombre del autor del libro';
COMMENT ON COLUMN books.description IS 'Pequeña descripcion del libro';
COMMENT ON COLUMN books.isbn IS 'ISBN del libro';
COMMENT ON COLUMN books.editorial IS 'Fecha de ultima visita';
COMMENT ON COLUMN books.pages IS 'Cantidad de paginas de libro';
COMMENT ON COLUMN books.url IS 'Direccion del libro';

CREATE SEQUENCE seq_booksections_id;

CREATE TABLE booksections (
  booksection_id integer DEFAULT NEXTVAL('seq_booksections_id'),
  book_id integer,
  title varchar(100),
  page integer
) tablespace librarydata;

ALTER TABLE booksections
 ADD CONSTRAINT nn_booksections_booksectionid CHECK(booksection_id IS NOT NULL);
ALTER TABLE booksections
 ADD CONSTRAINT nn_booksections_bookid CHECK(book_id IS NOT NULL);
ALTER TABLE booksections
 ADD CONSTRAINT nn_booksections_title CHECK(title IS NOT NULL);
ALTER TABLE booksections
 ADD CONSTRAINT nn_booksections_page CHECK(page IS NOT NULL);

ALTER TABLE booksections
  ADD CONSTRAINT uq_booksections_bookidpage UNIQUE(book_id, page) USING INDEX tablespace libraryindex;

ALTER TABLE booksections 
  ADD CONSTRAINT fk_booksections_books FOREIGN KEY(book_id) REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE booksections
  ADD CONSTRAINT pk_booksections_booksectionid PRIMARY KEY(booksection_id) USING INDEX tablespace libraryindex;

COMMENT ON TABLE booksections IS 'Tabla que guarda los capitulos de los libros';
COMMENT ON COLUMN booksections.booksection_id IS 'Primary Key tabla booksections';
COMMENT ON COLUMN booksections.book_id IS 'Referencia al libro al que pertence';
COMMENT ON COLUMN booksections.title IS 'Título del capitulo';
COMMENT ON COLUMN booksections.page IS 'Pagina del capitulo';

CREATE SEQUENCE seq_usersbooks_id;

CREATE TABLE  users_books (
  usersbooks_id integer DEFAULT NEXTVAL('seq_usersbooks_id'),
  user_id integer,
  book_id integer,
  boughtdate timestamp without time zone DEFAULT now(),
  lastvisit timestamp without time zone DEFAULT now()
) tablespace librarydata;


ALTER TABLE users_books 
  ADD CONSTRAINT nn_usersbooks_usersbooksid CHECK(usersbooks_id IS NOT NULL);
ALTER TABLE users_books
  ADD CONSTRAINT nn_usersbooks_userid CHECK(user_id IS NOT NULL);
ALTER TABLE users_books
  ADD CONSTRAINT nn_usersbooks_bookid CHECK(book_id IS NOT NULL);
ALTER TABLE users_books
  ADD CONSTRAINT nn_usersbooks_bougthdate CHECK(bougthdate IS NOT NULL);
ALTER TABLE users_books
  ADD CONSTRAINT nn_usersbooks_lastvisit CHECK(lastvisit IS NOT NULL);

ALTER TABLE users_books  
  ADD CONSTRAINT fk_usersbooks_users FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE NO ACTION;
ALTER TABLE users_books  
  ADD CONSTRAINT fk_usersbooks_books FOREIGN KEY(book_id) REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE users_books
  ADD CONSTRAINT uq_usersbooks_usersbooks UNIQUE(user_id, book_id) USING INDEX tablespace libraryindex;

ALTER TABLE users_books
  ADD CONSTRAINT pk_usersbooks_usersbooksid PRIMARY KEY(usersbooks_id) USING INDEX tablespace libraryindex;


COMMENT ON TABLE users_books IS 'Tabla que guarda los libros de los usuarios';
COMMENT ON COLUMN users_books.usersbooks_id IS 'Primary Key tabla usersbooks';
COMMENT ON COLUMN users_books.user_id IS 'Llave foranea de la tabla users';
COMMENT ON COLUMN users_books.book_id IS 'Llave foranea de la tabla books';
COMMENT ON COLUMN users_books.boughtdate IS 'Fecha de compra del libro';
COMMENT ON COLUMN users_books.lastvisit IS 'Fecha de la ultima visita al libro';

CREATE SEQUENCE seq_notes_id;

CREATE TABLE notes (
  note_id integer DEFAULT NEXTVAL('seq_notes_id'),
  title varchar(100),
  page integer,
  access varchar(10) DEFAULT 'public',
  location varchar(30),
  content text,
  usersbooks_id integer,
  lastmodified timestamp without time zone DEFAULT now()
) tablespace librarydata;


ALTER TABLE notes
  ADD CONSTRAINT nn_notes_noteid CHECK(note_id IS NOT NULL);
ALTER TABLE notes
  ADD CONSTRAINT nn_notes_title CHECK(title IS NOT NULL);
ALTER TABLE notes
  ADD CONSTRAINT nn_notes_note CHECK(note IS NOT NULL);
ALTER TABLE notes
  ADD CONSTRAINT nn_notes_usersbooksid CHECK(users_books_id IS NOT NULL);
ALTER TABLE notes
  ADD CONSTRAINT nn_notes_lastmodified CHECK(lastmodified IS NOT NULL);

ALTER TABLE notes 
  ADD CONSTRAINT fk_notes_usersbooks FOREIGN KEY(usersbooks_id) REFERENCES users_books(usersbooks_id) ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE notes
  ADD CONSTRAINT pk_notes_noteid PRIMARY KEY(note_id) USING INDEX tablespace libraryindex;


COMMENT ON TABLE notes IS 'Tabla que guarda las notas de los libros del usuario';
COMMENT ON COLUMN notes.note_id IS 'Primary Key tabla notes';
COMMENT ON COLUMN notes.title IS 'Título de la nota';
COMMENT ON COLUMN notes.note IS 'Nota del usuario';
COMMENT ON COLUMN notes.usersbooks_id IS 'Llave foranea de la tabla users_books';
COMMENT ON COLUMN notes.lastmodified IS 'Fecha de la ultima modificiacion a la nota';


INSERT INTO books(title,author,description,isbn, editorial,pages,url) VALUES('Guía de aprendizaje de Python','Guido van Rossum','Test descripcion','--','--',77,'000001');

/*INSERT INTO books(title,author,description,isbn, editorial,pages,url) VALUES('RMAN Recipes for Oracle Database 11g','Tammy FoxDarl Kuhn, Sam Alapati, Arup Nanda','Test descripcion','978-1-59059-851-1','Apress',704,'000003');

INSERT INTO books(title,author,description,isbn, editorial,pages,url) VALUES('Embedded Linux System Design and Development','P. Raghavan, Amol Lad, Sriram Neelakandan','Test descripcion','978-0-8493-4058-1','Auerbach Publications',429,'000004');

INSERT INTO books(title,author,description,isbn, editorial,pages,url) VALUES('Expert Oracle Database 11g Administration','Sam R. Alapati','Test descripcion','978-1-4302-1016-0','Apress',1376,'000005');

INSERT INTO books(title,author,description,isbn, editorial,pages,url) VALUES('Oracle Database 11g DBA Handbook','Bob Bryla, Kevin Loney','Test descripcion','0-07-149663-7','Oracle press',698,'000006');
*/
