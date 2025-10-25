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
    public partial class Students : System.Web.UI.Page
{
    private string SortExpression
    {
        get { return ViewState["SortExpression"] as string ?? "LastName"; }
        set { ViewState["SortExpression"] = value; }
    }

    private SortDirection SortDirection
    {
        get { return ViewState["SortDirection"] != null ? (SortDirection)ViewState["SortDirection"] : SortDirection.Ascending; }
        set { ViewState["SortDirection"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // Устанавливаем кодировку UTF-8
        Response.ContentEncoding = Encoding.UTF8;
        Response.Charset = "utf-8";
        
        if (!IsPostBack)
        {
            BindGridView();
        }
    }

    private void BindGridView()
    {
        using (var context = new SchoolModel())
        {
            var students = context.Person.ToList();
            
            // Применяем сортировку
            if (SortExpression == "LastName, FirstMidName")
            {
                students = SortDirection == SortDirection.Ascending 
                    ? students.OrderBy(s => s.LastName).ThenBy(s => s.FirstMidName).ToList()
                    : students.OrderByDescending(s => s.LastName).ThenByDescending(s => s.FirstMidName).ToList();
            }
            else if (SortExpression == "EnrollmentDate")
            {
                students = SortDirection == SortDirection.Ascending 
                    ? students.OrderBy(s => s.EnrollmentDate).ToList()
                    : students.OrderByDescending(s => s.EnrollmentDate).ToList();
            }
            
            GridView1.DataSource = students;
            GridView1.DataBind();
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        BindGridView();
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        using (var context = new SchoolModel())
        {
            int personId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            var person = context.Person.Find(personId);

            if (person != null)
            {
                // Получаем значения из TextBox'ов
                GridViewRow row = GridView1.Rows[e.RowIndex];
                TextBox txtLastName = (TextBox)row.FindControl("txtLastName");
                TextBox txtFirstMidName = (TextBox)row.FindControl("txtFirstMidName");
                TextBox txtEnrollmentDate = (TextBox)row.FindControl("txtEnrollmentDate");

                person.LastName = txtLastName.Text;
                person.FirstMidName = txtFirstMidName.Text;
                DateTime enrollmentDate;
                if (DateTime.TryParse(txtEnrollmentDate.Text, out enrollmentDate))
                {
                    person.EnrollmentDate = enrollmentDate;
                }

                context.SaveChanges();
            }
        }

        GridView1.EditIndex = -1;
        BindGridView();
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        BindGridView();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        using (var context = new SchoolModel())
        {
            int personId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            var person = context.Person.Find(personId);

            if (person != null)
            {
                context.Person.Remove(person);
                context.SaveChanges();
            }
        }

        BindGridView();
    }

    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        if (SortExpression == e.SortExpression)
        {
            // Если сортируем по тому же полю, меняем направление
            SortDirection = SortDirection == SortDirection.Ascending ? SortDirection.Descending : SortDirection.Ascending;
        }
        else
        {
            // Если новое поле, начинаем с возрастающего порядка
            SortExpression = e.SortExpression;
            SortDirection = SortDirection.Ascending;
        }
        
        BindGridView();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGridView();
    }
    }
}