log_file=/tmp/expense.log

download_and_extract() {
  echo download $component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >>$log_file
  echo $?

  echo extarcting $component code
  unzip /tmp/$component.zip >>$log_file
  echo $?
}

stat_check() {
  if [ $? -eq 0 ]; then
     echo -e "\e[32msuccess\e[0m"
  else
     echo -e "\e[31mfailure\e[0m"
     exit 1
  fi
}