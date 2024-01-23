using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class Conversacion
    {
        public static List<object> GetByIdUsuarioCoversacion(int IdUsuario)
        {
            List<object> Conversaciones = new List<object>();
            try
            {
                using(DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.GetByIdConversacionUsuario(IdUsuario);
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.Conversacion conversacion = new ML.Conversacion();
                            conversacion.UsuarioUno = new ML.Usuario();
                            conversacion.UsuarioDos = new ML.Usuario();
                            conversacion.IdConversacion = item.IdConversacion;
                            if(item.IdEmisor == IdUsuario)
                            {
                                conversacion.UsuarioConversacion = item.Receptor;
                            }
                            else
                            {
                                conversacion.UsuarioConversacion = item.Emisor;
                            }
                            conversacion.UsuarioUno.IdUsuario = (int)item.IdEmisor;
                            conversacion.UsuarioDos.IdUsuario = (int)item.IdReceptor;
                            Conversaciones.Add(conversacion);
                        }
                    }
                }
                 
            }catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return Conversaciones;
        }
        public static bool Add(ML.Conversacion conversacion)
        {
            bool Correct = false;
            try
            {
                using(DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.AddConversacion(conversacion.UsuarioUno.IdUsuario, conversacion.UsuarioDos.IdUsuario);
                    if (query > 0)
                    {
                        Correct = true;
                    }
                    else
                    {
                        Correct=false;
                    }
                }

            }catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return Correct;
        }
    }
}
