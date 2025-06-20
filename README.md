
# 📋 Complaint Management System (CMS)

A simple web-based **Complaint Management System** built using **Java EE (Servlets, JSP)**, **JDBC**, **MySQL**, and **Bootstrap 5**.

It allows:
- 🚀 Employees to submit complaints.
- 🛠️ Admins to view, update, and delete complaints.
- 🔐 Role-based session management (Employee/Admin).
- 🧼 Fully synchronous HTTP (GET/POST), no AJAX used.
---
## 📽️ Project Demo Video

[![YouTube](https://img.shields.io/badge/Watch%20on-YouTube-red?logo=youtube&style=for-the-badge)](https://youtu.be/D_NhdighubU)


## 🗂️ Project Structure
```
CMS/
├── .idea/                      # IDE configuration files
├── .mvn/                       # Maven wrapper files
├── src/
│   └── main/
│       ├── java/
│       │   └── lk/vihanganimsara/cms/
│       │       ├── controller/     # Servlet Controllers
│       │       ├── dto/            # Data Transfer Objects
│       │       └── model/          # JDBC Logic (Models)
│       ├── resources/              # (Optional config files)
│       └── webapp/
│           ├── css/               # CSS Files
│           ├── js/                # JavaScript Files
│           ├── META-INF/          # Metadata
│           └── WEB-INF/           # Secured JSPs
│               ├── addComplaint.jsp
│               ├── adminDash.jsp
│               ├── signin.jsp
│               └── signup.jsp
└── test/                          # JUnit test files (optional)
```

---

## 🛠️ Technologies Used

- Java 11+
- Apache Tomcat 10/11
- MySQL
- JSP + Servlets
- JDBC
- HTML/CSS/Bootstrap
- Maven

---

## 🧑‍💻 Features

### Employee
- Sign up & Sign in
- Submit complaints
- View personal complaint history
- Delete or update complaints in "PENDING" state

### Admin
- View all submitted complaints
- Update status (`PENDING` ⇌ `RESOLVED`)
- Delete any complaint

---

## 🛠️ Setup and Configuration

### ✅ 1. Clone the Repository

```bash
git clone https://github.com/kvn2004/CMS.git
cd complaint-management-system
```
## ✅ 2. Database Setup

### 🔧 Create the database:

```
sql
CREATE DATABASE cms_db;
USE cms_db;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('EMPLOYEE', 'ADMIN') DEFAULT 'EMPLOYEE'
);

CREATE TABLE complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('PENDING', 'RESOLVED') DEFAULT 'PENDING',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```
## ✅ 3. Configure the Database Connection
```
<tomcat-dir>/conf/context.xml

Add this:
<Resource name="jdbc/TaskDB" auth="Container"
          type="javax.sql.DataSource" maxTotal="100" maxIdle="30"
          maxWaitMillis="10000" username="root" password="your_password"
          driverClassName="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/cms_db?serverTimezone=UTC"/>
```
## ✅ 4. Deploy
Import the project into IntelliJ IDEA or Eclipse.

Add a Tomcat configuration.

Run the application.

## ✅ 5. Access URLs
```
Role	URL Example
Employee	http://localhost:8080/CMS/usercomplaint
Admin	http://localhost:8080/CMS/adminDashboard

```

---

## 📄 License

This project is licensed under the **MIT License**.

#### © 2025 Vihanga Nimsara ([kvn2004](https://github.com/kvn2004))

