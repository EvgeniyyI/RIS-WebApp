<%@ Page Title="Студенты" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Students.aspx.cs" Inherits="WebApplication.Students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
		.page-header {
			background: var(--background-color);
			color: var(--text-primary);
			padding: 3rem 0;
			margin-bottom: 2rem;
			text-align: center;
			border-bottom: 1px solid var(--border-color);
		}

        .page-title {
            font-size: clamp(2rem, 4vw, 2.5rem);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .content-section {
            padding: 2rem 0;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

		.grid-container {
			background: var(--background-color);
			border-radius: var(--radius-xl);
			overflow: hidden;
			box-shadow: var(--shadow-xl);
			border: none;
			position: relative;
		}

		.grid-container::before {
			content: '';
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			height: 6px;
			background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
			z-index: 1;
		}

		/* GridView Styling */
		.grid-container table {
			margin: 0;
			border-radius: 0;
			box-shadow: none;
			border: none;
		}

		.grid-container th {
			background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
			font-weight: 600;
			color: white;
			padding: 1.5rem 1rem;
			border-bottom: none;
			font-size: 0.95rem;
			text-transform: uppercase;
			letter-spacing: 0.5px;
			position: relative;
		}

		.grid-container th:first-child {
			border-top-left-radius: var(--radius-xl);
		}

		.grid-container th:last-child {
			border-top-right-radius: var(--radius-xl);
		}

		.grid-container td {
			padding: 1.25rem 1rem;
			border-bottom: none;
			vertical-align: middle;
			transition: all 0.2s ease;
		}

		.grid-container tr {
			transition: all 0.2s ease;
		}

		.grid-container tr:hover {
			background: linear-gradient(135deg, rgba(37, 99, 235, 0.05) 0%, rgba(245, 158, 11, 0.05) 100%);
			transform: translateY(-1px);
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		}

		.grid-container tr:last-child td {
			border-bottom: none;
		}

		.grid-container tr:last-child td:first-child {
			border-bottom-left-radius: var(--radius-xl);
		}

		.grid-container tr:last-child td:last-child {
			border-bottom-right-radius: var(--radius-xl);
		}

		/* Pager Styling */
		.grid-container .pager {
			background: linear-gradient(135deg, var(--surface-color) 0%, var(--background-color) 100%);
			padding: 1.5rem;
			text-align: center;
			border-top: none;
		}

		.grid-container .pager a {
			color: var(--primary-color);
			text-decoration: none;
			padding: 0.75rem 1rem;
			margin: 0 0.25rem;
			border-radius: var(--radius-md);
			transition: all 0.2s ease;
			font-weight: 600;
			border: 2px solid transparent;
		}

		.grid-container .pager a:hover {
			background: var(--primary-color);
			color: white;
			transform: translateY(-2px);
			box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
		}

		.grid-container .pager span {
			background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
			color: white;
			padding: 0.75rem 1rem;
			margin: 0 0.25rem;
			border-radius: var(--radius-md);
			font-weight: 600;
			box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
		}

		/* Command Buttons - Compact Design */
		.command-buttons {
			display: flex;
			gap: 0.5rem;
			flex-wrap: wrap;
			justify-content: center;
		}

		.command-buttons a {
			padding: 0.5rem 0.75rem;
			border-radius: var(--radius-md);
			text-decoration: none;
			font-size: 0.85rem;
			font-weight: 600;
			transition: all 0.3s ease;
			display: inline-flex;
			align-items: center;
			gap: 0.375rem;
			min-width: auto;
			justify-content: center;
			white-space: nowrap;
		}

		.edit-button {
			background: linear-gradient(135deg, var(--accent-color), var(--accent-hover));
			color: white;
			box-shadow: 0 2px 6px rgba(245, 158, 11, 0.25);
		}

		.edit-button:hover {
			background: linear-gradient(135deg, var(--accent-hover), #b45309);
			color: white;
			transform: translateY(-1px);
			box-shadow: 0 3px 10px rgba(245, 158, 11, 0.35);
		}

		.delete-button {
			background: linear-gradient(135deg, #ef4444, #dc2626);
			color: white;
			box-shadow: 0 2px 6px rgba(239, 68, 68, 0.25);
		}

		.delete-button:hover {
			background: linear-gradient(135deg, #dc2626, #b91c1c);
			color: white;
			transform: translateY(-1px);
			box-shadow: 0 3px 10px rgba(239, 68, 68, 0.35);
		}

        /* Form Elements in Edit Mode */
        .edit-form {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .edit-form input {
            flex: 1;
            min-width: 120px;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }

        .empty-state-description {
            margin-bottom: 2rem;
        }

		/* Responsive Design */
		@media (max-width: 768px) {
			.page-header {
				padding: 2rem 0;
			}
			
			.section-header {
				flex-direction: column;
				align-items: stretch;
			}
			
			.actions {
				justify-content: center;
			}
			
			.grid-container {
				overflow-x: auto;
			}
			
			.command-buttons {
				flex-direction: column;
				gap: 0.375rem;
			}
			
			.command-buttons a {
				padding: 0.4rem 0.6rem;
				font-size: 0.8rem;
				gap: 0.25rem;
			}
			
			.edit-form {
				flex-direction: column;
			}
		}
    </style>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title">👥 Управление студентами</h1>
            <p class="page-subtitle">Просматривайте, редактируйте и управляйте информацией о студентах</p>
        </div>
    </div>

    <!-- Content Section -->
    <div class="content-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Список студентов</h2>
                <div class="actions">
                    <a href="StudentsAdd.aspx" class="btn btn-primary">➕ Добавить студента</a>
                    <a href="Default.aspx" class="btn btn-secondary">🏠 На главную</a>
                </div>
            </div>

            <div class="table-container">
                <asp:GridView ID="GridView1" runat="server"
                    AutoGenerateColumns="False"
                    AllowSorting="true"
                    AllowPaging="true" 
                    PageSize="10"
                    DataKeyNames="PersonID"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDeleting="GridView1_RowDeleting"
                    OnSorting="GridView1_Sorting"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    CssClass="fade-in">
                    <Columns>
                        <asp:TemplateField HeaderText="ФИО" SortExpression="LastName, FirstMidName">
                            <ItemTemplate>
                                <div style="font-weight: 500;">
                                    <%# Eval("LastName") + ", " + Eval("FirstMidName") %>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="edit-form">
                                    <asp:TextBox ID="txtLastName" runat="server" 
                                        Text='<%# Bind("LastName") %>' 
                                        placeholder="Фамилия"
                                        CssClass="form-control" />
                                    <asp:TextBox ID="txtFirstMidName" runat="server" 
                                        Text='<%# Bind("FirstMidName") %>' 
                                        placeholder="Имя"
                                        CssClass="form-control" />
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Дата поступления" SortExpression="EnrollmentDate">
                            <ItemTemplate>
                                <div style="color: var(--text-secondary);">
                                    <%# Eval("EnrollmentDate", "{0:dd.MM.yyyy}") %>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEnrollmentDate" runat="server" 
                                    Text='<%# Bind("EnrollmentDate", "{0:yyyy-MM-dd}") %>' 
                                    TextMode="Date" 
                                    CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Действия" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <div class="command-buttons">
                                    <asp:LinkButton ID="EditButton" runat="server" 
                                        CommandName="Edit" 
                                        CssClass="edit-button"
                                        Text="✏️ Редактировать" />
                                    <asp:LinkButton ID="DeleteButton" runat="server" 
                                        CommandName="Delete" 
                                        CssClass="delete-button"
                                        Text="🗑️ Удалить"
                                        OnClientClick="return confirm('Вы уверены, что хотите удалить этого студента?');" />
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="command-buttons">
                                    <asp:LinkButton ID="UpdateButton" runat="server" 
                                        CommandName="Update" 
                                        CssClass="btn btn-primary"
                                        Text="💾 Сохранить" />
                                    <asp:LinkButton ID="CancelButton" runat="server" 
                                        CommandName="Cancel" 
                                        CssClass="btn btn-secondary"
                                        Text="❌ Отмена" />
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <div class="empty-state-icon">👥</div>
                            <div class="empty-state-title">Студенты не найдены</div>
                            <div class="empty-state-description">
                                В системе пока нет зарегистрированных студентов.<br>
                                Добавьте первого студента, чтобы начать работу.
                            </div>
                            <a href="StudentsAdd.aspx" class="btn btn-primary">Добавить первого студента</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
