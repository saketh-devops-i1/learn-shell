source common.sh

Print_Heading "Install Nginx"
dnf install nginx -y &>>/tmp/expense.log
echo $?

Print_Heading "Start & Enable Nginx service"
systemctl enable nginx &>>/tmp/expense.log
systemctl start nginx &>>/tmp/expense.log
echo $?

Print_Heading "Reverse Proxy Configuration"
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

Print_Heading "Remove the default content"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
echo $?

Print_Heading "Download Content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
echo $?

Print_Heading "Extract Content"
cd /usr/share/nginx/html &>>/tmp/expense.log
unzip /tmp/frontend.zip &>>/tmp/expense.log
echo $?

Print_Heading "Restart Nginx Service"
systemctl restart nginx &>>/tmp/expense.log
echo $?