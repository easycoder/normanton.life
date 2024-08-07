<?php
    // This is the local extension for the Yorkshire Woman REST server.
    // It contains endpoints for accessing the various tables used by the site.
    // For consistency, all endpoints have the same format:
    // {site root}/rest.php/_/{table name}/{action}[/...]

    /////////////////////////////////////////////////////////////////////////
    // GET
    function get_local($conn, $request) {
        $table = $request[0];
        array_shift($request);
        $action = $request[0];
        array_shift($request);
        switch ($table) {
            case 'nl_articles':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/nl_articles/count
                        // Return the number of public items in the table
                        $result = $conn->query("SELECT id from $table WHERE public=1");
                        //print "{\"count\":".mysqli_num_rows($result)."}";
                        print mysqli_num_rows($result);
                        break;
                    case 'countAll':
                        // Endpoint: {site root}/rest.php/_/nl_articles/countAll
                        // Return the total number of items in the table
                        $result = $conn->query("SELECT id from $table");
                        //print "{\"count\":".mysqli_num_rows($result)."}";
                        print mysqli_num_rows($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/nl_articles/list/{offset}/{count}
                        // List the ids of all public items in the range specified
                        switch (count($request)) {
                            case 1:
                                $offset = $request[0];
                                $count = 10;
                                break;
                            case 2:
                                $offset = $request[0];
                                $count = $request[1];
                                break;
                            default:
                                $offset = 0;
                                $count = 10;
                                break;
                        }
                        $result = $conn->query("SELECT id FROM $table WHERE public=1 ORDER BY published DESC LIMIT $offset, $count");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->id;
                        }
                        $response .= ']';
                        print $response;
                        break;
                    case 'listAll':
                        // Endpoint: {site root}/rest.php/_/nl_articles/listAll/{offset}/{count}
                        // List the ids of all items in the range specified
                        switch (count($request)) {
                            case 1:
                                $offset = $request[0];
                                $count = 10;
                                break;
                            case 2:
                                $offset = $request[0];
                                $count = $request[1];
                                break;
                            default:
                                $offset = 0;
                                $count = 10;
                                break;
                        }
                        $result = $conn->query("SELECT id FROM $table ORDER BY published DESC LIMIT $offset, $count");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->id;
                        }
                        $response .= ']';
                        print $response;
                        break;
                    case 'id':
                        // Endpoint: {site root}/rest.php/_/nl_articles/id/{id}
                        // Get a record given its id
                        $id = $request[0];
                        $result = $conn->query("SELECT value FROM $table WHERE id='$id'");
                        if ($row = mysqli_fetch_object($result)) {
                            $value = $row->value;
                            $json = json_decode($value);
                            $json->id = $id;
                            $value = json_encode($json);
                            print $value;
                        }
                        break;
                    case 'slug':
                        // Endpoint: {site root}/rest.php/_/nl_articles/slug/{slug}
                        // Get a record given its slug
                        $slug = $request[0];
                        $result = $conn->query("SELECT id,value FROM $table WHERE slug='$slug'");
                        if ($row = mysqli_fetch_object($result)) {
                            $value = $row->value;
                            $json = json_decode($value);
                            $json->id = $row->id;
                            $value = json_encode($json);
                            print $value;
                        } else {
                            http_response_code(404);
                            log_error("{\"message\":\"REST: Slug '$slug' not found.\"}");
                            break;
                         }
                        break;
                    case 'get':
                        // Endpoint: {site root}/rest.php/_/nl_articles/get/[{filter}/][{offset}/][{count}]
                        // Get all the public articles in the range specified
                        $filter = '';
                        if (count($request) > 0) {
                            $filter = $request[0];
                            if (in_array($request[0], array('section', 'author', 'tag'))) {
                                $filter = $request[0];
                                array_shift($request);
                                if (count($request) > 0) {
                                    $name = $request[0];
                                    array_shift($request);
                                }
                            }
                        }
                        switch (count($request)) {
                            case 1:
                                $offset = $request[0];
                                $count = 10;
                                break;
                            case 2:
                                $offset = $request[0];
                                $count = $request[1];
                                break;
                            default:
                                $offset = 0;
                                $count = 10;
                                break;
                        }
                        switch ($filter)
                        {
                            case 'section':
                                $filter = 'nl_'.$filter.'s';
                                $result = $conn->query("SELECT $table.value from $table
                                    INNER JOIN $filter ON $filter.page = $table.id
                                    WHERE name='" . str_replace(' ', '%20', $name)
                                        ."'ORDER BY $table.published DESC LIMIT $offset, $count");
                                break;
                            case 'author':
                                $filter = 'nl_'.$filter.'s';
                                $result = $conn->query("SELECT $table.value from $table
                                    INNER JOIN $filter ON $filter.page = $table.id
                                    WHERE name='" . str_replace(' ', '%20', $name)
                                        ."'ORDER BY $table.published DESC LIMIT $offset, $count");
                                break;
                            case 'tag':
                                $filter = 'nl_'.$filter.'s';
                                $result = $conn->query("SELECT $table.value from $table
                                    INNER JOIN $filter ON $filter.page = $table.id
                                    WHERE tag='" . str_replace(' ', '%20', $name)
                                        ."'ORDER BY $table.published DESC LIMIT $offset, $count");
                                break;
                            default:
                                $result = $conn->query("SELECT value FROM $table WHERE public=1
                                    ORDER BY published DESC LIMIT $offset, $count");
                                break;
                        }

                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->value;
                        }
                        $response .= ']';
                        print $response;
                        break;
                    case 'getAll':
                        // Endpoint: {site root}/rest.php/_/nl_articles/getAll/{offset}/{count}
                        // Get all the articles in the range specified
                        switch (count($request)) {
                            case 1:
                                $offset = $request[0];
                                $count = 10;
                                break;
                            case 2:
                                $offset = $request[0];
                                $count = $request[1];
                                break;
                            default:
                                $offset = 0;
                                $count = 10;
                                break;
                        }
                        $result = $conn->query("SELECT value FROM $table ORDER BY published DESC LIMIT $offset, $count");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->value;
                        }
                        $response .= ']';
                        print $response;
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                    }
                break;
            case 'nl_sections':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/nl_sections/count/{section}
                        // Return the number of articles from this author
                        $name = $request[0];
                        $result = $conn->query("SELECT page from $table
                            WHERE name='" . str_replace(' ', '%20', $name) ."'");
                        print mysqli_num_rows($result);
                        mysqli_free_result($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/nl_sections/list/{section}
                        $name = $request[0];
                        $result = $conn->query("SELECT page from $table
                            WHERE name='" . str_replace(' ', '%20', $name) ."'");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->page;
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    case 'enum':
                        // Endpoint: {site root}/rest.php/_/nl_sections/enum
                        $result = $conn->query("SELECT DISTINCT name from $table");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            $name = $row->name;
                            if ($name) {
                                if ($response != '[') {
                                    $response .= ',';
                                }
                                $response .= "\"$name\"";
                            }
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                }
                break;
            case 'nl_authors':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/nl_authors/count/{author}
                        // Return the number of articles from this author
                        $name = $request[0];
                        $result = $conn->query("SELECT page from $table
                            WHERE name='" . str_replace(' ', '%20', $name) ."'");
                        print mysqli_num_rows($result);
                        mysqli_free_result($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/nl_authors/list/{author}
                        $name = $request[0];
                        $result = $conn->query("SELECT page from $table
                            WHERE name='" . str_replace(' ', '%20', $name) ."'");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->page;
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    case 'enum':
                        // Endpoint: {site root}/rest.php/_/nl_authors/enum
                        $result = $conn->query("SELECT DISTINCT name from $table");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            $name = $row->name;
                            if ($name) {
                                if ($response != '[') {
                                    $response .= ',';
                                }
                                $response .= "\"$name\"";
                            }
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                }
                break;
            case 'nl_tags':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/nl_tags/count/{tag}
                        // Return the number of items with this tag
                        $tag = $request[0];
                        $result = $conn->query(
                            "SELECT nl_articles.id from $table INNER JOIN nl_articles
                              ON $table.page = nl_articles.id WHERE tag='$tag'");
                        print mysqli_num_rows($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/nl_tags/list/{tag}
                        $tag = $request[0];
                        $result = $conn->query(
                            "SELECT nl_articles.id from $table INNER JOIN nl_articles
                              ON $table.page = nl_articles.id WHERE tag='$tag'");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->id;
                        }
                        $response .= ']';
                        print $response;
                        break;
                    case 'tags':
                        // Endpoint: {site root}/rest.php/_/nl_tags/tags
                        $id = $request[0];
                        $result = $conn->query("SELECT tag FROM $table WHERE page=$id");
                        $json = '[';
                        $flag = false;
                        while ($row = mysqli_fetch_object($result)) {
                            $tag = $row->tag;
                            if ($tag) {
                                if ($flag) {
                                    $json .= ',';
                                } else {
                                    $flag = true;
                                }
                                $json .= "\"$tag\"";
                            }
                        }
                        $json .= ']';
                        mysqli_free_result($result);
                        print $json;
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                }
                break;
            case 'ec_visitors':
                switch ($action) {
                    case 'visitor':
                        // Endpoint: {site root}/rest.php/_/ec_visitors/visitor/{vid}
                        // Return the data for a single visitor
                        $vid = $request[0];
                        $result = $conn->query("SELECT * FROM $table WHERE id=$vid");
                        if ($row = mysqli_fetch_object($result)) {
                            $details->agent = $row->agent;
                            $details->ts = $row->ts;
                        }
                        mysqli_free_result($result);
                        print json_encode($details);
                        break;
                    case 'dates':
                        // Endpoint: {site root}/rest.php/_/ec_visitors/dates/{start}/{finish}
                        // Get all the visitors for a range of dates
                        $start = $request[0];
                        $finish = $request[1];
                        $json = '[';
                        $visits = 'visits';
                        $year = date("Y", $start);
                        $finish = date("Y", $finish);
                        $start = date("Ymd", $start);
                        $visitors = array();
                        $flag = false;
                        while ($year <= $finish) {
                            $files = array_diff(scandir("$visits/$year"), array('.', '..'));
                            foreach ($files as $file) {
                                $filedate = substr($file, 0, 8);
                                if ($filedate >= $start) {
                                    $fp = fopen("$visits/$year/$file", "r");
                                    if ($fp) {
                                        while (!feof($fp)) {
                                            $data = trim(fgets($fp));
                                            if ($data) {
                                                $data = json_decode($data);
                                                $vid = $data->vid;
                                                if (!in_array($vid, $visitors)) {
                                                    array_push($visitors, $vid);
                                                    if ($flag) {
                                                        $json .= ',';
                                                    } else {
                                                        $flag = true;
                                                    }
                                                    $result = $conn->query("SELECT ip from ec_visitors WHERE id=$vid");
                                                    if ($row = mysqli_fetch_object($result)) {
                                                        $ip = $row->ip;
                                                    }
                                                    mysqli_free_result($result);
                                                    $info = file_get_contents("http://ipinfo.io/{$ip}/json");
                                                    $details = json_decode($info);
                                                    $details->vid = $vid;
                                                    $json .= json_encode($details);
                                                }
                                            }
                                        }
                                        fclose($fp);
                                    } else {
                                        http_response_code(400);
                                        log_error("{\"message\":\"REST: Can't open file '$file'.\"}");
                                    }
                                }
                            }
                            $year++;
                        }
                        $json .= ']';
                        print $json;
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                }
                break;
            case 'ec_visits':
                switch ($action) {
                    case 'single':
                        // Endpoint: {site root}/rest.php/_/ec_visits/single/{vid}/{start}/{finish}
                        // Get the visit data for a single visitor
                        $vid = $request[0];
                        $start = $request[1];
                        $finish = $request[2];
                        $json = '[';
                        $visits = 'visits';
                        $year = date("Y", $start);
                        $finish = date("Y", $finish);
                        $start = date("Ymd", $start);
                        $flag = false;
                        while ($year <= $finish) {
                            $files = array_diff(scandir("$visits/$year"), array('.', '..'));
                            foreach ($files as $file) {
                                $filedate = substr($file, 0, 8);
                                if ($filedate >= $start) {
                                    $fp = fopen("$visits/$year/$file", "r");
                                    if ($fp) {
                                        while (!feof($fp)) {
                                            $data = trim(fgets($fp));
                                            if ($data) {
                                                $props = json_decode($data);
                                                if ($props->vid == $vid) {
                                                    if ($flag) {
                                                        $json .= ',';
                                                    } else {
                                                        $flag = true;
                                                    }
                                                    $json .= $data;
                                                }
                                            }
                                        }
                                        fclose($fp);
                                    } else {
                                        http_response_code(400);
                                        log_error("{\"message\":\"REST: Can't open file '$file'.\"}");
                                        break;
                                    }
                                }
                            }
                            $year++;
                        }
                        $json .= ']';
                        print $json;
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                    }
                break;
           default:
                http_response_code(404);
                log_error("{\"message\":\"REST: Unknown table '$table'.\"}");
                break;
        }
    }
    
    /////////////////////////////////////////////////////////////////////////
    // POST
    function post_local($conn, $request) {
        $ts = time();
        $table = $request[0];
        array_shift($request);
        $action = $request[0];
        array_shift($request);
        switch ($table) {
           case 'nl_articles':
                 switch ($action) {
                    case 'update':
                        // Endpoint: {site root}/rest.php/_/nl_articles/update/{id}
                        // Update an existing record
                        $id = $request[0];
                        header("Content-Type: application/json");
                        $value = stripslashes(file_get_contents("php://input"));
                        $json = json_decode($value);
                        $slug = $json->slug;
                        $public = $json->public;
                        $published = $json->published;
                        // See if there's an item with this id;
                        if (is_numeric($id)) {
                            logger("SELECT id FROM $table WHERE id=$id");
                            $result = $conn->query("SELECT id FROM $table WHERE id=$id");
                        } else {
                            logger("SELECT id FROM $table WHERE slug='$id'");
                            $result = $conn->query("SELECT id FROM $table WHERE slug='$id'");
                        }
                        $json->id = $id;
                        // Write to a backup file on the server
                        $articles = 'resources/articles';
                        if (!file_exists($articles)) {
                            mkdir($articles);
                        }
                        $id = '' . $id;
                        while (strlen($id) < 4) {
                            $id = '0' . $id;
                        }
                        $value = json_encode($json, JSON_PRETTY_PRINT);
                        $file = getRoot() . "$articles/$id";
                        logger("Save to $file");
                        $fp = fopen($file, "w");
                        if ($fp) {
                            fwrite($fp, "$value");
                            fclose($fp);
                            logger("Success");
                        } else {
                            http_response_code(400);
                            log_error("{\"message\":\"REST: Can't open file '$file'.\"}");
                        }
                        if ($row = mysqli_fetch_object($result)) {
                            // It exists, so update it
                            $id = $row->id;
                            $slug = ec_getUniqueSlug($conn, $table, $id, $slug);
                            $json->slug = $slug;
                            $value = json_encode($json);
                            logger("UPDATE $table SET value=(value),slug='$slug',published=$published,public='$public',ts=$ts WHERE id=$id");
                            $conn->query("UPDATE $table SET value='$value',slug='$slug',published=$published,public='$public',ts=$ts WHERE id=$id");
                            ec_process_section($conn, $id, $json->section);
                            ec_process_author($conn, $id, $json->author);
                            ec_process_tags($conn, $id, $json->tags);
                            ec_process_words($conn, $id, $json);
                            print 'OK';
                        } else {
                            // Not found
                            http_response_code(404);
                            log_error("{\"code\":\"404\",\"message\":\"Cannot update record $id of $table.\"}");
                        }
                        break;
                    case 'new':
                        // Endpoint: {site root}/rest.php/_/nl_articles/new
                        // Add a new record
                        $name = $request[0];
                        header("Content-Type: application/json");
                        $value = stripslashes(file_get_contents("php://input"));
                        $json = json_decode($value);
                        $published = $json->published;
                        $conn->query("INSERT INTO $table (value,published,ts) VALUES ('$value','$published','$ts')");
                        $id = mysqli_insert_id($conn);
                        $json->id = $id;
                        $json->title = "Record $id";
                        $json->slug = "record-$id";
                        $value = json_encode($json);
                        $conn->query("UPDATE $table SET slug='record-$id',value='$value' WHERE id=$id");
                        http_response_code(201);
                        print 'OK';
                        break;
                    default:
                        http_response_code(400);
                        log_error("{\"message\":\"Action '$action' should be 'update' or 'new'.\"}");
                        break;
                }
                break;
            case 'nl_tags':
                switch ($action) {
                    case 'set':
                        ec_process_tags($conn, $request[0], $request[1]);
                        print 'OK';
                        break;
                    default:
                        http_response_code(400);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                }
                break;
            case 'ec_visits':
                switch ($action) {
                    case 'log':
                        // Endpoint: {site root}/rest.php/_/ec_visits/log/{id}
                        // If there is no body content this just notifies the server of the user ID
                        $vid = $request[0];
                        $ts = time();
                        $agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : null;
//                         $uri = isset($_SERVER['HTTP_REQUEST_URI']) ? $_SERVER['HTTP_REQUEST_URI'] : null;
                        $ip = $_SERVER['REMOTE_ADDR'];
                        $json->ipaddr = $ip;
                        // If the supplied id is not 0, see if there's a record 
                        if ($vid) {
                            $result = $conn->query("SELECT id FROM ec_visitors WHERE id=$vid");
                            if (mysqli_fetch_object($result)) {
                                $conn->query("UPDATE ec_visitors SET ip='$ip',ts=$ts,agent='$agent' WHERE id=$vid");
                            } else {
                                $vid = 0;
                            }
                            mysqli_free_result($result);
                        }
                        if (!$vid) {
                            // See if there's a record with this IP address and user agent
                            $result = $conn->query("SELECT id FROM ec_visitors WHERE ip='$ip' AND agent='$agent'");
                            if ($row = mysqli_fetch_object($result)) {
                                $vid = $row->id;
                                $conn->query("UPDATE ec_visitors SET ip='$ip',ts=$ts,agent='$agent' WHERE id=$vid"); 
                            }
                            mysqli_free_result($result);
                        }
                        if (!$vid) {
                             // Look for a record that's more than 3 months old
                            $expiry = $time - 3 * 30 * 24 * 60 * 60;
                            $result = $conn->query("SELECT id FROM ec_visitors WHERE ts<$expiry");
                            if ($row = mysqli_fetch_object($result)) {
                                $vid = $row->id;
                                $conn->query("UPDATE ec_visitors SET ip='$ip',ts=$ts,agent='$agent' WHERE id=$vid"); 
                            } else {
                                $conn->query("INSERT INTO ec_visitors (ip,ts,agent) VALUES ('$ip','$ts','$agent')");
                                $vid = mysqli_insert_id($conn);
                            }
                            mysqli_free_result($result);
                        }
                        print $vid; 
                        
                        // Now deal with body content
                        header("Content-Type: application/json");
                        $data = stripslashes(file_get_contents("php://input"));
                        if ($data) {
                            $json = json_decode($data);
                            $json->v = 1;
                            $json->ts = $ts;
                            $json->vid = $vid;
//                             if ($uri) {
//                                 $json->referrer = $uri;
//                                 $data = json_encode($json);
//                             }
                            // Write to the database
//                            $conn->query("INSERT INTO ec_visits (vid,ts,data) VALUES ('$vid','$ts','$data')");
                            // Write to the visitor log
                            $visits = 'visits';
                            if (!file_exists($visits)) {
                                mkdir($visits);
                            }
                            $data = json_encode($json);
                            $date = date("Y/m/d H:i", $ts);
                            $file = "$visits/".date("Y", $ts);
                            if (!file_exists($file)) {
                                mkdir($file);
                            }
                            $file .= "/".date("Ymd", $ts).".txt";
                            $fp = fopen($file, "a+");
                            if ($fp) {
                                fwrite($fp, "$data\n");
                                fclose($fp);
                            } else {
                                http_response_code(400);
                                log_error("{\"message\":\"REST: Can't open file '$file'.\"}");
                            }
                        }
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in '$table'.\"}");
                        break;
                    }
                break;
            default:
                http_response_code(404);
                log_error("{\"message\":\"REST: Unknown table '$table'.\"}");
                break;
        }
    }
    
    function ec_getUniqueSlug($conn, $table, $id, $slug) {
        $original = $slug;
        $n = 0;
        while (true) {
            logger("ec_getUniqueSlug: SELECT id from $table WHERE slug='$slug'");
            $result = $conn->query("SELECT id FROM $table WHERE id!=$id AND slug='$slug'");
            if (!mysqli_num_rows($result)) {
                logger("Slug '$slug'");
                return $slug;
            }
            $slug = $original . '-' . ++$n;
        }
    }
    
    function ec_process_section($conn, $page, $name) {
        logger("ec_process_section($page)");
        $name = str_replace(' ', '%20', $name);
        $result = $conn->query("SELECT id FROM nl_sections WHERE page=$page");
        if (mysqli_num_rows($result)) {
            $conn->query("UPDATE nl_sections SET name='$name' WHERE page=$page");
        } else {
            $conn->query("INSERT INTO nl_sections (page,name) VALUES ($page,'$name')");
        }
        mysqli_free_result($result);
    }
    
    function ec_process_author($conn, $page, $name) {
        logger("ec_process_author($page)");
        $name = str_replace(' ', '%20', $name);
        $result = $conn->query("SELECT id FROM nl_authors WHERE page=$page");
        if (mysqli_num_rows($result)) {
            $conn->query("UPDATE nl_authors SET name='$name' WHERE page=$page");
        } else {
            $conn->query("INSERT INTO nl_authors (page,name) VALUES ($page,'$name')");
        }
        mysqli_free_result($result);
    }
    
    function ec_process_tags($conn, $page, $tags) {
        logger("ec_process_tags($page)");
        $result = $conn->query("UPDATE nl_tags SET tag='' WHERE page='$page'");
        $tags = explode(',', $tags);
        foreach ($tags as $tag) {
            $tag = trim($tag);
            $result = $conn->query("SELECT id FROM nl_tags WHERE tag=''");
            if ($row = mysqli_fetch_object($result)) {
                $id = $row->id;
                $conn->query("UPDATE nl_tags SET page=$page,tag='$tag' WHERE id=$id");
            } else {
                $conn->query("INSERT INTO nl_tags (page,tag) VALUES ($page,'$tag')");
            }
            mysqli_free_result($result);
        }
    }
    
    function ec_process_words($conn, $page, $json) {
         logger("ec_process_words($page)");
         $conn->query("UPDATE nl_words SET word='' WHERE page='$page'");
         $fieldNames = array('title', 'synopsis', 'article');
         $words = array();
         foreach ($fieldNames as $fieldName) {
             $ss = explode(' ', $json->$fieldName);
             foreach ($ss as $word) {
                if (strlen($word) > 3 && strlen($word) < 21 && !preg_match('/[^A-Za-z0-9-.]/', $word)) {
                    $word = strtolower($word);
                    while (substr($word, -1) === '.') {
                        $word = substr($word, 0, strlen($word) - 1);
                    }
                    while (substr($word, -1) === '-') {
                        $word = substr($word, 0, strlen($word) - 1);
                    }
                    if (!is_numeric($word)) {
                        $words[] = $word;
                    }
                }
             }
         }
        $words = array_unique($words);
        foreach ($words as $word) {
            $result = $conn->query("SELECT id FROM nl_words WHERE word=''");
            if ($row = mysqli_fetch_object($result)) {
                $id = $row->id;
                $conn->query("UPDATE nl_words SET page=$page,word='$word' WHERE id=$id");
            } else {
                $conn->query("INSERT INTO nl_words (page,word) VALUES ($page,'$word')");
            }
            mysqli_free_result($result);
        }
    }

?>
