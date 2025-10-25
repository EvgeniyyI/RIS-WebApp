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
    public partial class CoursesPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Устанавливаем кодировку UTF-8
        Response.ContentEncoding = Encoding.UTF8;
        Response.Charset = "utf-8";
        
        if (!IsPostBack)
        {
            BindDepartments();
        }
    }

    private void BindDepartments()
    {
        using (var context = new SchoolModel())
        {
            var departments = context.Department.ToList();
            ddlDepartments.DataSource = departments;
            ddlDepartments.DataTextField = "Name";
            ddlDepartments.DataValueField = "DepartmentID";
            ddlDepartments.DataBind();
            
            // Добавляем пустой элемент
            ddlDepartments.Items.Insert(0, new ListItem("-- Выберите кафедру --", "0"));
        }
    }

    protected void ddlDepartments_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDepartments.SelectedValue != "0")
        {
            BindCourses();
        }
        else
        {
            gvCourses.DataSource = null;
            gvCourses.DataBind();
        }
    }

    private void BindCourses()
    {
        int departmentId;
        if (int.TryParse(ddlDepartments.SelectedValue, out departmentId))
        {
            using (var context = new SchoolModel())
            {
                var courses = context.Course
                    .Where(c => c.DepartmentID == departmentId)
                    .ToList();
                
                gvCourses.DataSource = courses;
                gvCourses.DataBind();
            }
        }
    }
    }
}