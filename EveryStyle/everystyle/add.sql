
GRANT ALL ON everystyle.* TO 'web'@'localhost' IDENTIFIED BY 'asdf';

use web2012;


CREATE TABLE add (
	id INT AUTO_INCREMENT PRIMARY KEY,  
	userid VARCHAR(100) NOT NULL UNIQUE,
	img VARCHAR(100) NOT NULL,
	link VARCHAR(255) NOT NULL,
	clothes CHAR(1) NOT NULL, 
	price VARCHAR(200) NOT NULL,
	season VARCHAR(200) NOT NULL
	
);

