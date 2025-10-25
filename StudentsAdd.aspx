<%@ Page Title="Добавить студента" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="true" CodeFile="StudentsAdd.aspx.cs"
Inherits="WebApplication.StudentsAdd" %>
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

		.form-container {
			max-width: 700px;
			margin: 0 auto;
			background: var(--background-color);
			border-radius: var(--radius-xl);
			padding: 3rem;
			box-shadow: var(--shadow-xl);
			border: none;
			position: relative;
			overflow: hidden;
		}

		.form-container::before {
			content: "";
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			height: 6px;
			background: linear-gradient(
				90deg,
				var(--primary-color),
				var(--accent-color)
			);
		}

		.form-header {
			text-align: center;
			margin-bottom: 2.5rem;
		}

		.form-title {
			font-size: 1.75rem;
			font-weight: 700;
			color: var(--text-primary);
			margin-bottom: 0.75rem;
			position: relative;
		}

		.form-title::after {
			content: "";
			position: absolute;
			bottom: -10px;
			left: 50%;
			transform: translateX(-50%);
			width: 60px;
			height: 3px;
			background: linear-gradient(
				90deg,
				var(--primary-color),
				var(--accent-color)
			);
			border-radius: 2px;
		}

		.form-subtitle {
			color: var(--text-secondary);
			font-size: 1.1rem;
			margin-top: 1rem;
		}

		.form-group {
			margin-bottom: 2rem;
		}

		.form-label {
			display: block;
			font-weight: 600;
			color: var(--text-primary);
			margin-bottom: 0.75rem;
			font-size: 1rem;
			position: relative;
		}

		.form-label::before {
			content: "";
			display: inline-block;
			width: 4px;
			height: 20px;
			background: linear-gradient(
				135deg,
				var(--primary-color),
				var(--accent-color)
			);
			margin-right: 8px;
			border-radius: 2px;
			vertical-align: middle;
		}

		.form-control {
			width: 100%;
			padding: 1rem 1.25rem;
			border: 1px solid var(--border-color);
			border-radius: var(--radius-lg);
			font-size: 1rem;
			transition: all 0.3s ease;
			background-color: var(--background-color);
			font-family: inherit;
			box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
		}

		.form-control:focus {
			outline: none;
			border-color: var(--primary-color);
			box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1),
				0 4px 12px rgba(0, 0, 0, 0.1);
			transform: translateY(-1px);
		}

		.form-control::placeholder {
			color: var(--text-muted);
			font-style: italic;
		}

		.form-actions {
			display: flex;
			gap: 1.5rem;
			justify-content: center;
			margin-top: 3rem;
			flex-wrap: wrap;
		}

		.message-container {
			margin-top: 2rem;
			padding: 1.5rem;
			border-radius: var(--radius-lg);
			text-align: center;
			font-weight: 600;
			font-size: 1rem;
			border: none;
		}

		.message-success {
			background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
			color: #166534;
		}

		.message-error {
			background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
			color: #dc2626;
		}

		.back-link {
			display: inline-flex;
			align-items: center;
			gap: 0.5rem;
			color: var(--text-secondary);
			text-decoration: none;
			font-weight: 500;
			transition: color 0.2s ease;
		}

		.back-link:hover {
			color: var(--primary-color);
			text-decoration: none;
		}

		.form-details {
			width: 100%;
			border: none;
		}

		.form-details table {
			width: 100%;
			border: none;
			margin: 0;
			background: transparent;
		}

		.form-details td {
			border: none;
			padding: 0;
			vertical-align: top;
			background: transparent;
		}

		.form-details td:first-child {
			width: 30%;
			padding-right: 1rem;
		}

		.form-details td:last-child {
			width: 70%;
		}

		/* Hide empty rows and extra elements */
		.form-details tr:empty {
			display: none;
		}

		.form-details .empty-row {
			display: none;
		}

		/* Ensure no extra spacing */
		.form-details tbody {
			display: block;
		}

		.form-details tbody tr {
			display: block;
			margin-bottom: 2rem;
		}

		.form-details tbody tr:last-child {
			margin-bottom: 0;
		}

		/* DetailsView Styling */
		.form-container table {
			width: 100%;
			border-collapse: separate;
			border-spacing: 0;
			margin: 0;
			background: transparent;
			box-shadow: none;
		}

		.form-container td {
			padding: 0;
			border: none;
			vertical-align: top;
		}

		.form-container td:first-child {
			width: 30%;
			padding-right: 1rem;
		}

		.form-container td:last-child {
			width: 70%;
		}

		.form-container tr:hover {
			background: transparent;
		}

		/* Insert Button Styling */
		.form-container input[type="submit"] {
			background: var(--primary-color);
			color: white;
			border: none;
			padding: 0.75rem 2rem;
			border-radius: var(--radius-md);
			font-weight: 600;
			font-size: 1rem;
			cursor: pointer;
			transition: all 0.2s ease;
		}

		.form-container input[type="submit"]:hover {
			background: var(--primary-dark);
			transform: translateY(-1px);
			box-shadow: var(--shadow-md);
		}

		/* Responsive Design */
		@media (max-width: 768px) {
			.page-header {
				padding: 2rem 0;
			}

			.form-container {
				padding: 1.5rem;
				margin: 0 1rem;
			}

			.form-container td:first-child,
			.form-container td:last-child {
				width: 100%;
				padding: 0;
			}

			.form-container td:first-child {
				margin-bottom: 0.5rem;
			}

			.form-actions {
				flex-direction: column;
			}
		}
	</style>

	<!-- Page Header -->
	<div class="page-header">
		<div class="container">
			<h1 class="page-title">➕ Добавить студента</h1>
			<p class="page-subtitle">
				Заполните форму для добавления нового студента в систему
			</p>
		</div>
	</div>

	<!-- Content Section -->
	<div class="content-section">
		<div class="container">
			<div class="form-container fade-in">
				<div class="form-header">
					<h2 class="form-title">Информация о студенте</h2>
					<p class="form-subtitle">Введите данные нового студента</p>
				</div>

				<asp:DetailsView
					ID="DetailsView1"
					runat="server"
					DefaultMode="Insert"
					AutoGenerateInsertButton="false"
					AutoGenerateRows="false"
					OnItemInserting="DetailsView1_ItemInserting"
					CssClass="form-details"
				>
					<Fields>
						<asp:TemplateField HeaderText="Фамилия">
							<InsertItemTemplate>
								<asp:TextBox
									ID="txtLastName"
									runat="server"
									Text='<%# Bind("LastName") %>'
									placeholder="Введите фамилию"
									CssClass="form-control"
								/>
							</InsertItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Имя">
							<InsertItemTemplate>
								<asp:TextBox
									ID="txtFirstMidName"
									runat="server"
									Text='<%# Bind("FirstMidName") %>'
									placeholder="Введите имя"
									CssClass="form-control"
								/>
							</InsertItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Дата поступления">
							<InsertItemTemplate>
								<asp:TextBox
									ID="txtEnrollmentDate"
									runat="server"
									Text='<%# Bind("EnrollmentDate") %>'
									TextMode="Date"
									CssClass="form-control"
								/>
							</InsertItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField>
							<InsertItemTemplate>
								<div class="form-actions">
									<asp:Button
										ID="InsertButton"
										runat="server"
										CommandName="Insert"
										Text="💾 Добавить студента"
										CssClass="btn btn-primary"
									/>
									<a href="Students.aspx" class="btn btn-secondary"
										>❌ Отмена</a
									>
								</div>
							</InsertItemTemplate>
						</asp:TemplateField>
					</Fields>
				</asp:DetailsView>

				<asp:Label
					ID="lblMessage"
					runat="server"
					CssClass="message-container"
				/>
			</div>

			<div style="text-align: center; margin-top: 2rem">
				<a href="Students.aspx" class="back-link">
					← Вернуться к списку студентов
				</a>
			</div>
		</div>
	</div>
</asp:Content>
