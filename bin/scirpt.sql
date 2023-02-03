create database eshop;
use eshop;


-- Název: Databázový sytém (databázová aplikace pro správu databáze)
-- Jméno a příjmení: Michal Siviček
-- Datum vypracování: 3.2.2023
-- Škola: Střední průmyslová škola elektrotechnická, Praha 2, Ječná 30
-- Třída: C4c
-- Jedná se o školní projekt 


SET @@SQL_SAFE_UPDATES = 0;
select @@AUTOCOMMIT;
SET @@AUTOCOMMIT = 0;

begin;
CREATE TABLE zamestnavatele (
  id INT AUTO_INCREMENT PRIMARY KEY,
  jmeno VARCHAR(255) NOT NULL,
  adresa VARCHAR(255) NOT NULL,
  datum_zalozeni DATETIME NOT NULL
);

CREATE TABLE zakaznici (
  id INT AUTO_INCREMENT PRIMARY KEY,
  jmeno VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  telefon VARCHAR(255) NOT NULL,
  adresa VARCHAR(255) NOT NULL
);

CREATE TABLE kategorie (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nazev VARCHAR(255) NOT NULL
);

CREATE TABLE produkty (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nazev VARCHAR(255) NOT NULL,
  popis TEXT NOT NULL,
  cena FLOAT NOT NULL,
  skladem BOOL NOT NULL,
  kategorie_id INT NOT NULL,
  FOREIGN KEY (kategorie_id) REFERENCES kategorie(id)
);

CREATE TABLE objednavky (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mnozstvi INT NOT NULL,
  zakaznik_id INT NOT NULL,
  zamestnanec_id INT NOT NULL,
  produkty_id INT NOT NULL,
  datum_objednavky DATETIME NOT NULL,
  FOREIGN KEY (produkty_id) REFERENCES produkty(id),
  FOREIGN KEY (zakaznik_id) REFERENCES zakaznici(id),
  FOREIGN KEY (zamestnanec_id) REFERENCES zamestnavatele(id)
);
commit;

-- Záznamy v tabulce zamestnavatele
begin;
INSERT INTO zamestnavatele (jmeno, adresa, datum_zalozeni) VALUES
('Jan Novák', 'Hlavní 1, Praha', '2021-01-01'),
('Petra Nováková', 'Vedlejší 2, Brno', '2020-02-01'),
('Tomáš Nový', 'Druhá 3, Ostrava', '2019-03-01');
commit;
-- Záznamy v tabulce zakaznici
begin;
INSERT INTO zakaznici (jmeno, email, telefon, adresa) VALUES
('Michal Novotný', 'mnovotny@email.com', '+420777888999', 'Praha 1, Nové Město'),
('Lucie Novotná', 'lnovotna@email.com', '+420333222333', 'Brno 2, Židenice'),
('Adam Nový', 'anovy@email.com', '+420511332211', 'Ostrava 3, Poruba');
commit;
-- Záznamy v tabulce kategorie
begin;
INSERT INTO kategorie (nazev) VALUES
('Elektronika'),
('Oblečení'),
('Sport');
commit;
-- Záznamy v tabulce produkty
begin;
INSERT INTO produkty (nazev, popis, cena, skladem, kategorie_id) VALUES
('iPhone X', 'Smartphone od Applu', 7999, 1, 1),
('Nike Air Max', 'Obuv pro sportovce', 3999, 1, 3),
('Adidas T-shirt', 'Sportovní tričko', 799, 1, 3),
('Samsung Galaxy S21', 'Smartphone od Samsungu', 8999, 1, 1);
commit;
-- Záznamy v tabulce objednavky
begin;
INSERT INTO objednavky (mnozstvi, zakaznik_id, zamestnanec_id, produkty_id, datum_objednavky) VALUES
(2, 2, 2, 4, '2022-01-01 10:00:00'),
(1, 2, 2, 2, '2021-01-01 10:00:00'),
(3, 3, 3, 3, '2022-02-03 10:00:00');
commit;

begin;
CREATE VIEW objednavky_s_jmeny AS
SELECT objednavky.id, zakaznici.jmeno AS jmeno_zakaznika, zamestnavatele.jmeno AS jmeno_zamestnance, produkty.nazev AS nazev_produktu, objednavky.mnozstvi, objednavky.datum_objednavky
FROM objednavky
JOIN zakaznici ON objednavky.zakaznik_id = zakaznici.id
JOIN zamestnavatele ON objednavky.zamestnanec_id = zamestnavatele.id
JOIN produkty ON objednavky.produkty_id = produkty.id;
commit;

select * from objednavky_s_jmeny;

begin;
CREATE VIEW objednavky_s_detaily AS
SELECT objednavky.id AS objednavka_id, zakaznici.jmeno AS zakaznik, zamestnavatele.jmeno AS zamestnanec, produkty.nazev AS produkt, objednavky.mnozstvi, objednavky.datum_objednavky
FROM objednavky
JOIN zakaznici ON objednavky.zakaznik_id = zakaznici.id
JOIN zamestnavatele ON objednavky.zamestnanec_id = zamestnavatele.id
JOIN produkty ON objednavky.produkty_id = produkty.id;
commit;

select * from objednavky_s_detaily;

begin;
CREATE VIEW soucet_podle_adresy AS
SELECT zakaznici.adresa, SUM(produkty.cena * objednavky.mnozstvi) AS soucet_nakupu
FROM objednavky
JOIN zakaznici ON objednavky.zakaznik_id = zakaznici.id
JOIN produkty ON objednavky.produkty_id = produkty.id
GROUP BY zakaznici.adresa;
commit;

SELECT * FROM soucet_podle_adresy;

begin;
create user "admin2"@"%" identified by "admin123";
GRANT all privileges on eshop.* to "admin2"@"%";
commit;





