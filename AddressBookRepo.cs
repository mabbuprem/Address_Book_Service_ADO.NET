﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AddressBookSystem_ADO.NET
{
    class AddressBookRepo
    {
        public static string connectionString = @"Data Source=(localdb)\MSSQLLocalDB; Initial Catalog =Address_Book_Service; Integrated Security = True;";
        SqlConnection connection = new SqlConnection(connectionString);
        public void checkConnection()
        {
            try
            {
                this.connection.Open();
                Console.WriteLine("connection established");
                this.connection.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.StackTrace);
            }
        }
    }
}