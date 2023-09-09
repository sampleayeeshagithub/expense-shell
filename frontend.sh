source common.sh
component=frontend

echo installing nginx
dnf install nginx -y &>>$log_file
stat_check

echo placing expense conf file in nginix
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
stat_check

echo removing old nginix content
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check

cd /usr/share/nginx/html

download_and_extract

echo starting nginix service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
stat_check