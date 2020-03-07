# MVC1 패턴 홈페이지
* 언어 : JAVA, JavaScript, JSP, Ajax, JQuery, HTML/CSS  
* 개발도구 : Tomcat 8.5, Eclipse, My-SQL  
* 기능: 회원가입, 로그인, 회원정보 수정, 게시판 글 작성/수정/삭제/답글,   
        파일 업/다운로드, 갤러리 게시판 글 작성/수정/삭제/댓글

# 소개
* 개인 프로젝트로 진행한 패션 브랜드 홈페이지 입니다. 

* Ajax를 사용하여 댓글 기능을 구현하였으며, 게시판 글 작성시 파일을 업/다운로드 가능하게 구현하였습니다.  
  게시판은 댓글 대신 답글 기능을 추가하여 들여쓰기 되어 작성되도록 구현하였습니다.  
  홈페이지의 모든 게시판의 글 작성은 회원만이 가능하도록 설계하였고,   
  작성한 게시글, 혹은 댓글의 수정 및 삭제는 작성한 본인만이 할 수 있도록 설계하였습니다. 

* JDBC와의 연동을 위해 Connection Pool을 사용하였습니다.

# 실행 방법
1. 해당 프로젝트를 Eclipse에 import합니다.  

2. Connection Pool이 작동하는지 connect 여부를 확인합니다.

3. 아래를 참고하여 4개의 테이블을 생성합니다.  
 - member 테이블
```
CREATE TABLE `member1` (
  `id` varchar(12) NOT NULL,
  `passwd` varchar(12) NOT NULL,
  `name` varchar(20) NOT NULL,
  `birth` varchar(10) DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `postcode` varchar(30) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `mtel` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
```
 - board 테이블
 ```
 CREATE TABLE `board` (
  `num` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `passwd` varchar(20) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `file` varchar(50) DEFAULT NULL,
  `re_ref` int(11) DEFAULT NULL,
  `re_lev` int(11) DEFAULT NULL,
  `re_seq` int(11) DEFAULT NULL,
  `readcount` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
 ```
 
  - collection 테이블
  ```
  CREATE TABLE `collection` (
  `num` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `passwd` varchar(20) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `file` varchar(50) DEFAULT NULL,
  `re_ref` int(11) DEFAULT NULL,
  `re_lev` int(11) DEFAULT NULL,
  `re_seq` int(11) DEFAULT NULL,
  `readcount` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
```

 - comment 테이블
 ```
 CREATE TABLE `comment` (
  `num` int(10) DEFAULT NULL,
  `id` varchar(12) DEFAULT NULL,
  `ment` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idx`),
  KEY `fk_com_num_idx` (`num`),
  CONSTRAINT `fk_com_num` FOREIGN KEY (`num`) REFERENCES `board` (`num`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8
```


4. WebConent폴더의 index.jsp 파일을 실행하여 홈페이지를 사용할 수 있습니다.


## Developer Information
> email : wldn7076@naver.com

