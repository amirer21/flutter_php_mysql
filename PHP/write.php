<?php
  $db = "dbname"; //database name
  $dbuser = "username"; //database username
  $dbpassword = "password"; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);
  //connecting to database server

  //email과 wallet 주소만 받아서 저장
  $val = isset($_POST["email"]) && isset($_POST["wallet_address"]);

  if($val){
       //checking if there is POST data

       $email = $_POST["email"]; //grabing the data from headers
       $wallet_address = $_POST["wallet_address"];

       //validation name if there is no error before
       if($return["error"] == false && strlen($email) < 3){
           $return["error"] = true;
           $return["message"] = "Enter name up to 3 characters.";
       }

       //add more validations here

       //if there is no any error then ready for database write
       if($return["error"] == false){
            $email = mysqli_real_escape_string($link, $email);
            $wallet_address = mysqli_real_escape_string($link, $wallet_address);
            //escape inverted comma query conflict from string
        // static $SQL_INSERT_USER="INSERT INTO imb_user (email, wallet_address, date_time) VALUES ('a@abc.com','0x51833B564F60E31449B846212CC19dB95a87eC62', now())";
            $sql = "INSERT INTO imb_user SET
                                email = '$email',
                                wallet_address = '$wallet_address',
                                date_time =  now()";
            //student_id is with AUTO_INCREMENT, so its value will increase automatically

            $res = mysqli_query($link, $sql);
            if($res){
                //write success
            }else{
                $return["error"] = true;
                $return["message"] = "Database error";
            }
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link); //close mysqli

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>