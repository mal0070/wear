create table person(
    ID  long
    username varchar,
    email varchar,
    password varchar,
    nickname varchar,
    primary key (ID, email, nickname)
)

create table follower(
    ID long,
    follower long,
    following long,
    foreign key (ID) references person(ID)
)
팔로우 정보
회원의 팔로워 수, 팔로잉 수

create table post(
    ID long,
    사진 ?,
    옷카테고리 ,
    description varchar,
    date date,
    time time,
    likes integer,
    foreign key (ID) references person(ID)
)
게시물 정보
회원아이디, 글, 업로드 시간, 날짜, 좋아요 수

create table temp_range(
    ID long,
    temp int,
    range int
)
온도범주 정보
현재 온도, +- 얼마

create table poll(
    ID long,
    date date,
    time time,
    사진 ?,
    poll_1 integer,
    poll_2 integer,
    valid boolean,
    foreign key (ID) references person(ID)
)
투표정보
생성날짜, 시간, 후보 각각의 득표수, 종료 여부


create table scarpbook(
    ID long,
    folder_id
)
스크랩북 정보
회원아이디,
