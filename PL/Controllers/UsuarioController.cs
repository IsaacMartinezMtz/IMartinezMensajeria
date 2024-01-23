using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace PL.Controllers
{
    public class UsuarioController : Controller
    {
        // GET: Usuario
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(ML.Usuario usuario)
        {
            bool result = BL.Usuario.Add(usuario);
            if (result)
            {
                ViewBag.Valido = true;
                ViewBag.Mensaje = "Se registro correctamente el usuario";
            }
            else
            {
                ViewBag.Valido = true;
                ViewBag.Mensaje = "Error al registrar el usuario";
            }
            return PartialView("Modal");

        }
        [HttpPost]
        public ActionResult Login(ML.Usuario usuario)
        {
            string email = usuario.Email;
            string password = usuario.Password;

            object result = BL.Usuario.GetEmail(email);


            if (result != null)
            {
                usuario = (ML.Usuario)result;
                if (usuario.Password == password)
                {
                    Session["IdUsuarioSesion"] = usuario.IdUsuario;
                    return RedirectToAction("GetAll", "Conversacion");
                }
                else
                {
                    ViewBag.valido = true;
                    ViewBag.Mensaje = "Error contraseña incorrecta";
                }
            }
            else
            {
                ViewBag.Mensaje = "Error Usuario incorrecto";
                ViewBag.valido = true;
            }
            return PartialView("Modal");
        }
        public JsonResult BusquedaUsuario(string usuarios)
        {
            ML.Usuario usuario = new ML.Usuario();
            List<object> result = BL.Usuario.BusquedUsuario(usuarios);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
    }
}