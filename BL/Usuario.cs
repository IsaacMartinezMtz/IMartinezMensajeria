using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class Usuario
    {
        public static bool Add(ML.Usuario usuario)
        {
            bool Correct = false;
            try
            {
                using(DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.AddUsusario(usuario.Nombre, usuario.ApellidoPaterno, usuario.ApellidoMaterno, usuario.Email, usuario.Password);
                    if(query > 0)
                    {
                        Correct = true;
                    }
                    else
                    {
                        Correct=false;
                    }
                }

            }catch(Exception e) { 
                Console.WriteLine("Error: " + e.Message);
            }
            return Correct;
        }
        public static object GetEmail(string email) {
            object usuario = new object();
            try
            {
                using (DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.GetEmail(email).ToList();
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.Usuario usuarioFor = new ML.Usuario();
                            usuarioFor.IdUsuario = item.IdUsuario;
                            usuarioFor.Email = item.Email;
                            usuarioFor.Password = item.Password;
                            usuario= usuarioFor;
                        }
                    }
                }

            }catch(Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
            return usuario;
        }
        public static List<object> BusquedUsuario(string nombre)
        {
            List<object> usuario = new List<object>();
            try
            {
                using (DL.MensajeriaEntities context = new DL.MensajeriaEntities())
                {
                    var query = context.BusquedaUsuario(nombre).ToList();
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.Usuario usuarioFor = new ML.Usuario();
                            usuarioFor.IdUsuario = item.IdUsuario;
                            usuarioFor.Nombre = item.Nombre;
                            usuarioFor.Email = item.Email;
                            
                            usuario.Add(usuarioFor);
                        }
                    }
                }

            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
            return usuario;
        }


    }
}
