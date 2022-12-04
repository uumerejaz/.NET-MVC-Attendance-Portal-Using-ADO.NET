using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Attendance.Models;
using Attendance.DAL;
using Attendance.Controllers;

namespace Attendance.Controllers
{
    public class AttendanceController : Controller
    {
        AttendanceDB AttDB = new AttendanceDB();
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult List()
        {
            return Json(AttDB.ListAll(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult MarkAttendance()
        {
            return Json(AttDB.Mark(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult MarkShortLeave(MarkAttendance Obj)
        {
            return Json(AttDB.MarkShortLeave(Obj), JsonRequestBehavior.AllowGet);
        }

    }
}