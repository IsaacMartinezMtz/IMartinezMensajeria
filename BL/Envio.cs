using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class Envio
    {
        public static List<object> GetByIdConversacion(int Idconversacion)
        {
            List<object> mensajes = new List<object>();
            try
            {
                using(DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.GetByIdConversacioEnvios(Idconversacion);
                    if(query != null)
                    {
                        foreach(var item in query)
                        {
                            ML.Envio envio = new ML.Envio();
                            envio.Mensaje = new ML.Mensaje();
                            envio.Conversacion = new ML.Conversacion();
                            envio.UsuarioEmisor = new ML.Usuario();
                            envio.UsuarioReceptor = new ML.Usuario();
                            envio.Mensaje.IdMensaje = (int)item.IdMensaje;
                            envio.Mensaje.Texto = item.Mensaje;
                            envio.UsuarioEmisor.IdUsuario = (int)item.Emisor;
                            envio.UsuarioReceptor.IdUsuario = (int)item.Receptor;
                            envio.Conversacion.IdConversacion = (int)item.IdConversacion;
                            mensajes.Add(envio);
                        }
                    }
                }

            }catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
            return mensajes;
        }
    }
}
