using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Attendance.Models;
using System.Web.Mvc;

namespace Attendance.DAL
{
    public class SignupDB
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        public Signup Add (Signup Obj)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("Signup", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Name", Obj.Name);
                com.Parameters.AddWithValue("@Email", Obj.Email);
                com.Parameters.AddWithValue("@Password", Obj.Password);
                SqlDataReader rdr = com.ExecuteReader();
                while (rdr.Read())
                {
                    Obj.Message = rdr["msg"].ToString();
                    Obj.ID = Convert.ToInt32(rdr["ID"]);
                    Obj.Name = rdr["Name"].ToString();
                    Obj.Email = rdr["Email"].ToString();
                }
            }
            return Obj;
        }

        public Signup Login(Signup Obj)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("Login", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Email", Obj.Email);
                com.Parameters.AddWithValue("@Password", Obj.Password);
                SqlDataReader rdr = com.ExecuteReader();
                while (rdr.Read())
                {
                    Obj.Message = rdr["msg"].ToString();
                    Obj.ID = Convert.ToInt32(rdr["ID"]);
                    Obj.Name = rdr["Name"].ToString();
                    Obj.Email = rdr["Email"].ToString();
                    Obj.UserType = Convert.ToInt32(rdr["UserType"]);
                }
            }
            HttpContext.Current.Session["ID"] = Obj.ID;
            HttpContext.Current.Session["Name"] = Obj.Name;
            HttpContext.Current.Session["Email"] = Obj.Email;
            HttpContext.Current.Session["UserType"] = Obj.UserType;
            return Obj;
        }

        public int Logout()
        {
            HttpContext.Current.Session["ID"] = 0;
            return 0;
        }
    }
}