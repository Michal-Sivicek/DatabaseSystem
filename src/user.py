from connection import *
from comm_method import *

class User:

    def __init__(self):
        """
        Constructor
        """
        self.mydb = Connection.mydb
        self.comm = CommMethod()

    def menu(self):
        """
        Menu
        :param self:
        :return: NONE
        """""
        # Výběr akce
        print("--------------Vyberte si možnost v menu--------------")
        print("Výběr akce:")
        print("1: Vložení zaměstnavatele")
        print("2: Smazání zaměstnavatele")
        print("3: Úprava zaměstnavatele")
        print("4: Vložení dat zákazníka a objednávky")
        print("5: Přidání produktu")
        print("6: Přidání kategorie")
        print("7: Výpis objednávek se jmény")
        print("8: Výpis objednávek s detaily")
        print("9: Výpis součtu objednávek podle adresy")
        print("10: Import CSV dat")
        print("11: Konec")
        print("--------------Konec menu --------------")
        choice = input("Zvolte akci (1/2/3/4/5/6/7/8/9/10/11): ")

        if choice == '1':
            name = input("Zadejte jméno: ")
            address = input("Zadejte adresu: ")
            establishment_date = input("Zadejte datum založení (YYYY-MM-DD): ")
            self.comm.insert_employer(name, address, establishment_date)
        elif choice == '2':
            id = input("Zadejte ID zaměstnavatele: ")
            self.comm.delete_employer(id)
        elif choice == '3':
            id = input("Zadejte ID zaměstnavatele: ")
            name = input("Zadejte jméno: ")
            address = input("Zadejte adresu: ")
            establishment_date = input("Zadejte datum založení (YYYY-MM-DD): ")
            self.comm.update_employer(id, name, address, establishment_date)
        elif choice == '4':
            self.comm.insert_data()
        elif choice == '5':
            name = input("Zadejte název produktu: ")
            description = input("Zadejte popis produktu: ")
            price = input("Zadejte cenu produktu: ")
            stock = input("Zadejte jestli je nebo není na skladě: ")
            category_id = input("Zadejte ID kategorie: ")
            val = (name, description, price, stock, category_id)
            self.comm.insert_product(name, price, description, stock, category_id)
        elif choice == '6':
            name = input("Zadejte název kategorie: ")
            self.comm.insert_category(name)
        elif choice == '7':
            self.comm.objednavky_se_jmeny()
        elif choice == '8':
            self.comm.objednavky_s_detaily()
        elif choice == '9':
            self.comm.soucet_podle_adresy()
        elif choice == '10':
            self.comm.import_csv()
        elif choice == '11':
            print("Konec")
            exit()
        else:
            print("Neplatná volba.")
        continue_menu = input("Chcete pokračovat v menu? (ano/ne): ")
        if continue_menu == 'ano':
            self.menu()

