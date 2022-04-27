using System;

namespace AddressBookSystem_ADO.NET
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Welcome to AddressBookSystem using Ado.net");
            AddressBookRepo addressBookRepo = new AddressBookRepo();
            AddressBookModel addressBookModel = new AddressBookModel();
            addressBookModel.FirstName = "PREM";
            addressBookModel.LastName = "KUMAR";
            addressBookModel.Address = "Salanuthala,konakana metla";
            addressBookModel.City = "Ongole";
            addressBookModel.State = "AndhraPradesh";
            addressBookModel.Zip = 523241;
            addressBookModel.PhoneNo = 7206594149;
            addressBookModel.Email = "mabbupremkumar@gmail.com";
            addressBookModel.AddressBookName = "friend address book";
            addressBookModel.AddressBookType = "Friend";
            addressBookRepo.checkConnection();
            addressBookRepo.addNewContactToDataBase(addressBookModel);
        }
    }
}

