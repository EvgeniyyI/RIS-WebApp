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
    public partial class StudentsAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Устанавливаем кодировку UTF-8
        Response.ContentEncoding = Encoding.UTF8;
        Response.Charset = "utf-8";
        
        if (!IsPostBack)
        {
            BindDetailsView();
        }
    }

    private void BindDetailsView()
    {
        using (var context = new SchoolModel())
        {
            // Создаем пустой объект Person для вставки
            var newPerson = new Person();
            DetailsView1.DataSource = new[] { newPerson };
            DetailsView1.DataBind();
        }
    }

    protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        try
        {
            using (var context = new SchoolModel())
            {
                var newPerson = new Person
                {
                    LastName = e.Values["LastName"] != null ? e.Values["LastName"].ToString() : "",
                    FirstMidName = e.Values["FirstMidName"] != null ? e.Values["FirstMidName"].ToString() : "",
                    EnrollmentDate = e.Values["EnrollmentDate"] != null ? 
                        (DateTime?)DateTime.Parse(e.Values["EnrollmentDate"].ToString()) : null
                };

                context.Person.Add(newPerson);
                context.SaveChanges();

                lblMessage.Text = "Студент успешно добавлен!";
                lblMessage.CssClass = "message-container message-success";
                BindDetailsView();
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Ошибка при добавлении студента: " + ex.Message;
            lblMessage.CssClass = "message-container message-error";
        }
    }
    }
}