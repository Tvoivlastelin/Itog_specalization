CREATE DATABASE `Друзья человека`;

USE `Друзья человека`;
CREATE TABLE IF NOT EXISTS `Животные` (
id INT PRIMARY KEY AUTO_INCREMENT,
animal_function VARCHAR(255));

INSERT INTO `Животные` (animal_function)
VALUES 
  ('домашние животные'),
  ('вьючные животные');
  
SELECT * FROM `Животные`;

CREATE TABLE IF NOT EXISTS `домашние животные` (
home_id INT PRIMARY KEY,
home_main_id INT,
count INT,
home_animal_name VARCHAR(255),
FOREIGN KEY (`home_main_id`) REFERENCES `Животные` (`id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `домашние животные` (home_id, home_main_id, count, home_animal_name)
VALUES 
  (1, 1, 1,'хомяк'),
  (2, 1, 2,'кошка'),
  (3, 1, 2,'собака');  
  
SELECT * FROM `домашние животные`;

CREATE TABLE IF NOT EXISTS `вьючные животные` (
pack_id INT PRIMARY KEY,
pack_main_id INT,
count INT,
pack_animal_name VARCHAR(255),
FOREIGN KEY (`pack_main_id`) REFERENCES `Животные` (`id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `вьючные животные` (pack_id, pack_main_id, count, pack_animal_name)
VALUES 
  (1, 2, 1,'лошадь'),
  (2, 2, 1,'верблюд'),
  (3, 2, 2,'осел');  
  
SELECT * FROM `вьючные животные`;

CREATE TABLE IF NOT EXISTS `хомяки` (
id_animal INT AUTO_INCREMENT PRIMARY KEY,
animal_home_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_home_id`) REFERENCES `домашние животные` (`home_id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `хомяки` (animal_home_id, animal_name, command, birth_date)
VALUES 
  (1, 'щекан', 'STOP','2021-06-01');  
  
SELECT * FROM `хомяки`;

CREATE TABLE IF NOT EXISTS `кошки` (
id_animal INT AUTO_INCREMENT PRIMARY KEY,
animal_home_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_home_id`) REFERENCES `домашние животные` (`home_id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `кошки` (animal_home_id, animal_name, command, birth_date)
VALUES 
  (2, 'мурзик', 'RUN_AWAY','2021-03-19'),
  (2, 'барсик', 'GO', '2016-07-22');  
  
SELECT * FROM `кошки`;

CREATE TABLE IF NOT EXISTS `собаки` (
id_animal INT AUTO_INCREMENT PRIMARY KEY,
animal_home_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_home_id`) REFERENCES `домашние животные` (`home_id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `собаки` (animal_home_id, animal_name, command, birth_date)
VALUES 
  (3, 'шарик', 'RUN_AWAY','2021-03-12'),
  (3, 'джек', 'JUMP', '2010-07-30');  
  
SELECT * FROM `собаки`;

CREATE TABLE IF NOT EXISTS `лошади` (
id_animal INT AUTO_INCREMENT PRIMARY KEY,
animal_pack_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_pack_id`) REFERENCES `вьючные животные` (`pack_id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `лошади` (animal_pack_id, animal_name, command, birth_date)
VALUES 
  (1, 'скакун', 'JUMP', '2009-12-15');  
  
SELECT * FROM `лошади`;

CREATE TABLE IF NOT EXISTS `верблюды` (
id_animal INT AUTO_INCREMENT PRIMARY KEY,
animal_pack_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_pack_id`) REFERENCES `вьючные животные` (`pack_id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `верблюды` (animal_pack_id, animal_name, command, birth_date)
VALUES 
  (2, 'горбик', 'GO', '2019-11-18');  
  
SELECT * FROM `верблюды`;

CREATE TABLE IF NOT EXISTS `ослы` (
id_animal INT AUTO_INCREMENT PRIMARY KEY,
animal_pack_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_pack_id`) REFERENCES `вьючные животные` (`pack_id`) ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO `ослы` (animal_pack_id, animal_name, command, birth_date)
VALUES 
  (3, 'иа', 'STAND_UP', '2022-10-18');  
  
SELECT * FROM `ослы`;

-- Удаление таблицы верблюды
DROP TABLE IF EXISTS `верблюды`;

-- Создание новой таблицы для объединения лошадей и ослов
CREATE TABLE IF NOT EXISTS `лошади_и_ослы` (
new_id_animal INT AUTO_INCREMENT PRIMARY KEY,
old_id_animal INT,
animal_pack_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
FOREIGN KEY (`animal_pack_id`) REFERENCES `вьючные животные` (`pack_id`) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Вставка данных из таблицы лошадей в новую таблицу
INSERT INTO `лошади_и_ослы` (old_id_animal, animal_pack_id, animal_name, command, birth_date) SELECT id_animal, animal_pack_id, animal_name, command, birth_date FROM `лошади`;

-- Вставка данных из таблицы ослов в новую таблицу
INSERT INTO `лошади_и_ослы` (old_id_animal, animal_pack_id, animal_name, command, birth_date) SELECT id_animal, animal_pack_id, animal_name, command, birth_date FROM `ослы`;

-- Просмотр данных из новой таблицы
SELECT * FROM `лошади_и_ослы`;

-- Создание новой таблицы для молодых животных
CREATE TABLE IF NOT EXISTS `молодые животные` (
new_id_animal INT AUTO_INCREMENT PRIMARY KEY,
old_id_animal INT,
animal_home_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
age_months INT,
FOREIGN KEY (`animal_home_id`) REFERENCES `домашние животные` (`home_id`) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO `молодые животные` (old_id_animal, animal_home_id, animal_name, command, birth_date, age_months)
SELECT id_animal, animal_home_id, animal_name, command, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE())
FROM (
    SELECT * FROM `хомяки`
    UNION ALL
    SELECT * FROM `кошки`
    UNION ALL
    SELECT * FROM `собаки`
    UNION ALL
    SELECT * FROM `лошади`
    UNION ALL
    SELECT * FROM `ослы`
) AS animals
WHERE TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) >= 12 AND TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) <= 36;

-- Просмотр данных из новой таблицы
SELECT * FROM `молодые животные`;

-- Создание новой таблицы для объединения всех животных
CREATE TABLE IF NOT EXISTS `все_животные` (
new_id_animal INT AUTO_INCREMENT PRIMARY KEY,
old_id_animal INT,
animal_home_id INT,
animal_name VARCHAR(255),
command VARCHAR(255),
birth_date DATE,
age_months INT,
origin_table VARCHAR(255),
FOREIGN KEY (`animal_home_id`) REFERENCES `домашние животные` (`home_id`) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Вставка данных из других таблиц в новую таблицу
INSERT INTO `все_животные` (old_id_animal, animal_home_id, animal_name, command, birth_date, age_months, origin_table)
SELECT id_animal, animal_home_id, animal_name, command, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()), 'хомяки'
FROM `хомяки`
UNION ALL
SELECT id_animal, animal_home_id, animal_name, command, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()), 'кошки'
FROM `кошки`
UNION ALL
SELECT id_animal, animal_home_id, animal_name, command, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()), 'собаки'
FROM `собаки`
UNION ALL
SELECT id_animal, animal_pack_id, animal_name, command, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()), 'лошади'
FROM `лошади`
UNION ALL
SELECT id_animal, animal_pack_id, animal_name, command, birth_date, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()), 'ослы'
FROM `ослы`;

-- Просмотр данных из новой таблицы
SELECT * FROM `все_животные`;
