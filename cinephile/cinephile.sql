-- 0914/09:37 태그 테이블 전체 없음, board 테이블에 del 없음

--test
SELECT * FROM 
				(SELECT ROWNUM RN, N.* FROM 
					(SELECT * FROM customer1 ORDER BY c_id DESC) N
				) WHERE RN BETWEEN 1 + (1-1)*10 AND 10 + (1-1)*10;

				
				SELECT * FROM 
				(SELECT ROWNUM RN, N.* FROM 
					(SELECT * FROM customer1 ORDER BY c_id DESC) N
				) WHERE RN BETWEEN 1 AND 10;
				
				
select * from CFAVORITE;

SELECT M.MV_NUM,M.MV_NAME, COUNT(C.ZIP_NUM) CZ
FROM movie M, CFAVORITE C
where M.MV_NUM=C.MV_NUM
GROUP BY M.MV_NUM;
				
				
-- <<테이블 생성 순서>>		
-- 1. customer1 고객 테이블 
create table CUSTOMER1(
c_id varchar2(100) primary key,
c_password varchar2(100),
c_name varchar2(100),
c_address varchar2(500),
c_tel varchar2(50),
c_email varchar2(100),
c_del varchar(10),
c_regdate date,
c_nickname varchar2(100),
c_proimg varchar2(500),
c_headerimg varchar2(500),
c_probio varchar2(500));
update customer1 set c_proimg='user.png';


-- 1-2. master 값 입력 /0828:입력보류
insert into CUSTOMER1 values('master','*1234a','관리자',null,'010-1234-1234','cinephile_master@gmail.com','n',sysdate,'관리자','user.png',null,null);
delete from customer1 where c_id='yt';
select * from customer1;
update customer1 set c_proimg='user.png' where
-- select/drop/etc
select *  from CUSTOMER1;
drop table CUSTOMER1;
delete customer1;

----------------------------------------

-- 2. monologue	 모놀로그
create table monologue(
mo_num number(38) primary key,
c_id varchar2(100) references customer1(c_id),
mo_content varchar2(500),
mo_good number(38),
mo_regdate date,
mo_del char(1));

-- 2-1. 모놀로그 시퀀스
create sequence monologue_seq;

-- etc
select * from monologue;
delete monologue where mo_num=21;
drop table monologue;

-------------------------------------

--3. monologue good ck  모놀로그 좋아요
create table mogoodck(
mo_num number(38),
c_id varchar2(100),
CONSTRAINT PK_bg primary key(mo_num,c_id),
CONSTRAINT FK_bg FOREIGN KEY(mo_num) REFERENCES monologue(mo_num),
CONSTRAINT FK_bg2 FOREIGN KEY(c_id) REFERENCES customer1(c_id)
);

-- etc
drop table mogoodck;
select * from mogoodck where mo_num=1 and c_id='pppp';
insert into mogoodck values(3,'aaaa');

----------------------------------------


--5. cgvcode  cgv극장 코드
create table cgvcode(
theatercode varchar2(10),
areacode varchar2(10),
local varchar2(50),
CONSTRAINT PK_cc primary key(theatercode ,areacode));

-- etc
drop table cgvcode;
insert into cgvcode values('0056','01','강남');
insert into cgvcode values('0001','01','강변');
insert into cgvcode values('0229','01','건대입구');
insert into cgvcode values('0010','01','구로');
insert into cgvcode values('0063','01','대학로');
insert into cgvcode values('0252','01','동대문');
insert into cgvcode values('0009','01','명동');
insert into cgvcode values('0030','01','불광');
insert into cgvcode values('0040','01','압구정');
insert into cgvcode values('0112','01','여의도');
----------------------------------------

--6. favoritezip 취향집
create table favoritezip(
 zip_num number(38) primary key,
 fz_good number(38),
 c_id varchar2(100) references customer1(c_id)
);
--6-1. 취향집 시퀀스
create sequence favoritezip_seq;


--ect
insert into favoritezip values(favoritezip_seq.nextval,0,'master');
----------------------------------------

-- 7. movie 영화 테이블 
create table movie(
mv_num number(15) primary key,
mv_name varchar2(300),
mv_direct varchar2(100),
mv_genre varchar2(100),
mv_content varchar2(4000),
mv_mjactor varchar2(300),
mv_minactor varchar2(1000),
mv_reldate varchar2(500),
mv_rate number(3,1),
mv_runtime number(4),
mv_imageurl varchar2(300),
mv_grade varchar2(100));

-- 7-1. 수정 0916 11:32 am
-- 아래 내용 위에 다 추가함 따로 적용시킬 필요 없음
alter table movie modify mv_content VARCHAR2(4000);	
alter table movie modify mv_mjactor varchar2(300);
alter table movie modify mv_reldate varchar2(500);
alter table movie modify mv_minactor varchar2(1000);
ALTER TABLE movie ADD mv_grade VARCHAR2(100);
-- etc
select * from movie;
drop table movie;

update movie set mv_reldate = '재개봉, 2020. 08.26 개봉' where mv_num=190010;
update movie set mv_imageurl = 'https://movie-phinf.pstatic.net/20181019_236/1539926790655oHv5z_JPEG/movie_image.jpg?type=m203_290_2' where mv_num=30688;
update movie set mv_genre = '코미디' where mv_num=182234;
delete from movie where mv_name like '%대한이%';
----------------------------------------

-- 8. board 게시판
create table board(
b_num number(38) primary key,
b_subject varchar2(300),
b_content varchar2(4000),
b_readcount number(38),
b_regdate date,
c_id varchar2(100) references customer1(c_id),
b_good number(38),
b_type varchar2(50),
b_category varchar2(100),
b_del char(1));

-- etc
insert into board values ('2','제목subject3','내용content3',1,sysdate,'zzzz',0,'리뷰','상영중','n');
insert into board values (#{b_num},#{b_subject},#{b_content},#{b_readcount},sysdate,#{c_id},#{b_good},#{b_type},#{b_category},#{b_del})
delete board;
select * from board;
drop table bogoodck;
drop table board;

----------------------------------------

--9. board good ck 게시판 좋아요
create table bogoodck(
b_num number(38),
c_id varchar2(100),
CONSTRAINT PK_bo primary key(b_num,c_id),
CONSTRAINT FK_bo FOREIGN KEY(b_num) REFERENCES board(b_num),
CONSTRAINT FK_bo2 FOREIGN KEY(c_id) REFERENCES customer1(c_id)
);


----------------------------------------


--10. comment 댓글
create table comments(
co_num number(38) primary key,
b_num number(38),
co_content varchar2(500),
co_del char(1),
co_regdate date,
c_id varchar2(100),
CONSTRAINT FK_c FOREIGN KEY(c_id) REFERENCES customer1(c_id),
CONSTRAINT FK_c2 FOREIGN KEY(b_num) REFERENCES board(b_num)
);

drop table comments;
----------------------------------------

-- 11. cfavorite (고객 하나가 하나의 영화에 추천을 눌렀는지 여부 검사)

create table cfavorite(
mv_num number(15),
zip_num number(38),
CONSTRAINT PK_cf primary key(mv_num,zip_num),
CONSTRAINT FK_cf FOREIGN KEY(mv_num) REFERENCES movie(mv_num),
CONSTRAINT FK_cf2 FOREIGN KEY(zip_num) REFERENCES favoritezip(zip_num)
);

-- etc
delete from cfavorite;
drop table cfavorite;

----------------------------------------

--12. book 예약 
create table book(
book_num number(38) primary key,
c_id varchar2(100),
mv_num number(15),
book_numSeat varchar2(500),
book_loc varchar2(500),
book_date date,
book_humantype varchar2(100),
book_price number(10),
mv_name varchar2(300),
book_del char(1),
CONSTRAINT FK_bk FOREIGN KEY(c_id) REFERENCES customer1(c_id),
CONSTRAINT FK_bk2 FOREIGN KEY(mv_num) REFERENCES movie(mv_num)
);
--12-1. 예약 시퀀스
create sequence book_seq;
drop sequence book_seq;

--ect
select * from book;
drop table book;
drop sequence book_seq;
insert into book values(1,'aaaa',190010, 'b17', '강변', sysdate, '성인', 10000, '테넷', 'n');

----------------------------------------

--15. tag
create table tag(
tag_num number(38) primary key,
tag_con varchar2(300));

--15.-1. tag 시퀀스
create sequence tag_seq;
insert into tag values(tag_seq.nextval,'블록버스터');
insert into tag values(tag_seq.nextval,'가족들끼리 보기 좋은');

--etc
drop table tag;
drop sequence tag_seq;
select * from tag;

----------------------------------------

-- 12. monologue tag link 모놀로그 태그 
create table motaglink(
link_id number(38),
tag_num number(38),
mo_num number(38),
CONSTRAINT PK_motag primary key(link_id,tag_num,mo_num),
CONSTRAINT FK_motag FOREIGN KEY(tag_num) REFERENCES tag(tag_num),
CONSTRAINT FK_motag2 FOREIGN KEY(mo_num) REFERENCES monologue(mo_num)
);


create sequence motaglink_seq;
--etc
select * from motaglink;
drop table motaglink;

----------------------------------------

-- 13. favoritezip good chk 취향집 추천

create table fzgoodck(
zip_num number(38),
c_id varchar2(100),
CONSTRAINT PK_fz primary key(zip_num,c_id),
CONSTRAINT FK_fz FOREIGN KEY(zip_num) REFERENCES favoritezip(zip_num),
CONSTRAINT FK_fz2 FOREIGN KEY(c_id) REFERENCES customer1(c_id)
);  

drop table favoritezip;

----------------------------------------

--14. following 테이블
create table following(
c_id varchar2(100),
f_id varchar2(100),
CONSTRAINT pk_fo PRIMARY KEY(c_id,f_id),
constraint fk_fo FOREIGN KEY(c_id) REFERENCES customer1(c_id)
);


drop table following;
----------------------------------------


--16.mvtaglink
create table mvtaglink(
link_id number(38),
tag_num number(38),
mv_num number(15),
CONSTRAINT PK_mytag primary key(link_id,tag_num,mv_num),
CONSTRAINT FK_mvtag FOREIGN KEY(tag_num) REFERENCES tag(tag_num),
CONSTRAINT FK_mvtag2 FOREIGN KEY(mv_num) REFERENCES movie(mv_num)
);

create sequence mvtaglink_seq;


insert into mvtaglink values(mvtaglink_seq.nextval,1,190010);
drop table mvtaglink;
drop sequence mvtaglink_seq;

select * from movie;
select * from MvTAGLINK;

------------------------------------------------------------

--17. genre
create table Genre (
	gn_num number(5) primary key,
	gn_name varchar2(50) not null
);

--17-1   genre_seq
create sequence genre_seq;
drop sequence genre_seq;

insert into genre values(genre_seq.nextval,'드라마');
insert into genre values(genre_seq.nextval,'판타지');
insert into genre values(genre_seq.nextval,'서부');
insert into genre values(genre_seq.nextval,'공포');
insert into genre values(genre_seq.nextval,'멜로/로맨스');
insert into genre values(genre_seq.nextval,'무협');
insert into genre values(genre_seq.nextval,'실험');
insert into genre values(genre_seq.nextval,'모험');
insert into genre values(genre_seq.nextval,'스릴러');
insert into genre values(genre_seq.nextval,'느와르');
insert into genre values(genre_seq.nextval,'컬트');
insert into genre values(genre_seq.nextval,'다큐먼터리');
insert into genre values(genre_seq.nextval,'액션');
insert into genre values(genre_seq.nextval,'공연실황');
insert into genre values(genre_seq.nextval,'코미디');
insert into genre values(genre_seq.nextval,'가족');
insert into genre values(genre_seq.nextval,'미스터리');
insert into genre values(genre_seq.nextval,'전쟁');
insert into genre values(genre_seq.nextval,'블랙코미디');
insert into genre values(genre_seq.nextval,'서사');
insert into genre values(genre_seq.nextval,'애니메이션');
insert into genre values(genre_seq.nextval,'범죄');
insert into genre values(genre_seq.nextval,'뮤지컬');
insert into genre values(genre_seq.nextval,'SF');
insert into genre values(genre_seq.nextval,'에로');
insert into genre values(genre_seq.nextval,'서스펜스');

drop table genre;
