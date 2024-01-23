using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML
{
    public class Envio
    {
        public int IdEnvio { get; set; }
        public ML.Mensaje Mensaje { get; set; }
        public ML.Conversacion Conversacion { get; set; }
        public ML.Usuario UsuarioEmisor {  get; set; }
        public ML.Usuario UsuarioReceptor { get; set; }

        public List<object> Envios { get; set; }
    }
}
