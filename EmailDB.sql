-- SETUP THE DATABASE

drop database if exists EmailDB;
create database EmailDB;
use EmailDB;

-- CREATE THE DATABASE TABLES

CREATE TABLE `User`(
    userID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    username VARCHAR(15) NOT NULL,
    password VARCHAR(128) NOT NULL,
    email VARCHAR(255) NOT NULL,
    avi VARCHAR(255)
);

CREATE TABLE EmailGroup(
    groupID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TINYTEXT NOT NULL
);

CREATE TABLE UserGroups(
    userGroupID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    groupID INT NOT NULL,
    FOREIGN KEY(userID) REFERENCES `User`(userID),
    FOREIGN KEY(groupID) REFERENCES EmailGroup(groupID)

);

CREATE TABLE Email(
    emailID BIGINT PRIMARY KEY AUTO_INCREMENT,
    subject TINYTEXT,
    message TEXT NOT NULL,
    attachment VARCHAR(255)
);

CREATE TABLE EmailTransfer(
    transferID BIGINT PRIMARY KEY AUTO_INCREMENT,
    emailID BIGINT NOT NULL,
    senderID INT NOT NULL,
    recipientID INT,
    groupID INT,
    dateSent DATETIME DEFAULT CURRENT_TIMESTAMP,
    readStatus ENUM('0', '1') DEFAULT '0',
    FOREIGN KEY(emailID) REFERENCES Email(emailID),
    FOREIGN KEY(senderID) REFERENCES `User`(userID),
    FOREIGN KEY(recipientID) REFERENCES `User`(userID),
    FOREIGN KEY(groupID) REFERENCES EmailGroup(groupID)
);

CREATE TABLE FAVORITES(
    favoriteID BIGINT PRIMARY KEY AUTO_INCREMENT,
    favoriterID INT NOT NULL,
    transferID BIGINT NOT NULL,
    FOREIGN KEY(favoriterID) REFERENCES `User`(userID),
    FOREIGN KEY(transferID) REFERENCES EmailTransfer(transferID)
);

CREATE TABLE TRASH(
    trashID BIGINT PRIMARY KEY AUTO_INCREMENT,
    trasherID INT NOT NULL,
    transferID BIGINT NOT NULL,
    FOREIGN KEY(trasherID) REFERENCES `User`(userID),
    FOREIGN KEY(transferID) REFERENCES EmailTransfer(transferID)
);

CREATE TABLE DELETED(
    deletedID BIGINT PRIMARY KEY AUTO_INCREMENT,
    deleterID INT NOT NULL,
    transferID BIGINT NOT NULL,
    FOREIGN KEY(deleterID) REFERENCES `User`(userID),
    FOREIGN KEY(transferID) REFERENCES EmailTransfer(transferID)
);

CREATE TABLE SPAM(
    spamID BIGINT PRIMARY KEY AUTO_INCREMENT,
    spammerID INT NOT NULL,
    transferID BIGINT NOT NULL,
    FOREIGN KEY(spammerID) REFERENCES `User`(userID),
    FOREIGN KEY(transferID) REFERENCES EmailTransfer(transferID)
);

CREATE TABLE DRAFTS(
    draftID BIGINT PRIMARY KEY AUTO_INCREMENT,
    drafterID INT NOT NULL,
    transferID BIGINT NOT NULL,
    FOREIGN KEY(drafterID) REFERENCES `User`(userID),
    FOREIGN KEY(transferID) REFERENCES EmailTransfer(transferID)
);