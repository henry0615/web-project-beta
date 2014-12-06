use signup;

CREATE TABLE cody (
	id INT AUTO_INCREMENT PRIMARY KEY,  
	userid VARCHAR(100) NOT NULL,
	outer_left VARCHAR(100),
	outer_top VARCHAR(100),
	outer_id VARCHAR(100),
	top_left VARCHAR(100),
	top_top VARCHAR(100),
	top_id VARCHAR(100),
	pants_left VARCHAR(100),
	pants_top VARCHAR(100),
	pants_id VARCHAR(100),
	skirtdress_left VARCHAR(100),
	skirtdress_top VARCHAR(100),
	skirtdress_id VARCHAR(100),
	created_at VARCHAR(100) NOT NULL
);
