<%@ Page Title="Курсы" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Courses.aspx.cs" Inherits="WebApplication.CoursesPage" %>
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

		.filter-section {
			background: var(--surface-color);
			border-radius: var(--radius-xl);
			padding: 2.5rem;
			margin-bottom: 2rem;
			border: none;
			box-shadow: var(--shadow-lg);
			position: relative;
			overflow: hidden;
		}

		.filter-section::before {
			content: '';
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			height: 6px;
			background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
		}

		.filter-header {
			display: flex;
			align-items: center;
			gap: 1rem;
			margin-bottom: 2rem;
			flex-wrap: wrap;
		}

		.filter-title {
			font-size: 1.5rem;
			font-weight: 700;
			color: var(--text-primary);
			position: relative;
		}

		.filter-title::after {
			content: '';
			position: absolute;
			bottom: -8px;
			left: 0;
			width: 50px;
			height: 3px;
			background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
			border-radius: 2px;
		}

		.filter-icon {
			font-size: 1.8rem;
			background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
			background-clip: text;
		}

		.department-selector {
			display: flex;
			align-items: center;
			gap: 1.5rem;
			flex-wrap: wrap;
		}

		.department-label {
			font-weight: 600;
			color: var(--text-primary);
			font-size: 1.1rem;
		}

		.department-dropdown {
			padding: 1rem 1.25rem;
			border: 2px solid var(--border-color);
			border-radius: var(--radius-lg);
			background: var(--background-color);
			font-size: 1rem;
			min-width: 250px;
			transition: all 0.3s ease;
			box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
		}

		.department-dropdown:focus {
			outline: none;
			border-color: var(--primary-color);
			box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1), 0 4px 12px rgba(0, 0, 0, 0.1);
			transform: translateY(-1px);
		}

		.courses-grid {
			background: var(--background-color);
			border-radius: var(--radius-xl);
			overflow: hidden;
			box-shadow: var(--shadow-xl);
			border: none;
			position: relative;
		}

		.courses-grid::before {
			content: '';
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			height: 6px;
			background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
			z-index: 1;
		}

		.courses-grid table {
			margin: 0;
			border-radius: 0;
			box-shadow: none;
			border: none;
		}

		.courses-grid th {
			background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
			font-weight: 600;
			color: white;
			padding: 1.5rem 1rem;
			border-bottom: none;
			font-size: 0.95rem;
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}

		.courses-grid th:first-child {
			border-top-left-radius: var(--radius-xl);
		}

		.courses-grid th:last-child {
			border-top-right-radius: var(--radius-xl);
		}

		

		.courses-grid tr {
			transition: all 0.2s ease;
		}


        .courses-grid td {
			padding: 1.25rem 1rem;
			border-bottom: none;
			vertical-align: middle;
			transition: all 0.2s ease;
		}
        
		.courses-grid tr:hover {
			background: linear-gradient(135deg, rgba(37, 99, 235, 0.05) 0%, rgba(245, 158, 11, 0.05) 100%);
			transform: translateY(-1px);
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		}

		.courses-grid tr:last-child td {
			border-bottom: none;
		}

		.courses-grid tr:last-child td:first-child {
			border-bottom-left-radius: var(--radius-xl);
		}

		.courses-grid tr:last-child td:last-child {
			border-bottom-right-radius: var(--radius-xl);
		}

		.course-title {
			font-weight: 600;
			color: var(--text-primary);
			font-size: 1.1rem;
		}

		.course-credits {
			background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
			color: white;
			padding: 0.4rem 0.8rem;
			border-radius: var(--radius-md);
			font-weight: 600;
			font-size: 0.85rem;
			box-shadow: 0 2px 6px rgba(37, 99, 235, 0.25);
			display: inline-block;
		}

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

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
            margin-top: 2rem;
        }

        .back-link:hover {
            color: var(--primary-color);
            text-decoration: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 2rem 0;
            }
            
            .filter-section {
                padding: 1.5rem;
            }
            
            .filter-header {
                flex-direction: column;
                align-items: stretch;
            }
            
            .department-selector {
                flex-direction: column;
                align-items: stretch;
            }
            
            .department-dropdown {
                min-width: auto;
            }
            
            .courses-grid {
                overflow-x: auto;
            }
        }
    </style>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1 class="page-title">📚 Курсы по кафедрам</h1>
            <p class="page-subtitle">Просматривайте курсы, организованные по кафедрам</p>
        </div>
    </div>

    <!-- Content Section -->
    <div class="content-section">
        <div class="container">
            <!-- Filter Section -->
            <div class="filter-section fade-in">
                <div class="filter-header">
                    <span class="filter-icon">🔍</span>
                    <h2 class="filter-title">Фильтр по кафедре</h2>
                </div>
                <div class="department-selector">
                    <label for="ddlDepartments" class="department-label">Выберите кафедру:</label>
                    <asp:DropDownList ID="ddlDepartments" runat="server"
                        AutoPostBack="true" 
                        OnSelectedIndexChanged="ddlDepartments_SelectedIndexChanged"
                        CssClass="department-dropdown" />
                </div>
            </div>

            <!-- Courses Grid -->
            <div class="table-container">
                <asp:GridView ID="gvCourses" runat="server" 
                    AutoGenerateColumns="False"
                    CssClass="fade-in">
                    <Columns>
                        <asp:TemplateField HeaderText="Название курса">
                            <ItemTemplate>
                                <div class="course-title">
                                    <%# Eval("Title") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Кредиты">
                            <ItemTemplate>
                                <span class="course-credits">
                                    <%# Eval("Credits") %> кредитов
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <div class="empty-state-icon">📚</div>
                            <div class="empty-state-title">Курсы не найдены</div>
                            <div class="empty-state-description">
                                Для выбранной кафедры курсы не найдены.<br>
                                Попробуйте выбрать другую кафедру.
                            </div>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

            <div style="text-align: center;">
                <a href="Default.aspx" class="back-link">
                    ← Вернуться на главную
                </a>
            </div>
        </div>
    </div>
</asp:Content>
