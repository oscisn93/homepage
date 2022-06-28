CREATE TABLE professor (
  ssn int(9) NOT NULL,
  name varchar(128) DEFAULT NULL,
  sex char(1) DEFAULT NULL,
  salary float(8,2) DEFAULT NULL,
  title varchar(16) DEFAULT NULL,
  street varchar(64) DEFAULT NULL,
  city varchar(64) DEFAULT NULL,
  state varchar(2) DEFAULT NULL,
  zip int(5) DEFAULT NULL,
  area_code int(3) DEFAULT NULL,
  phone int(7) DEFAULT NULL,
  PRIMARY KEY(ssn)
);

CREATE TABLE degrees (
  prof_ssn int(9) NOT NULL,
  degree varchar(64) NOT NULL,
  PRIMARY KEY (prof_ssn, degree),
  FOREIGN KEY(prof_ssn) REFERENCES professor ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE department (
  dno int(2) NOT NULL,
  name varchar(64) DEFAULT NULL,
  phone int(10) DEFAULT NULL,
  location varchar(64) DEFAULT NULL,
  chair_ssn int(9) DEFAULT NULL,
  PRIMARY KEY(dno),
  FOREIGN KEY(chair_ssn) REFERENCES professor ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE course (
  cno int(4) NOT NULL,
  title varchar(64) DEFAULT NULL,
  units int(2) DEFAULT NULL,
  textbook varchar(64) DEFAULT NULL,
  dp_no int(2) DEFAULT NULL,
  PRIMARY KEY(cno),
  FOREIGN KEY(dno) REFERENCES department ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE prerequsites (
  main_cno int(4) NOT NULL,
  pre_cno int(4) NOT NULL,
  PRIMARY KEY(main_cno, pre_cno),
  FOREIGN KEY(main_cno) REFERENCES course ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(pre_cno) REFERENCES course ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE section (
  scno int(4) NOT NULL,
  sno int(2) NOT NULL,
  number_of_seats int(3) DEFAULT NULL,
  start_time time DEFAULT NULL,
  end_time time DEFAULT NULL,
  meeting_days varchar(7) DEFAULT NULL,
  instructor_ssn int(9) DEFAULT NULL,
  PRIMARY  KEY(scno, sno),
  FOREIGN KEY(scno) REFERENCES course ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(instructor_ssn) REFERENCES professor ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE student (
  CWID int(9) NOT NULL,
  Fname varchar(64) NOT NULL,
  Lname varchar(64) NOT NULL,
  address varchar(256) NOT NULL,
  phone int(10) NOT NULL,
  major_dno int(2) NOT NULL,
  PRIMARY KEY(CWID),
  FOREIGN KEY(major_dno) REFERENCES department ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE enrollment (
  E_cno int(4) NOT NULL,
  E_sno int(2) NOT NULL,
  E_CWID int(9) NOT NULL,
  grade char(2) DEFAULT NULL,
  PRIMARY KEY(E_cno, E_sno, E_CWID)
  FOREIGN KEY(E_cno) REFERENCES course(cno) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(E_sno) REFERENCES section(sno) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(E_CWID) REFERENCES student(CWID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE minor (
  st_CWID int(9) NOT NULL,
  minor_dno int(2) NOT NULL 
  PRIMARY KEY(st_CWID, minor_dno) ,
  FOREIGN KEY(st_CWID) REFERENCES student(CWID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(minor_dno) REFERENCES department(dno) ON DELETE CASCADE ON UPDATE CASCADE
);
