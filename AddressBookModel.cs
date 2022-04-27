using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AddressBookSystem_ADO.NET
{
    public class AddressBookModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public int Zip { get; set; }
        public double PhoneNo { get; set; }
        public string Email { get; set; }
        public string AddressBookName { get; set; }
        public string AddressBookType { get; set; }
    }
}