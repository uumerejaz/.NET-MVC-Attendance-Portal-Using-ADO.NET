using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Attendance.Models
{
    public class AttendanceModel
    {
        public int UserID { get; set; }
        public string Checkin { get; set; }
        public string Checkout { get; set; }
        public string Date { get; set; }
        public int ShortLeave { get; set; }
    }
}