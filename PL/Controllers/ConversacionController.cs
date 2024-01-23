using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PL.Controllers
{
    public class ConversacionController : Controller
    {
        // GET: Conversacion
        public ActionResult GetAll()
        {
            int IdUsuarioSesion = (int)Convert.ToInt64(Session["IdUsuarioSesion"]);
            ML.Conversacion conversacion = new ML.Conversacion();
            List<object> Conversa = BL.Conversacion.GetByIdUsuarioCoversacion(IdUsuarioSesion);
            if(Conversa != null)
            {
                
                conversacion.Conversaciones = Conversa;
                return View(conversacion);
            }
            else
            {
                
                return View();
            }
        }
        [HttpGet]
        public ActionResult Add(int IdUsuarioDos) 
        {
            ML.Conversacion conversacion = new ML.Conversacion();
            conversacion.UsuarioUno = new ML.Usuario();
            conversacion.UsuarioDos = new ML.Usuario();
            conversacion.UsuarioUno.IdUsuario = (int)Convert.ToInt64(Session["IdUsuarioSesion"]);
            conversacion.UsuarioDos.IdUsuario = IdUsuarioDos;
            bool result = BL.Conversacion.Add(conversacion);
            if (result)
            {
                return RedirectToAction("GetAll", "Conversacion");
            }
            else
            {
                ViewBag.valido = true;
                ViewBag.Mensaje = "Error contraseña incorrecta";
            }
            return PartialView("Modal");
        }
    }
}