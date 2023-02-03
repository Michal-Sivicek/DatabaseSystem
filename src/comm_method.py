import csv
from connection import Connection


class CommMethod():

    def __init__(self):
        """
        Constructor
        """
        self.mydb = Connection.mydb


    # Funkce pro vložení nového zaměstnavatele
    def insert_employer(self,name, address, establishment_date):
        """
        Insert employer
        :param name: jmeno
        :param address: adresa
        :param establishment_date: datum zalozeni
        :return: NONE
        """
        try:
            self.mydb.start_transaction()
            mycursor = self.mydb.cursor()
            sql = "INSERT INTO zamestnavatele (jmeno, adresa, datum_zalozeni) VALUES (%s, %s, %s)"
            val = (name, address, establishment_date)
            mycursor.execute(sql, val)
            self.mydb.commit()
            print("Zaměstnavatel byl úspěšně vložen.")
        except:
            self.mydb.rollback()
            print("Něco se pokazilo")

    # Funkce pro smazání zaměstnavatele
    def delete_employer(self, id):
        """
       Delete employer
       :param id: id
       :return: NONE
       """
        try:
            self.mydb.start_transaction()
            mycursor = self.mydb.cursor()
            sql = "DELETE FROM zamestnavatele WHERE id = %s"
            val = (id,)
            mycursor.execute(sql, val)
            self.mydb.commit()
            print("Zaměstnavatel byl úspěšně smazán.")
        except:
            self.mydb.rollback()
            print("Něco se pokazilo")


    # Funkce pro úpravu zaměstnavatele
    def update_employer(self, id, name, address, establishment_date):
        """
        Update employer
        :param id: ID
        :param name: jmeno
        :param address: adresa
        :param establishment_date: datum zalozeni
        :return: NONE
        """
        try:
            self.mydb.start_transaction()
            mycursor = self.mydb.cursor()
            sql = "UPDATE zamestnavatele SET jmeno = %s, adresa = %s, datum_zalozeni = %s WHERE id = %s"
            val = (name, address, establishment_date, id)
            mycursor.execute(sql, val)
            self.mydb.commit()
            print("Zaměstnavatel byl úspěšně upraven.")
        except:
            self.mydb.rollback()
            print("Něco se pokazilo")


    #pridani produktu
    def insert_product(self, name, price, description,stock,category_id):
        """
        Insert product
        :param name: jmeno
        :param price: cena
        :param description: popis
        :param stock: skladem
        :param category_id: kategorie_id
        :return: NONE
        """
        try:
            self.mydb.start_transaction()
            mycursor = self.mydb.cursor()
            sql = "INSERT INTO produkty (nazev, popis, cena, skladem, kategorie_id) VALUES (%s, %s, %s, %s, %s)"
            val = (name, description, price, stock, category_id)
            mycursor.execute(sql, val)
            self.mydb.commit()
            print("Produkt byl úspěšně vložen.")
        except:
            self.mydb.rollback()
            print("Něco se pokazilo")

    #pridani kategorie
    def insert_category(self, name):
        """
        Insert category
        :param name: jmeno
        :return: NONE
        """
        try:
            self.mydb.start_transaction()
            mycursor = self.mydb.cursor()
            sql = "INSERT INTO kategorie (nazev) VALUES (%s)"
            val = (name,)
            mycursor.execute(sql, val)
            self.mydb.commit()
            print("Kategorie byla úspěšně vložena.")
        except:
            self.mydb.rollback()
            print("Něco se pokazilo")

    # Funkce pro vložení nového zákazníka a objednávky
    def insert_data(self):
        """
        Insert data
        :return: NONE
        """
        try:
            self.mydb.start_transaction()
            mycursor = self.mydb.cursor()
            name = input("Zadejte jméno: ")
            email = input("Zadejte email: ")
            phone = input("Zadejte telefon: ")
            address = input("Zadejte adresu: ")
            establishment_date = input("Zadejte datum založení (YYYY-MM-DD): ")
            sql = "INSERT INTO zakaznici (jmeno, email, telefon, adresa) VALUES (%s, %s, %s, %s)"
            val = (name, email, phone, address)
            mycursor.execute(sql, val)
            print("Zákazník byl úspěšně vložen.")
            quantity = input("Zadejte množství: ")
            customer_id = mycursor.lastrowid
            employer_id = mycursor.lastrowid
            product_id = input("Zadejte ID produktu: ")
            order_date = input("Zadejte datum objednání (YYYY-MM-DD): ")
            sql = "INSERT INTO objednavky (mnozstvi, zakaznik_id, zamestnanec_id, produkty_id, datum_objednavky) VALUES (%s, %s, %s, %s, %s)"
            val = (quantity, customer_id, employer_id, product_id, order_date)
            mycursor.execute(sql, val)
            self.mydb.commit()
            print("Objednávka byla úspěšně vložena.")
        except:
            self.mydb.rollback()
            print("Něco se pokazilo")

    def objednavky_se_jmeny(self):
            """
            Objednavky se jmeny
            :return: NONE
            """
            mycursor = self.mydb.cursor()
            sql = "select * from objednavky_s_jmeny;"
            mycursor.execute(sql)
            result = mycursor.fetchall()
            mycursor.close()
            print("Objednávky s jmeny:")
            for row in result:
                print("Objednávka ID:", row[0], "Zákazník:", row[1], "Zaměstnanec:", row[2], "Datum objednávky:", row[3])

    def objednavky_s_detaily(self):
            """
            Objednavky s detaily
            :return: NONE
            """
            mycursor = self.mydb.cursor()
            sql = "select * from objednavky_s_detaily;"
            mycursor.execute(sql)
            result = mycursor.fetchall()
            mycursor.close()
            print("Objednávky s detaily:")
            for row in result:
                print("Objednávka ID:", row[0], "Zákazník:", row[1], "Zaměstnanec:", row[2], "Produkt:", row[3],
                      "Množství:", row[4], "Datum objednávky:", row[5])

    def soucet_podle_adresy(self):
            """
            Součet podle adresy
            :return: NONE
            """
            mycursor = self.mydb.cursor()
            sql = "select * from soucet_podle_adresy;"
            mycursor.execute(sql)
            result = mycursor.fetchall()
            mycursor.close()
            print("Součet objednávek podle adresy:")
            for row in result:
                print("Adresa:", row[0], "Celková cena:", row[1])

    def import_csv(self):
        """
        Import CSV
        :return: NONE
        """
        file_name = input("Zadejte název CSV souboru (případně cestu k souboru): ")
        with open(file_name, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                print(row['jmeno'], row['adresa'], row['datum_zalozeni'])
                self.insert_employer(row['jmeno'], row['adresa'], row['datum_zalozeni'])

