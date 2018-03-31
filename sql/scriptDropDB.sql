drop table repond;
drop table partie;
drop table utilisateur;
drop table logo;
drop table niveau;
drop table collection;

drop procedure connexion;
drop procedure inscription;
drop procedure creer_partie;
drop procedure creer_repond;
drop procedure update_partie;
drop procedure update_exp_utilisateur;
drop procedure recup_highscore;

drop trigger trigger_blocage;
drop trigger trigger_niveau;
drop trigger trigger_delete_ec;

drop sequence SEQ_COLLECTION_ID_COLLECTION;
drop sequence SEQ_LOGO_ID_LOGO;
drop sequence SEQ_PARTIE_ID_PARTIE;


---------------------------------------------------------------
--        Script Oracle.
---------------------------------------------------------------


------------------------------------------------------------
-- Table: Utilisateur
------------------------------------------------------------
CREATE TABLE utilisateur(
  pseudo            VARCHAR2 (255) NOT NULL  ,
  mot_de_passe      VARCHAR2 (255) NOT NULL  ,
  date_inscription  DATE   NOT NULL,
  experience        NUMBER(10,0),
  CONSTRAINT utilisateur_pk PRIMARY KEY (pseudo)
);

------------------------------------------------------------
-- Table: Partie
------------------------------------------------------------
CREATE TABLE partie(
  id_partie        NUMBER NOT NULL ,
  temps            NUMBER(10,0)   ,
  date_partie      DATE   ,
  pseudo           VARCHAR2 (255) NOT NULL  ,
  niveau           NUMBER(10,0)   ,
  statut           VARCHAR(2) NOT NULL ,
  score           NUMBER(10,0)   ,
  CONSTRAINT partie_pk PRIMARY KEY (id_partie),
  CONSTRAINT partie_ck_statut CHECK(statut IN('EC','G','P'))
);

------------------------------------------------------------
-- Table: Logo
------------------------------------------------------------
CREATE TABLE logo(
  id_logo        NUMBER NOT NULL ,
  lien_logo      VARCHAR2 (255)NOT NULL  ,
  reponse        VARCHAR2 (255)NOT NULL  ,
  id_collection  NUMBER(10,0)  NOT NULL,
  CONSTRAINT logo_pk PRIMARY KEY (id_logo) ,
  CONSTRAINT logo_uniq UNIQUE (lien_logo,reponse)
);

------------------------------------------------------------
-- Table: Collection
------------------------------------------------------------
CREATE TABLE collection(
  id_collection  NUMBER NOT NULL ,
  CONSTRAINT collection_Pk PRIMARY KEY (id_collection)
);

------------------------------------------------------------
-- Table: Niveau
------------------------------------------------------------
CREATE TABLE niveau(
  niveau         NUMBER(10,0)  NOT NULL  ,
  nb_logo_gagne  NUMBER(10,0)   ,
  id_collection  NUMBER(10,0)   ,
  CONSTRAINT niveau_pk PRIMARY KEY (niveau)
);

------------------------------------------------------------
-- Table: Repond
------------------------------------------------------------
CREATE TABLE repond(
  resultat_reponse  NUMBER (1) ,
  date_reponse      DATE   ,
  reponse_repondue   VARCHAR2 (25)  ,
  id_logo           NUMBER(10,0)  NOT NULL  ,
  id_partie         NUMBER(10,0)  NOT NULL  ,
  CONSTRAINT repond_Pk PRIMARY KEY (id_logo,id_partie) ,
  CONSTRAINT ck_boolean_resultat_reponse CHECK (resultat_reponse IN (0,1))
);




ALTER TABLE partie ADD CONSTRAINT fk_partie_pseudo FOREIGN KEY (pseudo) REFERENCES utilisateur(pseudo);
ALTER TABLE partie ADD CONSTRAINT fk_partie_niveau FOREIGN KEY (niveau) REFERENCES niveau(niveau);
ALTER TABLE logo ADD CONSTRAINT fk_logo_collection FOREIGN KEY (id_collection) REFERENCES collection(id_collection);
ALTER TABLE niveau ADD CONSTRAINT fk_niveau_collection FOREIGN KEY (id_collection) REFERENCES collection(id_collection);
ALTER TABLE repond ADD CONSTRAINT fk_repond_logo FOREIGN KEY (id_logo) REFERENCES logo(id_logo);
ALTER TABLE repond ADD CONSTRAINT fk_repond_partie FOREIGN KEY (id_partie) REFERENCES partie(id_partie);

CREATE SEQUENCE seq_partie_id_partie START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_logo_id_logo START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_collection_id_collection START WITH 1 INCREMENT BY 1 NOCYCLE;





INSERT INTO COLLECTION VALUES(SEQ_COLLECTION_ID_COLLECTION.nextval);
INSERT INTO COLLECTION VALUES(SEQ_COLLECTION_ID_COLLECTION.nextval);
INSERT INTO COLLECTION VALUES(SEQ_COLLECTION_ID_COLLECTION.nextval);
INSERT INTO COLLECTION VALUES(SEQ_COLLECTION_ID_COLLECTION.nextval);
INSERT INTO COLLECTION VALUES(SEQ_COLLECTION_ID_COLLECTION.nextval);
INSERT INTO COLLECTION VALUES(SEQ_COLLECTION_ID_COLLECTION.nextval);

INSERT INTO NIVEAU VALUES (1,5,1);
INSERT INTO NIVEAU VALUES (2,8,1);
INSERT INTO NIVEAU VALUES (3,6,2);
INSERT INTO NIVEAU VALUES (4,8,2);
INSERT INTO NIVEAU VALUES (5,6,3);
INSERT INTO NIVEAU VALUES (6,8,3);
INSERT INTO NIVEAU VALUES (7,6,4);
INSERT INTO NIVEAU VALUES (8,8,4);
INSERT INTO NIVEAU VALUES (9,6,5);
INSERT INTO NIVEAU VALUES (10,9,5);

--Insert failed for rows  1  through  50
--ORA-02396: exceeded maximum idle time, please connect again
--Row 1
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/768px-Google_%22G%22_Logo.svg.png','GOOGLE',1);
--Row 2
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/c/c2/F_icon.svg','FACEBOOK',1);
--Row 3
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://sguru.org/wp-content/uploads/2018/02/maxresdefault-9.jpg','YOUTUBE',2);
--Row 4
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.symbols.com/gi.php?type=1&id=2854&i=1','SKYPE',2);
--Row 5
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/2000px-Spotify_logo_without_text.svg.png','SPOTIFY',2);
--Row 6
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://media.glassdoor.com/sqll/3492/nestl%C3%A9-squarelogo-1475824542836.png','NESTLE',4);
--Row 7
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/fr/thumb/c/c8/Twitter_Bird.svg/1259px-Twitter_Bird.svg.png','TWITTER',1);
--Row 8
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://1000logos.net/wp-content/uploads/2016/10/Adidas-logo-shirt.jpg','ADIDAS',1);
--Row 9
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/2000px-Apple_logo_black.svg.png','APPLE',1);
--Row 10
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Android_robot.svg/2000px-Android_robot.svg.png','ANDROID',2);
--Row 11
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://cdn.worldvectorlogo.com/logos/alfa-romeo.svg','ALFA ROMEO',3);
--Row 12
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://s3-media4.fl.yelpcdn.com/bphoto/teNN3BD0FTKSulkZf0B9hg/ls.jpg','TEXAS INSTRUMENTS',5);
--Row 13
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.freepngimg.com/download/toyota_logo/5-2-toyota-logo-png.png','TOYOTA',3);
--Row 14
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.carlogos.org/logo/Renault-logo-2015-2048x2048.png','RENAULT',1);
--Row 15
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.stickpng.com/assets/images/584831f6cef1014c0b5e4aa6.png','PEUGEOT',1);
--Row 16
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://seeklogo.com/images/B/BIC-logo-6005AFD938-seeklogo.com.png','BIC',2);
--Row 17
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://pre00.deviantart.net/44b4/th/pre/i/2013/011/9/3/atari_logo_05_by_dhlarson-d5qqh2s.png','ATARI',5);
--Row 18
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.car-brand-names.com/wp-content/uploads/2016/02/Mazda-logo.png','MAZDA',4);
--Row 19
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.carlogos.org/logo/Chevrolet-logo-2004-1920x1080.jpg','CHEVROLET',3);
--Row 20
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://marque-voiture.com/wp-content/uploads/2015/10/Logo-Citroen.png','CITROEN',3);
--Row 21
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://www.meme-arsenal.com/memes/95b26f3a3ae8efaa42983949a49a5dba.jpg','LACOSTE',2);
--Row 22
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://img2.cgtrader.com/items/119928/a757dac9e0/logo-asus-nvidia-3d-model-max-fbx.jpg','NVIDIA',4);
--Row 23
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Firefox_Logo%2C_2017.svg/2000px-Firefox_Logo%2C_2017.svg.png','FIREFOX',2);
--Row 24
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://clipart-library.com/data_images/249128.png','KFC',2);
--Row 25
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/McDonald%27s_Golden_Arches.svg/2000px-McDonald%27s_Golden_Arches.svg.png','MC DONALDS',1);
--Row 26
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://pbs.twimg.com/profile_images/1892578420/rolex_logo_256_400x400.png','ROLEX',4);
--Row 27
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://royaldutchshellplc.com/wp-content/uploads/2015/01/Screen-Shot-2015-01-06-at-21.26.38.jpg','SHELL',3);
--Row 28
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://i.pinimg.com/736x/92/fd/59/92fd59efefc446c7e858ebd16c53feba--pinterest-logo-png-pinterest-board.jpg','PINTEREST',2);
--Row 29
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://annnguyen4.files.wordpress.com/2014/07/pringle3.png','PRINGLES',2);
--Row 30
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://1000logos.net/wp-content/uploads/2017/05/Pepsi-Logo.png','PEPSI',1);
--Row 31
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://cdn.worldvectorlogo.com/logos/michelin-13.svg','MICHELIN',2);
--Row 32
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://i.ebayimg.com/00/s/Mjk3WDMwMA==/z/PyYAAOSwEppUOmMI/$_35.JPG?set_id=2','MERCEDES',3);
--Row 33
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Volkswagen_Logo_till_1995.svg/2000px-Volkswagen_Logo_till_1995.svg.png','WOLKSWAGEN',3);
--Row 34
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/08/vodafone-logo-2017.png','VODAFONE',5);
--Row 35
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2000px-Instagram_logo_2016.svg.png','INSTAGRAM',1);
--Row 36
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/08/WWF_logo1-880x704.png','WWF',4);
--Row 37
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Wikipedia-logo-v2.svg/1122px-Wikipedia-logo-v2.svg.png','WIKIPEDIA',2);
--Row 38
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logos-download.com/wp-content/uploads/2016/02/New_Balance_red_logo.png','NEW BALANCE',3);
--Row 39
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://seeklogo.com/images/H/honda-logo-CA469AE008-seeklogo.com.png','HONDA',4);
--Row 40
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://1000logos.net/wp-content/uploads/2017/03/LG-Symbol.jpg','LG',3);
--Row 41
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://seeklogo.com/images/M/MSN_Boneco-logo-E03520C5F2-seeklogo.com.jpg','MSN',3);
--Row 42
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/06/Lexus-logo.png','LEXUS',5);
--Row 43
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://media-2.web.britannica.com/eb-media/34/128734-050-2AF822A1.jpg','MOTOROLA',4);
--Row 44
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://marque-voiture.com/wp-content/uploads/2015/10/logo-SEAT.png','SEAT',4);
--Row 45
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://watermann-zink.de/wp-content/uploads/2017/05/ALLIANZ-LOGO-1.png','ALLIANZ',5);
--Row 46
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://seeklogo.com/images/L/Linux_Tux-logo-DA252F3C21-seeklogo.com.png','LINUX',4);
--Row 47
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Windows_logo_-_2012.svg/2000px-Windows_logo_-_2012.svg.png','WINDOWS',1.0);
--Row 48
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://searchlite.nl/wp-content/uploads/2017/08/java-logo-large.png','JAVA',3);
--Row 49
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/08/Unilever-logo-880x660.png','UNILEVER',4);
--Row 50
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://s-media-cache-ak0.pinimg.com/originals/cf/6c/07/cf6c0722698268a7a2b0548d6431d70b.jpg','RYANAIR',3);
--Row 51
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.footballfrance.fr/wp-content/uploads/2013/12/Uncle-Bens-%D0%BF%D0%B5%D1%81%D0%BE%D1%87%D0%BD%D0%B8%D1%86%D0%B0-165618.jpeg','UNCLE BENS',3);
--Row 52
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://socialwall.bnpparibascardif.com/img/logo_social_wall.png','BNP PARIBAS',2);
--Row 53
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://1000logos.net/wp-content/uploads/2016/10/Bluetooth-Logo.png','BLUETOOTH',1);
--Row 54
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/en/thumb/7/70/Chanel_logo-no_words.svg/1280px-Chanel_logo-no_words.svg.png','CHANEL',1);
--Row 55
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://www.downloadbestnow.com/wp-content/uploads/2017/06/McAfee-Stinger-12.png','MCAFEE',5);
--Row 56
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://pegatineando.com/image/cache/data/lib%202/Monster-Energy-Logo-green-300-500x500.jpg','MONSTER',1);
--Row 57
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://chance-magazine.com/wp-content/uploads/2014/07/td-amazon-smile-logo-01-large.jpg','AMAZON',2);
--Row 58
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://botw-pd.s3.amazonaws.com/styles/logo-thumbnail/s3/0010/9610/brand.gif?itok=YOtht_TQ','KAPPA',3);
--Row 59
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://cdn2.bigcommerce.com/server1500/ac84d/products/597/images/1281/SPO-ROX-003d__02211.1315626817.380.380.jpg?c=2','ROXY',2);
--Row 60
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.geekchicelite.com/wp-content/uploads/2013/04/lcas.png','LUCASARTS',5);
--Row 61
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.car-brand-names.com/wp-content/uploads/2016/03/Suzuki-logo.png','SUZUKI',3);
--Row 62
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.logosquizanswers.com/wp-content/uploads/2015/07/logo-quiz-2-two-answers-level-27-5-malibu-300x300.png','MALIBU',4);
--Row 63
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://www.kaceto.net/IMG/jpg/total.jpg','TOTAL',1);
--Row 64
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.carlogos.org/logo/Rolls-Royce-RR-logo-1920x1080.png','ROLLS ROYCE',5);
--Row 65
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.car-brand-names.com/wp-content/uploads/2016/02/Skoda-logotype.png','SKODA',3);
--Row 66
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.carlogos.org/logo/Bentley-logo.png','BENTLEY',4);
--Row 67
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Logo_NIKE.svg/2000px-Logo_NIKE.svg.png','NIKE',1);
--Row 68
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://botw-pd.s3.amazonaws.com/styles/logo-thumbnail/s3/0022/2378/brand.gif?itok=wN7gYdiz','ABARTH',5);
--Row 69
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://moziru.com/images/louis-vuitton-clipart-20.jpg','LOUIS VUITON',2);
--Row 71
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://s3.amazonaws.com/cms.ipressroom.com/226/files/201411/549b3a18f6091d6e11000002_DD_Logo_Cup/DD_Logo_Cup_db80915b-dfdd-41e1-b21d-e5f9d8d5ba0f-prv.jpg','DUNKINN DONUTS',3);
--Row 72
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.brandchannel.com/wp-content/uploads/2016/04/dreamworks-logo-2016.jpg','DREAMWORKS',2);
--Row 73
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.logosquizwalkthrough.com/images/meeyo/cartoon-network.jpg','CARTOON NETWORKS',3);
--Row 74
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.brandlogos.top/images/brands/shoes/timberland/timberland-iron-on-wall-stickers-02.jpg','TIMBERLAND',2);
--Row 75
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://vignette.wikia.nocookie.net/clashroyale/images/4/4c/Clash-of-clans-logo.png/revision/latest?cb=20170202201008&path-prefix=fr','CLASH OF CLANS',5);
--Row 76
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://i.ytimg.com/vi/eVoNXE0kQQg/maxresdefault.jpg','PUMA',1);
--Row 77
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/d/df/Logo_R_Rossignol.jpg','ROSSIGNOL',3);
--Row 78
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkQE0wzc6nTr_-JdhVQt4cYC_qEEX1FjwTtDWijt1J0FxhBKLW','CISCO',5);
--Row 79
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://joyana.fr/wp-content/uploads/2009/09/TOGS_UNLIMITED_CHEVIGNON1.jpg','CHEVIGNON',4);
--Row 80
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.incoreinsightlytics.com/wp-content/uploads/2017/05/BP-Logo.png','BP',2);
--Row 81
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.precieuxsang.be/wp-content/uploads/2016/07/logo-mr-propre.png.9aeadba0d4453116b4015eb5ab425287-e1467896763554.png','MONSIEUR PROPRE',1);
--Row 82
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://seeklogo.com/images/P/pokerstars-logo-4D58E5168B-seeklogo.com.png','POKERSTARS',4);
--Row 83
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://images.complex.com/complex/image/upload/c_fill,g_center,w_1200/fl_lossy,pg_1,q_auto/pi4xaw61ntrfizycciki.jpg','REEBOK',2);
--Row 84
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://www.quizz.biz/uploads/quizz/661723/19_daFyU.jpg','MIKO',3);
--Row 85
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://pbs.twimg.com/profile_images/922883573279059969/5QUZd4rC_400x400.jpg','TURKISH AIRLINES',5);
--Row 86
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://t7.rbxcdn.com/c17d1e711b60d5184d4cb47ae6842554','LUFTHANSA',4);
--Row 87
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://is2-ssl.mzstatic.com/image/thumb/Purple118/v4/57/54/24/575424da-e55e-34b4-13c5-a4bc4d96d23d/mzl.ewjdxxsk.png/600x600bf.jpg','VOLOTEA',5);
--Row 88
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://www.royalcaribbean.com/content/royal/US/en_US/_jcr_content/header/nav-definition/mainMenu/submenu-2/item-3/img.img.jpg/1493736715923.jpg','ROYAL CARIBBEAN',5);
--Row 89
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://thecraftchop.com/files/images/castle-lines.svg','WALT DISNEY',1);
--Row 90
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Xbox_one_logo.svg/600px-Xbox_one_logo.svg.png','XBOX',1);
--Row 91
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://create.adobe.com/content/microsites/inspire/en/2017/8/25/what_you_can_learn_from_the_evolution_of_the_nbc_logo_/_jcr_content/article-body/image_caption_side_4/image1.img.jpg/1503701674167.jpg','NBC',3);
--Row 92
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://consumer-res.huawei.com/etc/designs/huawei-cbg-site/images/common/bg1000_860.png','HUAWEI',3);
--Row 93
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://hypb.imgix.net/image/2018/02/nike-michael-jordan-jumpman-logo-lawsuit-1.jpg?q=75&w=800&fit=max&auto=compress%2Cformat','JORDAN',4);
--Row 94
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://cdnjs.cloudflare.com/ajax/libs/browser-logos/45.3.0/archive/aol-explorer/aol-explorer.png','AOL',3);
--Row 95
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.carlogos.org/logo/Audi-emblem-2016-black-1920x1080.png','AUDI',3);
--Row 96
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://i.ebayimg.com/images/g/1MYAAOSwls5Y54rS/s-l300.jpg','MASERATI',4);
--Row 97
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/10/Expedia-logo-219x286.png','EXPEDIA',4);
--Row 98
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.stickpng.com/assets/images/580b585b2edbce24c47b2cbf.png','SUBARU',3);
--Row 99
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/11/Polaroid-logo-880x625.png','POLAROID',3);
--Row 100
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://logok.org/wp-content/uploads/2014/11/Johnnie-Walker-Logo-880x660.png','JOHNNIE WALKER',5);
--Row 101
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'http://www.logosquizwalkthrough.com/images/bubble/paramount-pictures.jpg','PARAMOUNT',4);
--Row 102
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://lezebre.lu/images/detailed/18/Piaggio_Logo3.png','PIAGGIO',4);
--Row 103
INSERT INTO LOGO (ID_LOGO, LIEN_LOGO, REPONSE, ID_COLLECTION) VALUES (SEQ_LOGO_ID_LOGO.nextval,'https://i.pinimg.com/originals/ea/48/b2/ea48b28afcff0c311205d1c67d7010e7.png','PUNSHER',5);
