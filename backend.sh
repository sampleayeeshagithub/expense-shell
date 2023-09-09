source common.sh
component=backend

echo install nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
else
  echo -e "\e[31mfailure\e[0m"
  exit
fi

echo install nodejs
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
  else
    echo -e "\e[31mfailure\e[0m"
    exit
  fi

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
  else
    echo -e "\e[31mfailure\e[0m"
    exit
  fi

echo add application user
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
  else
    echo -e "\e[31mfailure\e[0m"
    exit
  fi

echo clean app content
rm -rf /app &>>$log_file
echo $?
mkdir /app
cd /app

download_and_extract

echo download dependencies
npm install &>>$log_file
echo $?

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
echo $?

echo install mysql client
dnf install mysql -y &>>$log_file
echo $?

echo load schema
mysql -h mysql.ayeeshadevops75.online	-uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?