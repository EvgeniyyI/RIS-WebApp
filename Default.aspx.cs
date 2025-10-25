using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication.Models;

namespace WebApplication
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Устанавливаем кодировку UTF-8
            Response.ContentEncoding = Encoding.UTF8;
            Response.Charset = "utf-8";
            
            if (!IsPostBack)
            {
                LoadStatistics();
            }
        }

        private void LoadStatistics()
        {
            try
            {
                using (var context = new SchoolModel())
                {
                    var studentCount = context.Person.Count();
                    var courseCount = context.Course.Count();
                    var departmentCount = context.Department.Count();
                    var gradeCount = context.StudentGrade.Count();

                    // Передаем данные в JavaScript
                    string script = $@"
                        document.getElementById('studentCount').textContent = '{studentCount}';
                        document.getElementById('courseCount').textContent = '{courseCount}';
                        document.getElementById('departmentCount').textContent = '{departmentCount}';
                        document.getElementById('gradeCount').textContent = '{gradeCount}';
                    ";
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadStats", script, true);
                }
            }
            catch (Exception ex)
            {
                // В случае ошибки показываем заглушки
                string script = @"
                    document.getElementById('studentCount').textContent = '0';
                    document.getElementById('courseCount').textContent = '0';
                    document.getElementById('departmentCount').textContent = '0';
                    document.getElementById('gradeCount').textContent = '0';
                ";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadStats", script, true);
            }
        }
    }
}