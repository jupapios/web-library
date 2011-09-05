SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET default_tablespace = 'librarydata';
SET default_with_oids = false;
SET search_path = library;

CREATE OR REPLACE FUNCTION dologin(IN i_user varchar, IN i_password varchar, OUT o_group integer, OUT o_user_id integer) RETURNS SETOF record AS
$$
DECLARE
BEGIN
    UPDATE users SET lastvisit=now() WHERE email=i_user AND password=i_password;
    RETURN QUERY SELECT DISTINCT group_id, user_id FROM users WHERE email=i_user AND password=i_password;
RETURN;
END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION dologin(IN i_user varchar, IN i_password varchar, OUT o_group integer, OUT o_user_id integer) OWNER TO lbadm;

CREATE OR REPLACE FUNCTION doregister(IN i_name varchar, IN i_user varchar, IN i_password varchar, OUT o_result integer) RETURNS INTEGER AS
$$
DECLARE
    cnt INTEGER:=0;
BEGIN
    SELECT count(*) INTO cnt FROM users WHERE email=i_user;
    IF cnt=1 THEN 
 	SELECT 0 INTO o_result;
    ELSIF cnt=0 THEN
	INSERT INTO users (name, email, password) VALUES (i_name, i_user, i_password);
	SELECT 1 INTO o_result;
    END IF;

RETURN;
END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION doregister(IN i_name varchar, IN i_user varchar, IN i_password varchar, OUT o_result integer) OWNER TO lbadm;

CREATE OR REPLACE FUNCTION getuser(IN i_user_id integer, OUT o_name varchar, OUT o_avatar varchar, OUT o_group varchar, OUT o_register timestamp, OUT o_lastvisit timestamp) RETURNS SETOF record AS
$$
DECLARE
BEGIN
    RETURN QUERY SELECT u.name, u.avatar, g.title, u.register, u.lastvisit FROM users u LEFT OUTER JOIN groups g USING(group_id) WHERE u.user_id=i_user_id;
RETURN;
END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION getuser(IN i_user_id integer, OUT o_name varchar, OUT o_avatar varchar, OUT o_group varchar, OUT o_register timestamp, OUT o_lastvisit timestamp) OWNER TO lbadm;




CREATE OR REPLACE FUNCTION getbooks(IN i_user_id integer, OUT o_usersbooks_id integer, OUT o_title varchar, OUT o_author varchar, OUT o_pages integer, OUT o_editorial varchar, OUT o_description text, OUT o_boughtdate timestamp, OUT o_lastvisit timestamp, OUT o_url varchar) RETURNS SETOF record AS
$$
DECLARE
BEGIN
    RETURN QUERY SELECT u.usersbooks_id, b.title, b.author, b.pages, b.editorial, b.description, u.boughtdate, u.lastvisit, b.url FROM users_books u LEFT OUTER JOIN books b USING(book_id) WHERE u.user_id=i_user_id;
RETURN;
END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION getbooks(IN i_user_id integer, OUT o_usersbooks_id integer, OUT o_title varchar, OUT o_author varchar, OUT o_pages integer, OUT o_editorial varchar, OUT o_description text, OUT o_boughtdate timestamp, OUT o_lastvisit timestamp, OUT o_url varchar) OWNER TO lbadm;


CREATE OR REPLACE FUNCTION getbook(IN i_usersbooks_id integer, OUT o_title varchar, OUT o_author varchar, OUT o_pages integer, OUT o_editorial varchar, OUT o_description text, OUT o_boughtdate timestamp, OUT o_lastvisit timestamp, OUT o_url varchar) RETURNS SETOF record AS
$$
DECLARE
BEGIN
    RETURN QUERY SELECT b.title, b.author, b.pages, b.editorial, b.description, u.boughtdate, u.lastvisit, b.url FROM users_books u LEFT OUTER JOIN books b USING(book_id) WHERE u.usersbooks_id=i_usersbooks_id;
RETURN;
END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION getbook(IN i_usersbooks_id integer, OUT o_title varchar, OUT o_author varchar, OUT o_pages integer, OUT o_editorial varchar, OUT o_description text, OUT o_boughtdate timestamp, OUT o_lastvisit timestamp, OUT o_url varchar) OWNER TO lbadm;


CREATE OR REPLACE FUNCTION getsections(IN i_usersbooks_id integer, OUT o_title varchar, OUT o_page integer) RETURNS SETOF record AS
$$
DECLARE
BEGIN
    RETURN QUERY SELECT b.title, b.author, b.pages, b.editorial, b.description, u.boughtdate, u.lastvisit, b.url FROM users_books u LEFT OUTER JOIN books b USING(book_id) WHERE u.usersbooks_id=i_usersbooks_id;
RETURN;
END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION getsections(IN i_usersbooks_id integer, OUT o_title varchar, OUT o_page integer) OWNER TO lbadm;


CREATE OR REPLACE FUNCTION createnote(IN i_usersbooks_id integer, IN i_content text, OUT o_note_id integer, OUT o_title varchar, OUT o_content text) RETURNS SETOF record AS
$$
DECLARE
BEGIN

INSERT INTO notes (usersbooks_id, title, content) VALUES (i_usersbooks_id, replace(substr(i_content, 1, 20),'<br>',' '), i_content);
RETURN QUERY SELECT note_id, title, content FROM notes WHERE usersbooks_id=i_usersbooks_id;

END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION createnote(IN i_usersbooks_id integer, IN i_content text, OUT o_note_id integer, OUT o_title varchar, OUT o_content text) OWNER TO lbadm;


CREATE OR REPLACE FUNCTION getnotes(IN i_usersbooks_id integer, OUT o_note_id integer, OUT o_title varchar, OUT o_content text) RETURNS SETOF record AS
$$
DECLARE
BEGIN

RETURN QUERY SELECT note_id, title, content FROM notes WHERE usersbooks_id=i_usersbooks_id;

END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION getnotes(IN i_usersbooks_id integer, OUT o_note_id integer, OUT o_title varchar, OUT o_content text) OWNER TO lbadm;



CREATE OR REPLACE FUNCTION listnotes(IN i_user_id integer, OUT o_title varchar, OUT o_content text, OUT o_book varchar) RETURNS SETOF record AS
$$
DECLARE
BEGIN

RETURN QUERY select n.title, n.content, b.title FROM notes n LEFT OUTER JOIN users_books u USING(usersbooks_id) LEFT OUTER JOIN books b USING(book_id) WHERE u.user_id=i_user_id;


END;
$$
LANGUAGE plpgsql;
ALTER FUNCTION listnotes(IN i_user_id integer, OUT o_title varchar, OUT o_content text, OUT o_book varchar) OWNER TO lbadm;
