using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration.Configuration;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class Mensaje
    {
        public static bool Send(ML.Envio envio)
        {
            bool Correct = false;
            try
            {
               using(DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.AddMensaje(envio.Mensaje.Texto, 1, envio.UsuarioEmisor.IdUsuario, envio.UsuarioReceptor.IdUsuario, envio.Conversacion.IdConversacion);
                    if(query > 0)
                    {
                        Correct = true;
                    }
                    else{
                        Correct = false;
                    }
                    
                }

            }catch (Exception ex)
            {
                Correct = false;
            }
            return Correct;
        }
    }
}
