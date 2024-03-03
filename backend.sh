source common.sh

mysql_root_password = "ExpenseApp@1"

Print_Heading "Disable default NodeJs"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

Print_Heading "Enable NodeJs version 20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

Print_Heading "Install NodeJs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

Print_Heading "Add application User"
useradd expense &>>/tmp/expense.log
echo $?

Print_Heading "Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

Print_Heading "Setup APP directory"
mkdir /app &>>/tmp/expense.log
echo $?

Print_Heading "Download Application code"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

Print_Heading "Extract App code"
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

Print_Heading "Download Dependencies"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

Print_Heading "Start Backend Service"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

Print_Heading "Install MySql Client"
dnf install mysql -y &>>/tmp/expense.log
echo $?

Print_Heading "Load Schema"
mysql -h 172.31.30.52 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $? 