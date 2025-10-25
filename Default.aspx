<%@ Page Title="Главная" Language="C#" MasterPageFile="~/Site.Master"
AutoEventWireup="true" CodeBehind="Default.aspx.cs"
Inherits="WebApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<style>
		/* Hero Section */
		.hero-section {
			background: var(--background-color);
			color: var(--text-primary);
			padding: 6rem 0;
			text-align: center;
			position: relative;
			overflow: hidden;
			border-bottom: 1px solid var(--border-color);
		}

		.hero-section::before {
			content: "";
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			background: linear-gradient(
				135deg,
				rgba(37, 99, 235, 0.02) 0%,
				rgba(245, 158, 11, 0.02) 100%
			);
			opacity: 1;
		}

		.hero-content {
			position: relative;
			z-index: 1;
			max-width: 800px;
			margin: 0 auto;
			padding: 0 1rem;
		}

		.hero-title {
			font-size: clamp(2.5rem, 5vw, 4rem);
			font-weight: 800;
			margin-bottom: 1.5rem;
			line-height: 1.1;
			letter-spacing: -0.02em;
		}

		.hero-subtitle {
			font-size: clamp(1.1rem, 2vw, 1.3rem);
			margin-bottom: 2.5rem;
			opacity: 0.9;
			line-height: 1.6;
			max-width: 600px;
			margin-left: auto;
			margin-right: auto;
		}

		.hero-actions {
			display: flex;
			gap: 1rem;
			justify-content: center;
			flex-wrap: wrap;
		}

		/* Features Section */
		.features-section {
			padding: 5rem 0;
			background: var(--surface-color);
		}

		.section-title {
			text-align: center;
			font-size: clamp(2rem, 4vw, 2.5rem);
			font-weight: 700;
			color: var(--text-primary);
			margin-bottom: 1rem;
		}

		.section-subtitle {
			text-align: center;
			font-size: 1.1rem;
			color: var(--text-secondary);
			margin-bottom: 3rem;
			max-width: 600px;
			margin-left: auto;
			margin-right: auto;
		}

		.features-grid {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
			gap: 2rem;
			margin-top: 3rem;
		}

		.feature-card {
			background: var(--background-color);
			border-radius: var(--radius-xl);
			padding: 2.5rem;
			box-shadow: var(--shadow-sm);
			border: 1px solid var(--border-color);
			transition: all 0.3s ease;
			position: relative;
			overflow: hidden;
		}

		.feature-card::before {
			content: "";
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			height: 4px;
			background: linear-gradient(
				90deg,
				var(--primary-color),
				var(--accent-color)
			);
			transform: scaleX(0);
			transition: transform 0.3s ease;
		}

		.feature-card:hover {
			transform: translateY(-8px);
			box-shadow: var(--shadow-xl);
		}

		.feature-card:hover::before {
			transform: scaleX(1);
		}

		.feature-icon {
			width: 4rem;
			height: 4rem;
			background: linear-gradient(
				135deg,
				var(--primary-color),
				var(--primary-light)
			);
			border-radius: var(--radius-lg);
			display: flex;
			align-items: center;
			justify-content: center;
			font-size: 1.8rem;
			margin-bottom: 1.5rem;
			color: white;
		}

		.feature-title {
			font-size: 1.5rem;
			font-weight: 700;
			color: var(--text-primary);
			margin-bottom: 1rem;
		}

		.feature-description {
			color: var(--text-secondary);
			line-height: 1.6;
			margin-bottom: 1.5rem;
		}

		/* Stats Section */
		.stats-section {
			padding: 4rem 0;
			background: var(--background-color);
		}

		.stats-grid {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
			gap: 2rem;
			margin-top: 2rem;
		}

		.stat-card {
			text-align: center;
			padding: 2rem 1rem;
			background: var(--surface-color);
			border-radius: var(--radius-lg);
			border: 1px solid var(--border-color);
			transition: all 0.3s ease;
		}

		.stat-card:hover {
			transform: translateY(-4px);
			box-shadow: var(--shadow-md);
		}

		.stat-number {
			font-size: 3rem;
			font-weight: 800;
			background: linear-gradient(
				135deg,
				var(--primary-color),
				var(--accent-color)
			);
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
			background-clip: text;
			margin-bottom: 0.5rem;
		}

		.stat-label {
			color: var(--text-secondary);
			font-weight: 600;
			font-size: 1.1rem;
		}

		/* CTA Section */
		.cta-section {
			background: var(--surface-color);
			color: var(--text-primary);
			padding: 4rem 0;
			text-align: center;
			border-top: 1px solid var(--border-color);
		}

		.cta-title {
			font-size: clamp(1.8rem, 3vw, 2.2rem);
			font-weight: 700;
			margin-bottom: 1rem;
		}

		.cta-subtitle {
			font-size: 1.1rem;
			opacity: 0.9;
			margin-bottom: 2rem;
			max-width: 500px;
			margin-left: auto;
			margin-right: auto;
		}

		/* Responsive Design */
		@media (max-width: 768px) {
			.hero-section {
				padding: 4rem 0;
			}

			.hero-actions {
				flex-direction: column;
				align-items: center;
			}

			.features-grid {
				grid-template-columns: 1fr;
				gap: 1.5rem;
			}

			.feature-card {
				padding: 2rem;
			}

			.stats-grid {
				grid-template-columns: repeat(2, 1fr);
				gap: 1rem;
			}
		}

		@media (max-width: 480px) {
			.stats-grid {
				grid-template-columns: 1fr;
			}
		}
	</style>

	<!-- Hero Section -->
	<section class="hero-section">
		<div class="hero-content">
			<h1 class="hero-title">Управление студентами нового поколения</h1>
			<p class="hero-subtitle">
				Современная веб-система для эффективного управления студентами, курсами
				и кафедрами. Интуитивный интерфейс и мощные возможности для
				образовательных учреждений.
			</p>
			<div class="hero-actions">
				<a href="Students.aspx" class="btn btn-primary">Начать работу</a>
				<a href="Courses.aspx" class="btn btn-secondary">Посмотреть курсы</a>
			</div>
		</div>
	</section>

	<!-- Features Section -->
	<section class="features-section">
		<div class="container">
			<h2 class="section-title">Возможности системы</h2>
			<p class="section-subtitle">
				Полный набор инструментов для управления образовательным процессом
			</p>

			<div class="features-grid">
				<div class="feature-card">
					<div class="feature-icon">👥</div>
					<h3 class="feature-title">Управление студентами</h3>
					<p class="feature-description">
						Просматривайте, добавляйте, редактируйте и удаляйте записи о
						студентах. Полная поддержка CRUD операций с удобным интерфейсом и
						валидацией данных.
					</p>
					<a href="Students.aspx" class="btn btn-primary"
						>Перейти к студентам</a
					>
				</div>

				<div class="feature-card">
					<div class="feature-icon">📚</div>
					<h3 class="feature-title">Курсы по кафедрам</h3>
					<p class="feature-description">
						Просматривайте курсы, организованные по кафедрам. Удобная фильтрация
						и навигация по учебным программам с детальной информацией.
					</p>
					<a href="Courses.aspx" class="btn btn-primary">Перейти к курсам</a>
				</div>

				<div class="feature-card">
					<div class="feature-icon">➕</div>
					<h3 class="feature-title">Быстрое добавление</h3>
					<p class="feature-description">
						Быстрое добавление новых студентов в систему. Простая форма с
						валидацией данных и автоматическим сохранением.
					</p>
					<a href="StudentsAdd.aspx" class="btn btn-primary"
						>Добавить студента</a
					>
				</div>
			</div>
		</div>
	</section>

	<!-- Stats Section -->
	<section class="stats-section">
		<div class="container">
			<h2 class="section-title">Статистика системы</h2>
			<p class="section-subtitle">
				Актуальные данные о вашем образовательном учреждении
			</p>

			<div class="stats-grid">
				<div class="stat-card">
					<div class="stat-number" id="studentCount">-</div>
					<div class="stat-label">Студентов</div>
				</div>
				<div class="stat-card">
					<div class="stat-number" id="courseCount">-</div>
					<div class="stat-label">Курсов</div>
				</div>
				<div class="stat-card">
					<div class="stat-number" id="departmentCount">-</div>
					<div class="stat-label">Кафедр</div>
				</div>
				<div class="stat-card">
					<div class="stat-number" id="gradeCount">-</div>
					<div class="stat-label">Оценок</div>
				</div>
			</div>
		</div>
	</section>

	<!-- CTA Section -->
	<section class="cta-section">
		<div class="container">
			<h2 class="cta-title">Готовы начать?</h2>
			<p class="cta-subtitle">
				Присоединяйтесь к современному подходу к управлению образованием
			</p>
			<a href="StudentsAdd.aspx" class="btn btn-primary"
				>Добавить первого студента</a
			>
		</div>
	</section>
</asp:Content>
