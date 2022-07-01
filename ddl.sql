USE DATABASE cs332m3;

CREATE TABLE professor(
    ssn INT(9) NOT NULL,
    NAME VARCHAR(128) DEFAULT NULL,
    sex CHAR(1) DEFAULT NULL,
    salary FLOAT(8, 2) DEFAULT NULL,
    title VARCHAR(16) DEFAULT NULL,
    street VARCHAR(64) DEFAULT NULL,
    city VARCHAR(64) DEFAULT NULL,
    state VARCHAR(2) DEFAULT NULL,
    zip INT(5) DEFAULT NULL,
    area_code INT(3) DEFAULT NULL,
    phone INT(7) DEFAULT NULL,
    PRIMARY KEY(ssn)
);

insert into professor 
values("987432145", "Charles Xavier","m","120100.99", "Neuroscience","28 Applewood", "Central City","CA","87431","878","5678931"),
("987392198","Harrison Wells","m","220400.43","Philosophy","12 Orangetree","Orange","CA","92435","949","3340876"),
("987442189","Eobard Thawne","m","210140.19","Physics","19 Englewood","Santiago","CA","45692","332","1456792");

CREATE TABLE degree(
    prof_ssn INT(9) NOT NULL,
    degree VARCHAR(64) NOT NULL,
    PRIMARY KEY(prof_ssn, degree),
    CONSTRAINT FOREIGN KEY(prof_ssn) REFERENCES professor(ssn) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into degree
values("987442189","Philosopher's Doctorate, Physics"),
("987442189","Bachelor of Science, Physics"),
("987392198","Bachelor of Arts, Philosophy"),
("987392198","Philosopher's Doctorate, Philosophy"),
("987432145","Master of Science, Neuroscience");

CREATE TABLE department(
    dno INT(2) NOT NULL,
    NAME VARCHAR(64) DEFAULT NULL,
    phone INT(10) DEFAULT NULL,
    location VARCHAR(64) DEFAULT NULL,
    chair_ssn INT(9) DEFAULT NULL,
    PRIMARY KEY(dno),
    CONSTRAINT FOREIGN KEY(chair_ssn) REFERENCES professor(ssn) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into department
values("19","Engineering and Natural Science","9985432207","ENS 101","987442189"),
("42","Art and Philosophy", "9498860101", "APH 121","987392198");

CREATE TABLE course(
    cno INT(4) NOT NULL,
    title VARCHAR(64) DEFAULT NULL,
    units INT(2) DEFAULT NULL,
    textbook VARCHAR(64) DEFAULT NULL,
    dp_no INT(2) DEFAULT NULL,
    PRIMARY KEY(cno),
    CONSTRAINT FOREIGN KEY(dp_no) REFERENCES department(dno) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into course
values("1626","World History Pre-1500s","3","Atlas of the Ancient World","42"),
("1726","World History Post-1500s","3","Atlas of the Modern World","42"),
("2226","Electric Circuits 1","3","Fundamentals of Circuits","19"),
("3200","Linear Algebra","5","Linear Algebras Advancement","19");

CREATE TABLE prerequsite(
    main_cno INT(4) NOT NULL,
    pre_cno INT(4) NOT NULL,
    PRIMARY KEY(main_cno, pre_cno),
    CONSTRAINT FOREIGN KEY(main_cno) REFERENCES course(cno) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY(pre_cno) REFERENCES course(cno) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into prerequsite values("2226","3200");

CREATE TABLE section(
    scno INT(4) NOT NULL,
    sno INT(2) NOT NULL,
    number_of_seats INT(3) DEFAULT NULL,
    start_time TIME DEFAULT NULL,
    end_time TIME DEFAULT NULL,
    classroom VARCHAR(8) DEFAULT NULL,
    meeting_days VARCHAR(7) DEFAULT NULL,
    instructor_ssn INT(9) DEFAULT NULL,
    PRIMARY KEY(sno, scno),
    CONSTRAINT FOREIGN KEY(scno) REFERENCES course(cno) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY(instructor_ssn) REFERENCES professor(ssn) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into section
values("1626","1","100","08:00:00","09:30:00","none","Online","987432145"),
("1726","1","100","10:00:00","11:30:00", "none", "Online","987432145"),
("2226","1","30","10:30:00","11:45:00", "E101","MW","987432145"),
("2226","2","30","12:00:00","01:30:00", "E101","MW","987392198"),
("3200","1","20","02:00:00","03:45:00", "E101","TR","987392198"),
("3200", "2", "20", "04:00:00","06:45:00", "E101", "MW", "987442189");

CREATE TABLE student(
    CWID INT(9) NOT NULL,
    Fname VARCHAR(64) NOT NULL,
    Lname VARCHAR(64) NOT NULL,
    address VARCHAR(256) NOT NULL,
    phone INT(10) NOT NULL,
    major_dno INT(2) NOT NULL,
    PRIMARY KEY(CWID),
    CONSTRAINT FOREIGN KEY(major_dno) REFERENCES department(dno) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into student 
values("115789074","Zach","Chen","628 Hazel Ave Pillager, Minnesota(MN), 56473","9493301874","19"),
("125760875","Oscar","Lopez","521 South Rd West Winfield, New York(NY), 13491","9498760113","19"),
("122789079","Rodaina","Khan","9307 Maple Rd Algonac, Michigan(MI), 48001","7143698713","19"),
("115769078","David","Cook","412 Walnut Ln Mason, Ohio(OH), 45040","7143321983","19"),
("211578907","Santiago","Asami","187 W Francis St New Madrid, Missouri(MO), 63869","9493541989","42"),
("411578907","Nick","Jonas","12187 Raelyn Hills Dr Perry, Michigan(MI), 48872","9499783214","42"),
("511578907","John","Smith","311 Oak St Clyde, Texas(TX), 79510","7149873452","42"),
("711578907","Emily","Jones","526 Bender Rd West Bend, Wisconsin(WI), 53090","9498379854","42");
  
CREATE TABLE enrollment(
    E_cno INT(4) NOT NULL,
    E_sno INT(2) NOT NULL,
    E_CWID INT(9) NOT NULL,
    grade CHAR(2) DEFAULT NULL,
    PRIMARY KEY(E_cno, E_sno, E_CWID),
    CONSTRAINT FOREIGN KEY(E_cno) REFERENCES course(cno) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY(E_sno) REFERENCES section(sno) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY(E_CWID) REFERENCES student(CWID) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into enrollment
values("3200","1","125760875","D-"),
("3200", "1", "115769078", "D+"),
("3200","1","711578907","D"),
("3200","1","511578907","C"),
("3200","1","211578907","C+"),
("3200","2","511578907","B-"),
("3200","2","411578907","B"),
("3200","2","211578907","W"),
("3200","2","122789079","F"),
("3200","2","115789074","A-"),
("2226","1","125760875", "C-"),
("2226","1","115769078","C"),
("2226","2","122789079","D"),
("2226","2","115789074","B-"),
("1626","1","125760875","B"),
("1626","1","115769078","A"),
("1626","1","211578907","A-"),
("1626","1","122789079","C+"),
("1726","1","125760875","D"),
("1726","1","122789079","A+"),
("1726","1","115769078","B"),
("1726","1","115789074","W");

CREATE TABLE minor(
    st_CWID INT(9) NOT NULL,
    minor_dno INT(2) NOT NULL,
    PRIMARY KEY(st_CWID, minor_dno),
    CONSTRAINT FOREIGN KEY(st_CWID) REFERENCES student(CWID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY(minor_dno) REFERENCES department(dno) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into minor values("211578907", "19");
