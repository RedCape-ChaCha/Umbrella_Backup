CREATE TABLE `USERINFO` (
	`USER_NUMBER`	INT primary key auto_increment,
	`USER_EMAIL`	VARCHAR(100) NOT NULL,
	`USER_PASSWORD`	VARCHAR(50),
	`USER_PHONE`	VARCHAR(11),
	`USER_ADDRESS`	VARCHAR(500),
	`USER_DELFLAG`	VARCHAR(1) NOT NULL,
	`USER_REGDATE`	DATETIME NOT NULL,
	`USER_MILEAGE`	INT NOT NULL,
	`USER_GRADE`	VARCHAR(1) NOT NULL,
	`USER_API`	VARCHAR(1) NOT NULL
) DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE USERINFO auto_increment = 1; 

CREATE TABLE `BOOK` (
	`BOOK_CSEQ`	INT	primary key auto_increment,
	`BOOK_NAME`	VARCHAR(300) NOT NULL,
	`ISBN`	INT NOT NULL,
	`BOOK_NUMBER`	INT NOT NULL,
	`BOOK_WRITER`	VARCHAR(300) NOT NULL,
	`BOOK_PUBLISHER`	VARCHAR(100) NOT NULL,
	`BOOK_PRICE`	INT NOT NULL,
	`BOOK_IMG`	VARCHAR(200),
	`BOOK_COUNT` INT NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE BOOK auto_increment = 1; 

CREATE TABLE `BOOK_CONDITION` (
	`BOOK_ASEQ`	INT primary KEY auto_increment,
    `BOOK_CSEQ`	INT NOT NULL,
	`CONDITION_STORAGE`	VARCHAR(1) NOT NULL,
	`CONDITION_BORROW`	VARCHAR(1) NOT NULL,
	`BOOK_DATE`	DATE NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE BOOK_CONDITION auto_increment = 1; 
ALTER TABLE BOOK_CONDITION ADD constraint BOOK_FKEY foreign key (BOOK_CSEQ) references BOOK (BOOK_CSEQ);

CREATE TABLE `FILE`(
	`F_SEQ`	INT primary key,
	`F_REALNAME`	VARCHAR(200) NOT NULL,
	`F_STORAGENAME`	VARCHAR(200) NOT NULL,
	`F_REGDATE`	DATETIME NOT NULL,
    `F_INFO` VARCHAR(100) NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE `FILE` auto_increment = 1; 

CREATE TABLE `QNABOARD` (
	`QNA_SEQ`	INT	 primary key auto_increment   ,
	`USER_NUMBER`	INT NOT NULL,
	`Q_TITLE`	VARCHAR(100) NOT NULL,
	`Q_CONTENT`	VARCHAR(5000) NOT NULL,
	`Q_REGDATE`	DATETIME NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE QNABOARD auto_increment = 1; 
ALTER TABLE QNABOARD ADD constraint QNABOARD_FKEY foreign key (USER_NUMBER) references USERINFO (USER_NUMBER);

CREATE TABLE `REPLYBOARD` (
	`REP_SEQ`	INT	  primary key auto_increment  ,
	`USER_NUMBER`	INT NOT NULL,
    `QNA_SEQ` INT NOT NULL,
	`R_CONTENT`	VARCHAR(5000) NOT NULL,
	`R_REGDATE`	DATETIME NOT NULL,
    foreign key(USER_NUMBER) references USERINFO(USER_NUMBER) ON UPDATE cascade ON delete cascade,
    foreign key(QNA_SEQ) references QNABOARD(QNA_SEQ) ON UPDATE cascade ON delete cascade
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE REPLYBOARD auto_increment = 1;

CREATE TABLE `RESVLIST` (
	`RESV_SEQ`	INT	  primary key auto_increment ,
	`USER_NUMBER`	INT NOT NULL,
    `BOOK_CSEQ` INT NOT NULL,
	`STEP`	INT NOT NULL,
	`MILG_CHECK`	VARCHAR(1) NOT NULL,
	`RESV_DATE`	DATETIME NOT NULL,
	`LOAN_CHECK`	VARCHAR(1) NOT NULL,
    foreign key(USER_NUMBER) references USERINFO(USER_NUMBER) ON UPDATE cascade ON delete cascade,
    foreign key(BOOK_CSEQ) references BOOK(BOOK_CSEQ) ON UPDATE cascade ON delete cascade
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE RESVLIST auto_increment = 1;

CREATE TABLE `LOANLIST` (
	`LOAN_SEQ`	INT	 primary key auto_increment  ,
	`USER_NUMBER`	INT NOT NULL,
    `BOOK_ASEQ` INT NOT NULL,
	`LOAN_DATE`	DATE NOT NULL,
	`RETURN_DATE`	DATE NOT NULL,
	`RETURN_CHECK`	VARCHAR(1),
    foreign key(USER_NUMBER) references USERINFO(USER_NUMBER) ON UPDATE cascade ON delete cascade,
    foreign key(BOOK_ASEQ) references BOOK_CONDITION(BOOK_ASEQ) ON UPDATE cascade ON delete cascade
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE LOANLIST auto_increment = 1;

CREATE TABLE `OVERLIST` (
	`OVER_SEQ`	INT	 primary key auto_increment   ,
	`USER_NUMBER`	INT NOT NULL,
	`OVER_START`	DATE NOT NULL ,
	`OVER_COUNT`	INT	NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE OVERLIST auto_increment = 1; 
ALTER TABLE OVERLIST ADD constraint OVERLIST_FKEY foreign key (USER_NUMBER) references USERINFO (USER_NUMBER);

CREATE TABLE `BOB_BOOK` (
	`BOB_SEQ`	INT	  primary key auto_increment  ,
	`BOB_TITLE`	VARCHAR(100)	NOT NULL ,
	`BOB_CONTENT`	VARCHAR(5000)	NOT NULL ,
	`BOB_REGDATE`	DATETIME	NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE BOB_BOOK auto_increment = 1; 

CREATE TABLE `PAYLIST` (
	`PAY_SEQ`	INT	  primary key auto_increment  ,
	`USER_NUMBER`	INT NOT NULL,
	`PAY_TYPE`	VARCHAR(20) NOT NULL,
	`PAY_AMOUNT`	INT	 NOT NULL,
	`PAY_DATE`	DATETIME NOT NULL,
	`PAY_RETURNCK`	VARCHAR(1)  NOT NULL,
	`PAY_RDATE`	DATE NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE PAYLIST auto_increment = 1; 
ALTER TABLE PAYLIST ADD constraint PAYLIST_FKEY foreign key (USER_NUMBER) references USERINFO (USER_NUMBER);

CREATE TABLE `NOTICEBOARD` (
	`NOT_SEQ`	INT	   primary key auto_increment ,
	`N_TITLE`	VARCHAR(100)	NOT NULL    ,
	`N_CONTENT`	VARCHAR(5000)	  NOT NULL  ,
	`N_REGDATE`	DATETIME	NOT NULL
)  DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
ALTER TABLE NOTICEBOARD auto_increment = 1; 