# Advanced Linux Administration Exercises

This directory contains hands-on exercises for Linux administration skills relevant to cloud engineering.

## Exercise 1: System Monitoring and Performance Analysis

### 1.1: Create a system monitoring script
```bash
touch system_monitor.sh
chmod +x system_monitor.sh
```

Edit the script to collect and display:
- CPU usage
- Memory usage
- Disk usage
- System load
- Network connections

### 1.2: Process Management
Learn to use:
- `ps aux` for viewing processes
- `top` and `htop` for real-time monitoring
- `nice` and `renice` for process prioritization
- `kill`, `pkill`, and `killall` for process termination

### 1.3: Log Analysis
```bash
# Create sample log files for analysis
mkdir -p logs
touch logs/application.log logs/error.log logs/access.log
```

Practice analyzing logs with:
- `grep`, `awk`, and `sed` for parsing
- Log rotation with `logrotate`
- Writing a log analyzer script

## Exercise 2: Advanced File System Management

### 2.1: File System Operations
Practice with:
- Creating and managing LVM volumes (simulation)
- Understanding inodes and hard/soft links
- File permissions and ownership (standard and ACLs)

### 2.2: Backup and Recovery
Create scripts for:
- Incremental backups using `rsync`
- Differential backups
- Backup verification and restoration testing

## Exercise 3: Automation with Shell Scripting

### 3.1: Advanced Scripting Techniques
```bash
touch advanced_script.sh
chmod +x advanced_script.sh
```

Create scripts demonstrating:
- Argument parsing
- Error handling
- Logging
- Configuration files
- Parallel processing with `&` and `wait`

### 3.2: Cron Jobs and Scheduling
```bash
mkdir cron_jobs
touch cron_jobs/daily_task.sh cron_jobs/weekly_task.sh
chmod +x cron_jobs/*.sh
```

Set up various scheduled tasks with different timing patterns.

## Exercise 4: User and Permission Management

### 4.1: User Administration
Practice commands for:
- Creating and managing users and groups
- Setting up sudo access
- Implementing password policies

### 4.2: Advanced Permissions
Implement examples of:
- SetUID and SetGID bits
- Sticky bits
- Access Control Lists (ACLs)
- File capabilities

## Exercise 5: Service Management

### 5.1: Systemd
Create a custom systemd service:
```bash
mkdir -p systemd
touch systemd/custom_service.service systemd/service_app.sh
chmod +x systemd/service_app.sh
```

### 5.2: Network Services
Set up and configure (in a containerized environment if available):
- Web server (nginx or Apache)
- Simple database service
- Load balancing concepts

## Exercise 6: Security Hardening

### 6.1: System Hardening Checklist
Create a comprehensive checklist for Linux security:
```bash
touch security_checklist.md
```

### 6.2: Security Auditing
Create scripts for:
- Checking for weak passwords
- Finding open ports
- Identifying outdated software
- Detecting unusual file permissions

## Exercise 7: Troubleshooting Scenarios

Create several scenario files with common problems and solutions:
```bash
mkdir -p troubleshooting
touch troubleshooting/{disk_full,high_load,network_issue,service_failure}.md
```

Each scenario should include:
- Problem description
- Diagnostic steps
- Resolution approach
- Prevention strategies