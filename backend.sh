source common.sh

mysql_root_password=$1
app_dir=/app
component=backend

# If password is not provided then we will exit
if [ -z "${mysql_root_password}" ]; then
  echo Input Password is missing.
  exit 1
fi

Print_Heading "Disable default NodeJs"
dnf module disable nodejs -y &>>$LOG
Check_Status $?

Print_Heading "Enable NodeJs version 20"
dnf module enable nodejs:20 -y &>>$LOG
Check_Status $?

Print_Heading "Install NodeJs"
dnf install nodejs -y &>>$LOG
Check_Status $?

Print_Heading "Add application User"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense &>>$LOG
fi
Check_Status $?


Print_Heading "Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
Check_Status $?

App_PreReq

Print_Heading "Download Dependencies"
cd /app &>>$LOG
npm install &>>$LOG
Check_Status $?

Print_Heading "Start Backend Service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
Check_Status $?

Print_Heading "Install MySql Client"
dnf install mysql -y &>>$LOG
Check_Status $?

Print_Heading "Load Schema"
mysql -h mysql-dev.devops-saketh.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
Check_Status $? 