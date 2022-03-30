<?php

class Constants
{
    //DATABASE DETAILS
    static $DB_SERVER="localhost";
    static $DB_NAME="dbname";
    static $USERNAME="username";
    static $PASSWORD="password";

    //STATEMENTS
    static $SQL_SELECT_ALL="SELECT * FROM tablename";
    static $SQL_INSERT_TEST="INSERT INTO tablename (name, description, destination, image_url, technology_exists) VALUES ('kim','this is good','test','nft.jpg','bbb')";
}

class Imbmarket
{
    /*******************************************************************************************************************************************/
    /*
       1.CONNECT TO DATABASE.
       2. RETURN CONNECTION OBJECT
    */
    public function connect()
    {
        $con=new mysqli(Constants::$DB_SERVER,Constants::$USERNAME,Constants::$PASSWORD,Constants::$DB_NAME);
        if($con->connect_error)
        {
            // echo "Unable To Connect"; - For debug
            return null;
        }else
        {
            //echo "Connected"; - For debug
            return $con;
        }
    }
    /*******************************************************************************************************************************************/
    /*
       1.SELECT FROM DATABASE.
    */
    public function select()
    {
        $con=$this->connect();
        if($con != null)
        {
            $result=$con->query(Constants::$SQL_SELECT_ALL);
            if($result->num_rows>0)
            {
                $imbmarket=array();
                while($row=$result->fetch_array())
                {
                    array_push($imbmarket, array("id"=>$row['id'],"name"=>$row['name'],
                    "description"=>$row['description'],"destination"=>$row['destination'],
                    "image_url"=>$row['image_url'],"technology_exists"=>$row['technology_exists']));
                }
                print(json_encode(array_reverse($imbmarket)));
            }else
            {
                print(json_encode(array("PHP EXCEPTION : CAN'T RETRIEVE FROM MYSQL. ")));
            }
            $con->close();

        }else{
            print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
        }
    }

    /*******************************************************************************************************************************************/
    /*
       2.INSERT TO DATABASE.
    */
    public function insert()
    {
        $con=$this->connect();
        if($con != null)
        {
            $result=$con->query(Constants::$SQL_INSERT_TEST);
            $con->close();

        }else{
            print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
        }
    }
    /*******************************************************************************************************************************************/

}
$imbmarket=new Imbmarket();
$imbmarket->select();
$imbmarket->insert();

//end
?>