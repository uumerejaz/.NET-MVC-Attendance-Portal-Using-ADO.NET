using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Attendance.Models;
using Attendance.DAL;
using System.Web.Mvc;

namespace Attendance.DAL
{
    public class AdminDB
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
        public List<Admin> ListAll()
        {
            List<Admin> lst = new List<Admin>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("SelectAllAttendance", con);
                com.CommandType = CommandType.StoredProcedure;
                SqlDataReader rdr = com.ExecuteReader();
                while (rdr.Read())
                {
                    lst.Add(new Admin()
                    {
                        UserID = Convert.ToInt32(rdr["UserID"]),
                        Name = rdr["Name"].ToString(),
                        Date = rdr["Date"].ToString(),
                        Checkin = rdr["Checkin"].ToString(),
                        Checkout = rdr["Checkout"].ToString(),
                        ShortLeave = Convert.ToInt32(rdr["ShortLeave"]),
                    });
                }
                return lst;
            }
        }
    }
}