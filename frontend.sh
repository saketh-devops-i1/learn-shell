source common.sh

app_dir=/usr/share/nginx/html
component=frontend

Print_Heading "Install Nginx"
dnf install nginx -y &>>$LOG
Check_Status $?

Print_Heading "Reverse Proxy Configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
Check_Status $?

App_PreReq

Print_Heading "Restart Nginx Service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
Check_Status $?