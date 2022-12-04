using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Attendance.Models;
using Attendance.DAL;

namespace Attendance.Controllers
{
    public class AdminController : Controller
    {
        AdminDB AdminObj = new AdminDB();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult List()
        {
            return Json(AdminObj.ListAll(), JsonRequestBehavior.AllowGet);
        }

    }
}