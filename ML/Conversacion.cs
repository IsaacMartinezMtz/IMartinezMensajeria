using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML
{
    public class Conversacion
    {
        public int IdConversacion {  get; set; }
        public ML.Usuario UsuarioUno { get; set; }
        public ML.Usuario UsuarioDos {  get; set; }
        public string UsuarioConversacion { get; set; }
        public List<object> Conversaciones { get; set; }
    }
}
