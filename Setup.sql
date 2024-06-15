create database if not exists auction;
use auction;

create table user(
    userID int primary key auto_increment,
    firstName varchar(50) not null,
    lastName varchar(50) not null,
    email varchar(256) not null unique,
    password varchar(30) not null,
    userState varchar(10),
    constraint userStateValues check ( userState in('active', 'inactive') )
);

create table article(
    articleID int primary key auto_increment,
    userID int not null,
    label varchar(50) not null,
    description varchar(3000),
    startTime datetime not null default now(),
    endTime datetime not null,
    free tinyint not null default 0,
    startPrice decimal(12, 2) not null,
    cancellationState varchar(20) ,
    constraint cancellationStateValues check ( article.cancellationState in('active', 'cancellation', 'completed')),
    constraint startEnd check ( article.startTime < article.endTime )
);

create table bid(
    bidID int primary key auto_increment,
    userId int not null,
    articleId int not null,
    price decimal(12, 2) not null,
    timestamp datetime not null default now(),
    constraint articleIDWithPrice unique (articleId, price),
    constraint BIDMitAIDMitZP unique(userId, articleId, timestamp)
);

create table Hist_User(
    BID int,
    VN varchar(50),
    NN varchar(50),
    EMail varchar(255),
    Password varchar(30),
    userState varchar(10)
);

create table Hist_Article(
    AID int,
    BID int,
    Bez varchar(50),
    Besch varchar(3000),
    Start datetime,
    Ende datetime,
    Frei tinyint,
    Startpreis decimal(12, 2),
    stornoState varchar(20)
);

create table Hist_Bid(
    GID int,
    BID int,
    AID int,
    Preis decimal(12, 2),
    ZP datetime
);

alter table article add constraint ArtikelBenutzer foreign key(userID) references user(userID);

-- alter table artikel drop foreign Key ArtikelBenutzer;
alter table bid add constraint Bieter foreign key(userId) references user(userId);
alter table bid add constraint GeboteArtikel foreign key(articleId) references article(articleID);
#
# insert into Hist_User select * from Benutzer where userState = 'inactive';
# delete from user where userState = 'inactive';
# insert into Hist_Article select * from Artikel where stornoState in('storno', 'completed');
# delete from article where stornoState in('storno', 'completed');
# -- insert into Hist_Gebote select * from Gebote group by AID having Uebung_Versteigerung.artikel.stornoState in ('storno', 'completed');
#
# select MAX(Preis) from Gebote where AID = 27;
#
# select AID, MAX(Preis) from Gebote group by AID;
# select AID, MAX(Preis) from Gebote group by AID having Max(Preis) > 1000;
# select AID, MAX(Preis) from Gebote group by AID having Max(Preis) > 1000 order by MAX(Preis) desc;
# select BID, COUNT(AID) as Anzahl from Artikel group by BID;
#
# select firstName, lastname, articleId, price from bid join user B on bid.userId = B.userId where bid.articleId = 33;
# select firstName, lastName, a.articleID, a.description, price from bid join user B on bid.userId = B.userId join article as a on bid.articleId = a.articleID where bid.articleId = 33;

alter table Hist_Bid add primary key (GID);
alter table Hist_Article add primary key (AID);
alter table Hist_User add primary key (BID);

-- test insert
INSERT INTO user (firstName, lastName, EMail, Password, userState)
VALUES
    ('John', 'Doe', 'john.doe@example.com', 'password123', 'active'),
    ('Jane', 'Smith', 'jane.smith@example.com', 'password456', 'inactive'),
    ('Alice', 'Johnson', 'alice.johnson@example.com', 'password789', 'active');

INSERT INTO article (userId, label, description, startTime, endTime, free, startPrice, cancellationState)
VALUES
(1, 'Laptop', 'Brand new laptop with high performance specs', '2024-03-11 12:00:00', '2024-03-18 12:00:00', 1, 1200.00, 'active'),
(2, 'Smartphone', 'Latest smartphone model with advanced features', '2024-03-12 09:00:00', '2024-03-20 09:00:00', 1, 800.00, 'completed'),
(3, 'Tablet', 'Lightweight and portable tablet for everyday use', '2024-03-13 15:00:00', '2024-03-17 15:00:00', 1, 500.00, 'cancellation');

INSERT INTO bid (userid, articleId, price, timestamp)
VALUES
(1, 1, 1300.00, '2024-03-12 14:00:00'),
(2, 1, 1400.00, '2024-03-13 10:00:00'),
(3, 1, 1500.00, '2024-03-14 11:00:00'),
(2, 2, 850.00, '2024-03-13 10:30:00'),
(3, 2, 900.00, '2024-03-14 09:00:00'),
(1, 3, 550.00, '2024-03-13 13:00:00'),
(2, 3, 600.00, '2024-03-14 08:00:00');

select * from user;