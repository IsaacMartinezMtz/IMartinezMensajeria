//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Envio
    {
        public int IdEnvio { get; set; }
        public Nullable<int> IdMensaje { get; set; }
        public Nullable<int> IdConversacion { get; set; }
        public Nullable<int> Emisor { get; set; }
        public Nullable<int> Receptor { get; set; }
    
        public virtual Conversacion Conversacion { get; set; }
        public virtual Usuario Usuario { get; set; }
        public virtual Mensaje Mensaje { get; set; }
        public virtual Usuario Usuario1 { get; set; }
    }
}
