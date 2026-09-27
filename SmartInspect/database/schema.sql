CREATE DATABASE IF NOT EXISTS smartinspect CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smartinspect;

CREATE TABLE IF NOT EXISTS users (
 id INT AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(100) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('ADMIN','DEPARTMENT_OFFICIAL','INSPECTION_TEAM','PROJECT_INCHARGE') NOT NULL DEFAULT 'PROJECT_INCHARGE',
 active BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS projects (
 id INT AUTO_INCREMENT PRIMARY KEY,
 project_name VARCHAR(200) NOT NULL,
 organization VARCHAR(200),
 location VARCHAR(255),
 scheme VARCHAR(200),
 project_incharge VARCHAR(150),
 contact VARCHAR(20),
 status ENUM('ACTIVE','INACTIVE','COMPLETED') DEFAULT 'ACTIVE',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS inspections (
 id INT AUTO_INCREMENT PRIMARY KEY,
 project_id INT NOT NULL,
 inspector_id INT NULL,
 inspection_date DATE NULL,
 inspection_type ENUM('ROUTINE','SURPRISE','RANDOM') DEFAULT 'ROUTINE',
 status ENUM('PENDING','ASSIGNED','IN_PROGRESS','COMPLETED','CANCELLED') DEFAULT 'PENDING',
 remarks TEXT,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(project_id) REFERENCES projects(id),
 FOREIGN KEY(inspector_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS inspection_assignments (
 id INT AUTO_INCREMENT PRIMARY KEY,
 inspection_id INT NOT NULL,
 assigned_to INT NOT NULL,
 assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 status ENUM('ASSIGNED','ACCEPTED','COMPLETED') DEFAULT 'ASSIGNED',
 FOREIGN KEY(inspection_id) REFERENCES inspections(id),
 FOREIGN KEY(assigned_to) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS cctv_feeds (
 id INT AUTO_INCREMENT PRIMARY KEY,
 project_id INT NOT NULL,
 camera_name VARCHAR(150) NOT NULL,
 stream_url TEXT,
 status ENUM('ONLINE','OFFLINE','UNKNOWN') DEFAULT 'UNKNOWN',
 last_checked DATETIME NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(project_id) REFERENCES projects(id)
);
CREATE TABLE IF NOT EXISTS evidence (
 id INT AUTO_INCREMENT PRIMARY KEY,
 inspection_id INT NOT NULL,
 file_name VARCHAR(255),
 file_path TEXT,
 file_type VARCHAR(100),
 uploaded_by INT,
 uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(inspection_id) REFERENCES inspections(id),
 FOREIGN KEY(uploaded_by) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS alerts (
 id INT AUTO_INCREMENT PRIMARY KEY,
 project_id INT NULL,
 inspection_id INT NULL,
 alert_type VARCHAR(100),
 message TEXT,
 severity ENUM('LOW','MEDIUM','HIGH','CRITICAL') DEFAULT 'LOW',
 status ENUM('OPEN','RESOLVED') DEFAULT 'OPEN',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(project_id) REFERENCES projects(id),
 FOREIGN KEY(inspection_id) REFERENCES inspections(id)
);

INSERT INTO projects(project_name,organization,location,scheme,project_incharge,contact,status)
SELECT 'Demo Residential Care Project','Demo NGO','Hyderabad, Telangana','DoSJE Demo Scheme','Demo Incharge','9000000000','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM projects WHERE project_name='Demo Residential Care Project');
INSERT INTO projects(project_name,organization,location,scheme,project_incharge,contact,status)
SELECT 'Demo Skill Development Centre','Demo Institute','Warangal, Telangana','Skill Development Demo Scheme','Demo Officer','9000000001','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM projects WHERE project_name='Demo Skill Development Centre');
