source common.sh

Print_Heading "Install MySQL Server"
dnf install mysql-server -y &>>/tmp/expense.log
echo $?

Print_Heading "Start MySQL Service"
systemctl enable mysqld
systemctl start mysqld
echo $?

Print_Heading "Change root pwd"
mysql_secure_installation --set-root-pass ExpenseApp@1
echo $1