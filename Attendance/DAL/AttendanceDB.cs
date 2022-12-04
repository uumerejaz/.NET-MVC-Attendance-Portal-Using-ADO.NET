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
    public class AttendanceDB
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
        public List<AttendanceModel> ListAll()
        {
            List<AttendanceModel> lst = new List<AttendanceModel>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("SelectAttendance", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@UserID", HttpContext.Current.Session["ID"]);
                SqlDataReader rdr = com.ExecuteReader();
                while (rdr.Read())
                {
                    lst.Add(new AttendanceModel()
                    {
                        UserID = Convert.ToInt32(rdr["UserID"]),
                        Checkin = rdr["Checkin"].ToString(),
                        Checkout = rdr["Checkout"].ToString(),
                        ShortLeave = Convert.ToInt32(rdr["ShortLeave"]),
                        Date = DateTime.Now.ToString(),
                    });
                }
                return lst;
            }
        }

        public MarkAttendance Mark()
        {
            MarkAttendance obj = new MarkAttendance() ;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("MarkAttendance", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@UserID", HttpContext.Current.Session["ID"]);
                com.ExecuteReader();
                return obj;
            }
        }

        public MarkAttendance MarkShortLeave(MarkAttendance Short)
        {
            MarkAttendance obj = new MarkAttendance();
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("MarkShortLeave", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@ShortLeave", Short.ShortLeave);
                com.Parameters.AddWithValue("@UserID", HttpContext.Current.Session["ID"]);
                com.ExecuteReader();
                return obj;
            }
        }

    }
}