-- 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”
USE humanFriends;

-- 8. Создать таблицы с иерархией из диаграммы в БД


CREATE TABLE cat (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE dog (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE humster (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE horse (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE camel (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE donkey (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE pets (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE animals (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

CREATE TABLE humanfriends (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR (50) NOT NULL,
Command VARCHAR (50) NOT NULL,
Birthday DATE NOT NULL
);

/* 9. Заполнить низкоуровневые таблицы именами(животных), командами 
которые они выполняют и датами рождения
*/

INSERT INTO cat (Name, Command, Birthday) VALUES
('Лили', 'Спасть', '2010-04-03'),
('Фая', 'Играть', '2023-05-04'),
('Муся', 'Есть', '2020-06-08'),
('Сурок', 'Спасть', '2022-01-03'),
('Мурка', 'Сидеть', '2019-02-03');

SELECT * FROM cat;

INSERT INTO dog (Name, Command, Birthday) VALUES
('Барбос', 'Спасть', '2010-04-03'),
('Долмат', 'Играть', '2023-05-04'),
('Коргян', 'Есть', '2020-06-08'),
('Барон', 'Лежать', '2022-01-03'),
('Лилу', 'Сидеть', '2019-02-03');

SELECT * FROM dog;

INSERT INTO humster (Name, Command, Birthday) VALUES
('Щекарь', 'Спасть', '2010-04-03'),
('Бонифаций', 'Играть', '2023-05-04'),
('Хомяк', 'Есть', '2020-06-08'),
('Мюнхгаузен', 'Лежать', '2022-01-03'),
('Пушок', 'Сидеть', '2019-02-03');

SELECT * FROM humster;

INSERT INTO horse (Name, Command, Birthday) VALUES
('Конь', 'Спасть', '2010-04-03'),
('Скакун', 'Играть', '2023-05-04'),
('Декабрь', 'Есть', '2020-06-08'),
('Январь', 'Лежать', '2022-01-03'),
('Февраль', 'Сидеть', '2019-02-03');

SELECT * FROM horse;

INSERT INTO camel (Name, Command, Birthday) VALUES
('Абу', 'Спасть', '2010-04-03'),
('Вася', 'Играть', '2023-05-04'),
('Хотабыч', 'Есть', '2020-06-08'),
('Громозека', 'Лежать', '2022-01-03'),
('Зина', 'Сидеть', '2019-02-03');

SELECT * FROM camel;

INSERT INTO donkey (Name, Command, Birthday) VALUES
('Тимоша', 'Спасть', '2010-04-03'),
('Асел', 'Играть', '2023-05-04'),
('Моисей', 'Есть', '2020-06-08'),
('Шалом', 'Лежать', '2022-01-03'),
('Иа', 'Сидеть', '2019-02-03');

SELECT * FROM donkey;
/* 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
*/

DELETE FROM camel
WHERE id > 0;
SELECT * FROM camel;

CREATE TABLE donkeyAndHorse (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name, 
        Command, 
        Birthday
FROM horse UNION 
SELECT  Name, 
        Command, 
        Birthday
FROM donkey;

SELECT * FROM donkeyAndHorse;

/*11.Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице
*/

CREATE TABLE youngAnimalsDraft (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT Name,
	   Command,
       Birthday
FROM donkeyAndHorse union
SELECT Name,
	   Command,
       Birthday
FROM dog union
SELECT Name,
	   Command,
       Birthday
FROM cat union
SELECT Name,
	   Command,
       Birthday
FROM humster;

create table youngAnimals (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
select Name, 
        Command, 
        Birthday,
        Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 2) as age
 from youngAnimalsDraft
 where Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 2) > 1 
 and Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 2) < 3;
select * from youngAnimals;    

/*12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
прошлую принадлежность к старым таблицам
*/

create table newhumanFriend (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
select  Name, 
        Command,
        Birthday,
        'cat' as oldTable
from cat union 
select  Name, 
        Command, 
        Birthday,
        'dog' as oldTable
from dog union
select  Name, 
        Command, 
        Birthday,
        'humster' as oldTable
from humster union 
select  Name, 
        Command, 
        Birthday,
        'horse' as oldTable
from horse union 
select  Name, 
        Command, 
        Birthday,
        'donkey' as oldTable
from donkey;

select * from newhumanFriend;