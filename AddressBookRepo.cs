using System;
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
        public bool addNewContactToDataBase(AddressBookModel addressBookModel)
        {
            try
            {
                using (this.connection)
                {
                    SqlCommand cmd = new SqlCommand("SpAddAddressBookDetail", this.connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FirstName", addressBookModel.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", addressBookModel.LastName);
                    cmd.Parameters.AddWithValue("@Address", addressBookModel.Address);
                    cmd.Parameters.AddWithValue("@City", addressBookModel.City);
                    cmd.Parameters.AddWithValue("@State", addressBookModel.State);
                    cmd.Parameters.AddWithValue("@Zip", addressBookModel.Zip);
                    cmd.Parameters.AddWithValue("@PhoneNo", addressBookModel.PhoneNo);
                    cmd.Parameters.AddWithValue("@Email", addressBookModel.Email);
                    cmd.Parameters.AddWithValue("@AddressBookName", addressBookModel.AddressBookName);
                    cmd.Parameters.AddWithValue("@AddressBookType", addressBookModel.AddressBookType);
                    this.connection.Open();
                    var result = cmd.ExecuteNonQuery();
                    this.connection.Close();
                    if (result != 0)
                    {
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
            finally
            {
                this.connection.Close();
            }
        }
    }
}
