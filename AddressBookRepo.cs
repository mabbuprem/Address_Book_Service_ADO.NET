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
                throw new Exception(e.Message);
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
                    cmd.Parameters.AddWithValue("@PhoneNo", addressBookModel.PhoneNumber);
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
        public bool UpdateExiContactToDataBase(AddressBookModel addressBookModel, string firstName)
        {
            try
            {
                using (this.connection)
                {
                    string query = @"update Address_Book set last_name=@LastName,address=@Address,city=@City,
                    state=@State,zip=@Zip,phone_number=@PhoneNumber,email=@Email,address_book_name=@AddressBookName,
                    address_book_type=@AddressBookType  where first_name=@firstName";
                    SqlCommand cmd = new SqlCommand(query, this.connection);
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", addressBookModel.LastName);
                    cmd.Parameters.AddWithValue("@Address", addressBookModel.Address);
                    cmd.Parameters.AddWithValue("@City", addressBookModel.City);
                    cmd.Parameters.AddWithValue("@State", addressBookModel.State);
                    cmd.Parameters.AddWithValue("@Zip", addressBookModel.Zip);
                    cmd.Parameters.AddWithValue("@PhoneNumber", addressBookModel.PhoneNumber);
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
        public bool deleteExiContactInDataBase(string firstName)
        {
            try
            {
                using (this.connection)
                {
                    SqlCommand cmd = new SqlCommand("SpAddAddressBookDetailsForDelete", this.connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
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
        public void personBelongingCityOrState()
        {
            try
            {
                AddressBookModel addressBookModel = new AddressBookModel();
                using (this.connection)
                {
                    string query = @"select * from Address_Book where city='Ongole' Or state='AndhraPradesh';";
                    SqlCommand cmd = new SqlCommand(query, this.connection);
                    this.connection.Open();
                    SqlDataReader sqlDataReader = cmd.ExecuteReader();
                    if (sqlDataReader.HasRows)
                    {
                        while (sqlDataReader.Read())
                        {
                            addressBookModel.FirstName = sqlDataReader.GetString(0); ;
                            addressBookModel.LastName = sqlDataReader.GetString(1);
                            addressBookModel.Address = sqlDataReader.GetString(2);
                            addressBookModel.City = sqlDataReader.GetString(3);
                            addressBookModel.State = sqlDataReader.GetString(4);
                            addressBookModel.Zip = (int)sqlDataReader.GetInt64(5);
                            addressBookModel.PhoneNumber = sqlDataReader.GetInt64(6);
                            addressBookModel.Email = sqlDataReader.GetString(7);
                            addressBookModel.AddressBookName = sqlDataReader.GetString(8);
                            addressBookModel.AddressBookType = sqlDataReader.GetString(9);
                            Console.WriteLine("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9}", addressBookModel.FirstName, addressBookModel.LastName, addressBookModel.Address, addressBookModel.City, addressBookModel.State, addressBookModel.Zip, addressBookModel.PhoneNumber, addressBookModel.Email, addressBookModel.AddressBookName, addressBookModel.AddressBookType);
                            Console.WriteLine("\n");
                        }
                    }
                    else
                    {
                        Console.WriteLine("No Data Found");
                    }
                    sqlDataReader.Close();
                    this.connection.Close();
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
