log_file=/temp/expense.log
echo installing nginx
dnf install nginx -y
echo placing expense conf file in nginix
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo removing old nginix content
rm -rf /usr/share/nginx/html/* >>$log_file

echo download frontend code
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file

cd /usr/share/nginx/html

echo extarcting front end code
unzip /tmp/frontend.zip >>$log_file

echo starting nginix service
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file