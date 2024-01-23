using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PL.Controllers
{
    public class EnvioController : Controller
    {
        // GET: Envio
        public ActionResult GetMesnajes(int IdConversacion, int IdUsuarioUno, int IdUsuarioDos)
        {
            Session["IdConversasion"] = IdConversacion;
            int IdUsuarioSesion = (int)Convert.ToInt64(Session["IdUsuarioSesion"]);
            if (IdUsuarioSesion == IdUsuarioUno)
            {
                Session["IdUsuarioReceptor"] = IdUsuarioDos;
            }
            else
            {
                Session["IdUsuarioReceptor"] = IdUsuarioUno;
            }

            return View();
        }
        public JsonResult GetMensajes()
        {
            ML.Envio envio = new ML.Envio();
            int IdConversacion = (int)Convert.ToInt64(Session["IdConversasion"]);
            List<object> result = BL.Envio.GetByIdConversacion(IdConversacion);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult send(ML.Envio envio)
        {
            envio.UsuarioEmisor = new ML.Usuario();
            envio.UsuarioReceptor = new ML.Usuario();
            envio.Conversacion = new ML.Conversacion();
            envio.UsuarioEmisor.IdUsuario = (int)Convert.ToInt64(Session["IdUsuarioSesion"]);
            envio.UsuarioReceptor.IdUsuario = (int)Convert.ToInt64(Session["IdUsuarioReceptor"]);
            envio.Conversacion.IdConversacion = (int)Convert.ToInt64(Session["IdConversasion"]);
            bool result = BL.Mensaje.Send(envio);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
        
}