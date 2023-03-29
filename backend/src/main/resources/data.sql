insert into user(nickname,client_id,profile_image_url,password,role)
values
('송지율','2725446611','http://k.kakaocdn.net/dn/dIUOxh/btrOfbMpO9p/JikTtvK5PtI5Wi6RMyPkDK/img_640x640.jpg','{bcrypt}$2a$10$/Gb020QJB.9SfcUPycuLpunrWYJJ/UN77XGeeUSiMxfr6amZWh2QG','USER'),
('지나','2726508714','http://k.kakaocdn.net/dn/bxPduL/btrRADTVe4q/e5Vzu3IG5vqAWKzudkb77K/img_640x640.jpg','ww','USER'),
('이호준','222222','http//www.','ww','USER'),
('정우진','2725397433','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','{bcrypt}$2a$10$LBsFE6fKaegvaFYSSvjshOVwzuVMBd40/1B2NkKrYbwzHCp4cFzCG','USER');

insert into time_line(user_uid,create_time ,modify_time ,complete,timeline_public)
values
(1,now(),now(),1,1),
(2,now(),now(),1,1),
(3,now(),now(),1,1),
(4,now(),now(),1,1);

insert into nation(name,nation_url)
values
('대한민국','https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/80750caa-9381-41fa-8814-0062d42e81aa.png');


insert into post(timeline_id,post_id,voice_url,voice_length,nation_url,nation_id,text,address1,address2,address3,address4,create_time,modify_time)
values
(1,1,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/e2656d9a-261f-4317-915e-b4403b83a398.wav',
7.639365196228027,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/80750caa-9381-41fa-8814-0062d42e81aa.png',
1,
'네이버 클로바 api를 사용해서 테스트를 해보는 중입니다.',
'대한민국',
'전주',
'완산구',
'고사동',
now(),
now()),
(1,2,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/1f79f69a-329c-4fd6-aab4-36c277a08c2f.com__%EC%97%AD%EC%82%BC%EC%97%AD%20test.wav',
11.609977722167969,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/80750caa-9381-41fa-8814-0062d42e81aa.png',
1,
'안녕하세요. 지금 저는 여기 역삼역에 있는데 여기 사람들이 지금 너무 많고 제가 한국을 여행하게 첫 번째로 여행하게 됐는데 정말 신기하고 재밌네요.',
'대한민국',
'서울특별시',
'강남구',
'역삼동',
now(),
now()),
(4,3,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/e2656d9a-261f-4317-915e-b4403b83a398.wav',
7.639365196228027,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/80750caa-9381-41fa-8814-0062d42e81aa.png',
1,
'네이버 클로바 api를 사용해서 테스트를 해보는 중입니다.',
'대한민국',
'전주',
'완산구',
'고사동',
now(),
now()),
(4,4,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Voice/1f79f69a-329c-4fd6-aab4-36c277a08c2f.com__%EC%97%AD%EC%82%BC%EC%97%AD%20test.wav',
11.609977722167969,
'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Nation/80750caa-9381-41fa-8814-0062d42e81aa.png',
1,
'안녕하세요. 지금 저는 여기 역삼역에 있는데 여기 사람들이 지금 너무 많고 제가 한국을 여행하게 첫 번째로 여행하게 됐는데 정말 신기하고 재밌네요.',
'대한민국',
'서울특별시',
'강남구',
'역삼동',
now(),
now());

insert into photo(post_id,photo_id,is_live,photo_url)
values
(1,1,0,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/ceb0be9a-3bee-4cb8-9685-0288dad5d323.png'),
(2,2,0,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/0fea5d6d-61e1-4c3c-a1fb-92b73e6a8b03.png'),
(3,3,0,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/ceb0be9a-3bee-4cb8-9685-0288dad5d323.png'),
(4,4,0,'https://mydanimbucket.s3.ap-northeast-2.amazonaws.com/Danim/Post/0fea5d6d-61e1-4c3c-a1fb-92b73e6a8b03.png');