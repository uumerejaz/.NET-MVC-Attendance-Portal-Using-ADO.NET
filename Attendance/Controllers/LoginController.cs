using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Attendance.Models;
using Attendance.DAL;

namespace Attendance.Controllers
{
    public class LoginController : Controller
    {
        SignupDB SignDB = new SignupDB();
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Add(Signup Obj)
        {
            return Json(SignDB.Add(Obj), JsonRequestBehavior.AllowGet);
        }

        public JsonResult Login(Signup Obj)
        {
            return Json(SignDB.Login(Obj), JsonRequestBehavior.AllowGet);
        }

        public int Logout()
        {
            SignDB.Logout();
            return 0;
        }
    }
}