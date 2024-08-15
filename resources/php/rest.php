<?php
    // REST server

    // This small REST server gives you the ability to manage tables
    // in your site database.

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;

    require '/home/normantonlife/normanton.life/PHPMailer/src/Exception.php';
    require '/home/normantonlife/normanton.life/PHPMailer/src/PHPMailer.php';
    require '/home/normantonlife/normanton.life/PHPMailer/src/SMTP.php';

    date_default_timezone_set('Europe/London');
    // print(substr($_SERVER['PATH_INFO'], 1)); print "\n";
    logger(substr($_SERVER['PATH_INFO'], 1));
    $request = explode("/", substr($_SERVER['PATH_INFO'], 1));
    $table = array_shift($request);
    $method = $_SERVER['REQUEST_METHOD'];

    $props = array();
    $filename = '../../../'.$_SERVER['HTTP_HOST'].'.txt';
    if (file_exists($filename)) {
        $file = fopen($filename, 'r');
        while (!feof($file)) {
            $ss = trim(fgets($file));
            if (!$ss || substr($ss, 0, 1) == '#') {
                continue;
            }
            $ss = explode('=', $ss, 2);
            if (count($ss) > 1) {
                $props[$ss[0]] = $ss[1];
            }
        }
        fclose($file);
    }

    // First, the commands that don't require a database connection.
    http_response_code(200);
    switch ($method) {
        case 'GET':
            switch ($table) {
                case '_list':
                    // List the contents of a directory
                    // Endpoint: {site root}/resources/php/rest.php/_list/[{path}]
//                  Start at the resources folder
//                    $path = getcwd() . '/resources/';
                    $path = "../";
                    if (count($request)) {
                         $path .= join('/', $request);
                    }
                    $files = scandir($path);
                    print '[';
                    // First list all the directories
                    $flag = false;
                    foreach ($files as $file) {
                        if (strpos($file, '.') !== 0) {
                            if (is_dir("$path/$file")) {
                                if ($flag) {
                                    print ',';
                                } else {
                                    $flag = true;
                                }
                                print "{\"name\":\"$file\",\"type\":\"dir\"}";
                            }
                        }
                    }
                    // Now do the ordinary files
                    foreach ($files as $file) {
                        if (strpos($file, '.') !== 0) {
                            if (!is_dir("$path/$file")) {
                                if ($flag) {
                                    print ',';
                                } else {
                                    $flag = true;
                                }
                                $type = 'file';
                                $p = strrpos($file, '.');
                                if ($p > 0) {
                                    $ext = substr($file, $p + 1);
                                    $type = $ext;
                                    switch (strtolower($ext)) {
                                        case 'jpg':
                                        case 'png':
                                        case 'gif':
                                            $type = 'img';
                                            break;
                                    }
                                }
                                print "{\"name\":\"$file\",\"type\":\"$type\"}";
                            }
                        }
                    }
                    print ']';
                    exit;
                case '_hash':
                    // Get a hash of a value
                    // Endpoint: {site root}/resources/php/rest.php/_hash/{value-to-hash}
                    print password_hash(join('/', $request), PASSWORD_DEFAULT);
                    exit;
                case '_verify':
                    // Verify a hash
                    // Endpoint: {site root}/resources/php/rest.php/_verify/{value-to-verify}
                    print password_verify(join('/', $request), $props['password']) ? 'yes' : 'no';
                    exit;
                case '_exists':
                    // Test if a file exists
                    // Endpoint: {site root}/resources/php/rest.php/_exists/{{path}
                    $path = getcwd() . '/resources/' . join('/', $request);
                    print file_exists($path) ? 'Y' : '';
                    exit;
                case '_load':
                    // Load a file from the resources folder
                    // Endpoint: {site root}/resources/php/rest.php/_load/{path}
                    $path = getcwd() . '/resources/' . join('/', $request);
                    print file_get_contents($path);
                    exit;
                case '_loadall':
                    // Load all the files in the named folder
                    // Endpoint: {site root}/resources/php/rest.php/_loadall/{path}
                    $path = getcwd() . '/resources/';
                    if (count($request)) {
                         $path .= join('/', $request);
                    }
                    $files = scandir($path);
                    print '[';
                    $flag = false;
                    foreach ($files as $file) {
                        if (strpos($file, '.') !== 0) {
                            if (!is_dir("$path/$file")) {
                                if ($flag) {
                                    print ',';
                                } else {
                                    $flag = true;
                                }
                                print file_get_contents("$path/$file");
                            }
                        }
                    }
                    print ']';
                    exit;
                case '_test':
                    // Test endpoint
                    // Endpoint: {site root}/resources/php/rest.php/_test/
                    print $_SERVER['HTTP_HOST'];
                    exit;
            }
            break;
        case 'POST':
            switch ($table) {
                case '_mkdir':
                    // Create a directory
                    // Endpoint: {site root}/resources/php/rest.php/_mkdir/{path}
                    $path = getcwd() . '/resources/' . join('/', $request);
                    logger("Create directory $path");
                    print("Create directory $path\n");
                    mkdir($path);
                    exit;
                case '_upload':
                    // Upload a file (an image) to the current directory
                    // Endpoint: {site root}/resources/php/rest.php/_upload/{path}
                    $path = $_POST['path'];
                    $path = explode("/", $path);
                    array_shift($path);
                    $path = "resources/" . join('/', $path);
                    mkdir($path, 0777, true);
                    logger("path: $path");
                    $fileName = $_FILES['source']['name'];
                    $tempName = $_FILES['source']['tmp_name'];
                    $fileType = $_FILES['source']['type'];
                    $fileSize = $_FILES['source']['size'];
                    $fileError = $_FILES['source']['error'];
                    $fullPath = "$path/$fileName";
                    $n = 2;
                    while (file_exists($fullPath)) {
                        $p = strrpos($fullPath, ".");
                        if ($p > 0) {
                            $fullPath = substr($fileName, 0, $p) . "-$n" . substr($fileName, $p);
                        } else {
                            $fullPath = "$path/$fileName-$n";
                        }
                        $n++;
                    }
                    if (!move_uploaded_file($tempName, $fullPath)) {
                        unlink($tempName);
                        http_response_code(400);
                        log_error("Failed to upload $tempName to $fileName.\ntempName: $tempName\nfileType: $fileType\nfileSize:$fileSize\nfileError: $fileError");
                    } else {
                        logger("File $fileName uploaded successfully to $path/$fileName");
                        $size = getimagesize("$path/$fileName");
                        logger("$path/$fileName: width:".$size[0].", height:".$size[1]);
                        if ($size[0] > 1024) {
                            logger("mogrify -resize 1024x1024 $path/$fileName");
                            system("mogrify -resize 1024x1024 $path/$fileName");
                        }
                    }
                    exit;
                case '_save':
                    // Save data to a file
                    // Endpoint: {site root}/resources/php/rest.php/_save/{path}
                    $path = getRoot() . join('/', $request);
                    $p = strrpos($path, '/');
                    $dir = substr($path, 0, $p);
                    mkdir($dir, 0777, true);
                    $content = base64_decode(stripslashes(file_get_contents("php://input")));
                    file_put_contents($path, $content);
                    header("Content-Type: application/text");
                    exit;
                case '_delete':
                    // Delete a file
                    // Endpoint: {site root}/resources/php/rest.php/_delete/{path}
                    $path = getRoot() . join('/', $request);
                    if (is_dir($path)) {
                        rmdir($path);
                    } else {
                        unlink($path);
                    }
                    exit;
                case '_email':
                    // Send an email
                    // Endpoint: {site root}/resources/php/rest.php/_email
                    header("Content-Type: application/text");
                    $value = stripslashes(file_get_contents("php://input"));
                    $json = json_decode($value);
                    $from = $json->from;
                    $to = $json->to;
                    $subject = $json->subject;
                    $message = $json->message;
                    $data = new stdClass();
                    $data->email = $email;
                    $data->subject = "RBR Heating - new user";
                    $data->message = $message;
                    $data->smtpusername = $smtpusername;
                    $data->smtppassword = $smtppassword;
                    try {
                        sendMail($data);
                        $xpassword = "x$password";
                        query($conn, "INSERT INTO users (email, password) VALUES ('$email','$xpassword')");
                        logger("INSERT INTO user (email, password) VALUES ('$email','$xpassword')");
                        print "{\"message\": \"$xpassword\"}";
                    } catch (Exception $e) {
                        http_response_code(404);
                        print "{\"message\": $data->err}";
                        break;
                    }
                    exit;
            }
            break;
    }

    // Most of the remaining commands require use of the database.
    $conn = mysqli_connect($props['sqlhost'], $props['sqluser'],
    $props['sqlpassword'], $props['sqldatabase']);
    if (!$conn)
    {
        http_response_code(404);
        die("Failed to connect to MySQL: " . mysqli_connect_error());
    }
    mysqli_set_charset($conn,'utf8');

    // You can have a custom extension that deals with special requests.
    // These all have '_' as the table name.
    switch ($method) {

        case 'GET':
            if ($table == '_') {
                // Endpoint: {site root}/rest.php/_/{request-and-arguments}
                include_once 'rest-local.php';
                get_local($conn, $request);
            } else {
                // Use the handler below
                get($conn, $table, $request);
            }
            break;

        case 'POST':
            if ($table == '_') {
                // Endpoint: {site root}/rest.php/_/{request-and-arguments}
                include_once 'rest-local.php';
                post_local($conn, $request);
            } else {
                // Use the handler below
                post($conn, $table, $request);
            }
            break;

        default:
            log_error("default: $request");
            http_response_code(400);
            break;
    }
    mysqli_close();
    logger("REST completed");
    exit;

    /////////////////////////////////////////////////////////////////////////
    // Most of the other commands deal with tables having a specific format, with the following fields:
    //
    // id int(11)
    // name varchar(40)
    // value text
    // ts int(11)
    //
    // GET
    function get($conn, $table, $request) {
        switch ($table) {
            case 'email':
                // Get a user record by its email address
                // Endpoint: {site root}/resources/php/rest.php/email/{email}
                $email = $request[0];
                $result = $conn->query("SELECT password,name FROM ec_user WHERE email='$email'");
                if ($row = mysqli_fetch_object($result)) {
                    $password = $row->password;
                    $name = $row->name;
                    print("{\"email\":\"$email\",\"password\":\"$password\",\"name\":\"$name\"}");
                } else {
                    http_response_code(404);
                    log_error("No user record for '$email'.");
                }
                mysqli_free_result($result);
                exit;

            case 'name':
                // Get a user record by its user name
                // Endpoint: {site root}/resources/php/rest.php/name/{name}
                $name = $request[0];
                $result = $conn->query("SELECT email,password,admin FROM ec_user WHERE name='$name'");
                if ($row = mysqli_fetch_object($result)) {
                    $email = $row->email;
                    $password = $row->password;
                    $admin = $row->admin;
                    print("{\"email\":\"$email\",\"password\":\"$password\",\"name\":\"$name\",\"admin\":\"$admin\"}");
                } else {
                    http_response_code(404);
                    log_error("No user record for '$name'.");
                }
                mysqli_free_result($result);
                exit;

            case 'verify':
                // Verify a password
                // Endpoint: {site root}/resources/php/rest.php/verify/{email}/{password}
                $email = trim($request[0]);
                $password = trim($request[1]);
                $result = $conn->query("SELECT password,name FROM ec_user WHERE email='$email'");
                if ($row = mysqli_fetch_object($result)) {
                    $hash = $row->password;
                    $name = $row->name;
                    print password_verify($password, $hash) ? $name : '';
                } else {
                    http_response_code(404);
                    log_error("No user record for '$email'.");
                }
                mysqli_free_result($result);
                exit;

            default:
                $action = $request[0];
                switch ($action) {
                    case 'count':
                        // Return the number of items in a table
                        // Endpoint: {site root}/easycoder/rest.php/table/count
                        $result = $conn->query("SELECT id from $table");
                        //print "{\"count\":".mysqli_num_rows($result)."}";
                        print mysqli_num_rows($result);
                        mysqli_free_result($result);
                        break;

                    case 'list':
                        // List items by ID, with optional offset & count, defaulting to 0 & 10
                        // Endpoint: {site root}/easycoder/rest.php/{table}/list/{offset}/{count}
                        switch (count($request)) {
                            case 2:
                                $offset = 0;
                                $count = $request[1];
                                break;
                            case 3:
                                $offset = $request[1];
                                $count = $request[2];
                                break;
                            default:
                                $offset = 0;
                                $count = 10;
                                break;
                        }
                        $result = $conn->query("SELECT id FROM $table LIMIT $offset, $count");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->id;
                        }
                        mysqli_free_result($result);
                        $response .= ']';
                        print $response;
                        break;

                    case 'names':
                        // List items by name in ascending alphabetical order,
                        // with optional offset & count, defaulting to 0 & 10
                        // Endpoint: {site root}/resources/php/rest.php/{table}/names/{offset}/{count}
                        switch (count($request)) {
                            case 2:
                                $offset = 0;
                                $count = $request[1];
                                break;
                            case 3:
                                $offset = $request[1];
                                $count = $request[2];
                                break;
                            default:
                                $offset = 0;
                                $count = 10;
                                break;
                        }
                        $result = $conn->query("SELECT name FROM $table ORDER BY name LIMIT $offset, $count");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= "\"$row->name\"";
                        }
                        mysqli_free_result($result);
                        $response .= ']';
                        print $response;
                        break;

                    case 'id':
                        // Get a record given its id
                        // Endpoint: {site root}/resources/php/rest.php/{table}/id/{id}
                        if (count($request) < 2) {
                            http_response_code(400);
                            log_error("Incomplete REST query.");
                            exit;
                        }
                        $id = $request[1];
                        $result = $conn->query("SELECT value FROM $table WHERE id='$id'");
                        if ($row = mysqli_fetch_object($result)) {
                            print $row->value;
                        } else {
                            http_response_code(404);
                            log_error("Cannot get item id '$id' as it does not exist.");
                        }
                        mysqli_free_result($result);
                        break;

                    case 'name':
                    case 'query':
                        // Get a record given its name
                        // Endpoint: {site root}/resources/php/rest.php/{table}/name/{name}
                        if (count($request) < 2) {
                            http_response_code(400);
                            log_error("Incomplete REST query.");
                            exit;
                        }
                        $name = $request[1];
                        $result = $conn->query("SELECT value FROM $table WHERE name='$name'");
                        if ($row = mysqli_fetch_object($result)) {
                            print $row->value;
                        } else if ($action == 'name') {
                            http_response_code(404);
                            log_error("Cannot get item named '$name' as it does not exist.");
                        }
                        break;

                    default:
                        http_response_code(404);
                        log_error("I don't understand this request.");
                        break;
                }
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // POST
    function post($conn, $table, $request) {
        global $props;
        switch ($table) {
            case 'user':
                // Post a user record
                // Endpoint: {site root}/resources/php/rest.php/user/
                $content = stripslashes(file_get_contents("php://input"));
                $record = json_decode($content);
                $email = $record->email;
                $password = $record->password;
                $name = $record->name;
                $result = $conn->query("SELECT null FROM ec_user WHERE email='$email'");
                if (mysqli_fetch_object($result)) {
                    // It exists, so update it
                    query($conn, "UPDATE ec_user SET password='$password',name='$name' WHERE email='$email'");
                } else {
                    // Add a new user record
                    query($conn, "INSERT INTO ec_user (email,password,name) VALUES ('$email','$password','$name')");
                    http_response_code(201);
                }
                mysqli_free_result($result);
                exit;

            case 'sendmail':
                // Send an email
                // Endpoint: {site root}/resources/php/rest.php/sendmail/
                $content = stripslashes(file_get_contents("php://input"));
                // print "$content\n";
                $data = json_decode($content);
                $data->smtpusername = $props['smtpusername'];
                $data->smtppassword = $props['smtppassword'];
                print_r($data); print "\n";
                try {
                    sendMail($data);
                } catch (Exception $e) {
                    http_response_code(404);
                    print "{\"message\": $e}";
                    break;
                }
                exit;

            default:

                if (!count($request)) {
                    http_response_code(400);
                    log_error("{\"message\":\"Incomplete REST query: ".substr($_SERVER['PATH_INFO'], 1).".\"}");
                    exit;
                }
                $ts = time();
                $action = $request[0];
                switch ($action) {
                    case 'set':
                        // Set the value of a record
                        if (count($request) > 2) {
                            switch ($request[1]) {
                                case 'id':
                                    // Set by id. The record must already exist
                                    // Endpoint: {site root}/resources/php/rest.php/{table}/id/{id}
                                    header("Content-Type: application/text");
                                    $value = stripslashes(file_get_contents("php://input"));
                                    $id = $request[2];
                                    // See if there's an item with this id
                                    $result = $conn->query("SELECT id FROM $table WHERE id=$id");
                                    if (mysqli_fetch_object($result)) {
                                        // It exists, so update it
                                        $value = urldecode($value);
                                        logger("UPDATE $table SET value='$value',ts=$ts WHERE id=$id");
                                        query($conn, "UPDATE $table SET value='$value',ts=$ts WHERE id=$id");
                                    } else {
                                        // Not found
                                        http_response_code(404);
                                        log_error("{\"code\":\"404\",\"message\":\"Cannot set record $id of $table.\"}");
                                    }
                                    mysqli_free_result($result);
                                    break;

                                case 'name':
                                    // Set by name. If the record does not exist, add it
                                    // Endpoint: {site root}/resources/php/rest.php/{table}/name/{name}
                                    header("Content-Type: application/text");
                                    $value = stripslashes(file_get_contents("php://input"));
                                    $name = $request[2];
                                    // See if there's an item with this name
                                    $result = $conn->query("SELECT id FROM $table WHERE name='$name'");
                                    if (mysqli_fetch_object($result)) {
                                        // It exists, so update it
                                        query($conn, "UPDATE $table SET value='$value',ts=$ts WHERE name='$name'");
                                    } else {
                                        // Add a new item
                                        query($conn, "INSERT INTO $table (name,value,ts) VALUES ('$name','$value','$ts')");
                                        http_response_code(201);
                                    }
                                    mysqli_free_result($result);
                                    break;

                                default:
                                    http_response_code(400);
                                    log_error("{\"message\":\"Value '".$request[1]."' should be 'id' or 'name'.\"}");
                                    break;
                                }
                        } else {
                            http_response_code(400);
                            log_error("{\"message\":\"Incomplete REST query.\"}");
                        }
                        break;

                    case 'delete':
                        // Delete a record, by id or by name
                        // Endpoint: {site root}/resources/php/rest.php/{table}/delete/{id}
                        // Or: ...{site root}/resources/php/rest.php/table/delete/{name}
                        if (count($request) > 1) {
                            $item = $request[1];
                            if (is_int($item)) {
                                // Delete the requested id
                                query($conn, "DELETE FROM $table WHERE id=$id");
                            } else {
                                // Delete the named item
                                query($conn, "DELETE FROM $table WHERE name='$item'");
                            }
                        }
                        break;

                    case 'rename':
                        // Rename a record
                        // Endpoint: {site root}/resources/php/rest.php/{table}/rename
                        $value = $_POST['value'];
                        $id = $_POST['id'];
                        if (!$id && count($request) > 1) {
                            $id = $request[1];
                        }
                        if ($id) {
                            query($conn, "UPDATE $table SET name='$name',value='$value' WHERE id=$id");
                        } else {
                            $name = $_POST['name'];
                            $newname = $_POST['newname'];
                            // See if there's a data item with the new name
                            $result = $conn->query("SELECT id FROM $table WHERE name='$newname'");
                            if ($row = mysqli_fetch_object($result)) {
                                // Conflict
                                http_response_code(409);
                                log_error("{\"message\":\"Cannot rename item '$name' to '$newname' as it already exists.\"}");
                            } else {
                                // See if there's a data item with this name
                                $result = $conn->query("SELECT id FROM $table WHERE name='$name'");
                                if ($row = mysqli_fetch_object($result)) {
                                    // There's a data item to rename
                                    $id = $row->id;
                                    query($conn, "UPDATE $table SET name='$newname',value='$value' WHERE id=$id");
                                } else {
                                    // Not found
                                    http_response_code(404);
                                    log_error("{\"message\":\"Cannot rename item '$name' as it does not exist.\"}");
                                }
                            }
                        mysqli_free_result($result);
                        }
                        break;

                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"Unrecognised action '$action' requested.\"}");
                        break;
                }
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // Get the root path
    function getRoot()
    {
        $cwd = getcwd();
        $p = strrpos($cwd, '/');
        $d = substr($cwd, 0, $p);
        $p = strrpos($d, '/');
        return substr($d, 0, $p) . '/';
    }

    /////////////////////////////////////////////////////////////////////////
    // Do an SQL query
    function query($conn, $sql)
    {
        $result = mysqli_query($conn, $sql);
        if (!$result) {
            http_response_code(404);
            log_error('Error: '.mysqli_error($conn));
            die('Error: '.mysqli_error($conn));
        }
        return $result;
    }

    ////////////////////////////////////////////////////////////////////////////
    // Log an error message.
    function log_error($message)
    {
        logger($message);
        print "$message\n";
    }

    ////////////////////////////////////////////////////////////////////////////
    // Log a message.
    function logger($message)
    {
        $timestamp = time();
        $date = date("Y/m/d H:i", $timestamp);
        if (!file_exists("log")) mkdir("log");
        $file = getRoot()."log/".date("Y", $timestamp);
        if (!file_exists($file)) mkdir($file);
        $file.= "/".date("Ymd", $timestamp).".txt";
        $fp = fopen($file, "a+") or die("Can't open $file");
        fwrite($fp, "$date: $message\n");
        fclose($fp);
    }

    ////////////////////////////////////////////////////////////////////////////
    // Send an email.
    function sendMail($data)
    {
        // print_r($data);
        $mail = new PHPMailer(true);                              // Passing `true` enables exceptions
        try {
            //Server settings
            $mail->SMTPDebug = 0;                                 // Enable verbose debug output
            $mail->isSMTP();                                      // Set mailer to use SMTP
            $mail->Host = 'smtp.dreamhost.com';                   // Specify main and backup SMTP servers
            $mail->SMTPAuth = true;                               // Enable SMTP authentication
            $mail->Username = $data->smtpusername;                // SMTP username
            $mail->Password = $data->smtppassword;                // SMTP password
            $mail->SMTPSecure = 'ssl';                            // Enable SSL encryption, TLS also accepted with port 465
            $mail->Port = 465;                                    // TCP port to connect to

            //Recipients
            $mail->setFrom('admin@normanton.life', 'From');          //This is the email your form sends From
            //$mail->addAddress($email, 'Joe User'); // Add a recipient address
            $mail->addAddress($data->to);               // Name is optional
            //$mail->addReplyTo('info@example.com', 'Information');
            //$mail->addCC('cc@example.com');
            //$mail->addBCC('bcc@example.com');

            //Attachments
            //$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
            //$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name

            //Content
            $mail->isHTML(true);                                  // Set email format to HTML
            $mail->Subject = $data->subject;
            $mail->Body    = $data->message;
            //$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

            $mail->send();
            //echo 'Message has been sent';
        } catch (Exception $e) {
            // print 'Mailer Error: ' . $mail->ErrorInfo;
            $data->err = 'Mailer Error: ' . $mail->ErrorInfo;
            throw $e;
        }
    }
?>
