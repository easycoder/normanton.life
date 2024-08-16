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
            case 'articles':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/articles/count
                        // Return the number of public items in the table
                        $result = $conn->query("SELECT id from articles WHERE pub=1");
                        //print "{\"count\":".mysqli_num_rows($result)."}";
                        print mysqli_num_rows($result);
                        break;
                    case 'countAll':
                        // Endpoint: {site root}/rest.php/_/articles/countAll
                        // Return the total number of items in the table
                        $result = $conn->query("SELECT id from articles");
                        //print "{\"count\":".mysqli_num_rows($result)."}";
                        print mysqli_num_rows($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/articles/list/[filter]
                        // List the ids of articles in the range specified
                        // Get the filter
                        $filter = "all";
                        if (in_array($request[0], array('waiting', 'all'))) {
                            $filter = $request[0];
                        }
                        switch ($filter) {
                            case 'waiting':
                                $result = $conn->query("SELECT id FROM articles WHERE waiting=1 ORDER BY id ASC");
                                break;
                            case 'all':
                                $result = $conn->query("SELECT id FROM articles ORDER BY id ASC LIMIT 0, 100");
                                break;
                        }
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
                        // Endpoint: {site root}/rest.php/_/articles/id/{id}
                        // Get a record given its id
                        $id = $request[0];
                        $result = $conn->query("SELECT null FROM articles WHERE id='$id'");
                        if ($row = mysqli_fetch_object($result)) {
                            $value = getArticle($id, false);
                            print json_encode($value);
                        }
                        break;
                    case 'slug':
                        // Endpoint: {site root}/rest.php/_/articles/slug/[s/u]/{slug}
                        // Get a record given its slug
                        $version = $request[0];
                        $slug = $request[1];
                        // print("SELECT id FROM articles WHERE slug='$slug'\n");
                        $result = $conn->query("SELECT id FROM articles WHERE slug='$slug'");
                        if ($row = mysqli_fetch_object($result)) {
                            $value = getArticle($row->id, $version == 's');
                            print json_encode($value);
                        } else {
                            http_response_code(404);
                            log_error("{\"message\":\"REST: Slug '$slug' not found.\"}");
                            break;
                         }
                        break;
                    case 'get':
                        // Endpoint: {site root}/rest.php/_/articles/get/{user}/[{filter}/{name}][{offset}/][{count}]
                        // Get all the public articles in the range specified
                        // First see if the user is admin
                        // print_r($request);print "\n";
                        $user = $request[0];
                        if ($user == "-") {
                            $admin = 0;
                        } else {
                            $result = $conn->query("SELECT admin FROM ec_user WHERE name='$user'");
                            $row = mysqli_fetch_object($result);
                            $admin = $row->admin;
                            mysqli_free_result($result);
                        }
                        // print "User:$user, admin:$admin\n";

                        // Get the filter
                        array_shift($request);
                        $filter = "all";
                        if (in_array($request[0], array('section', 'author', 'tag', 'waiting', 'all'))) {
                            $filter = $request[0];
                        }
                        // print "Filter:$filter\n";

                        // Get the section or author
                        array_shift($request);
                        if (count($request) > 0) {
                            $name = $request[0];
                            array_shift($request);
                        }
                        // print "Name:$name\n";

                        // Get the offset and count
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
                                $where = "WHERE section='$name'";
                                if (!$admin) {
                                    $where .= " AND pub=1";
                                }
                                $result = $conn->query("SELECT * FROM articles $where ORDER BY published DESC LIMIT $offset, $count");
                                break;
                            case 'author':
                                $where = "WHERE author='$name'";
                                if (!$admin) {
                                    $where .= " AND section!='' AND (author='$user' OR pub=1)";
                                }
                                // print("SELECT* FROM articles $where ORDER BY published DESC LIMIT $offset, $count\n");
                                $result = $conn->query("SELECT * FROM articles $where ORDER BY published DESC LIMIT $offset, $count");
                                break;
                            case 'tag':
                                // $filter = 'tags';
                                // $result = $conn->query("SELECT articles.saved from articles
                                //     INNER JOIN $filter ON $filter.page = articles.id
                                //     WHERE  pub=1 AND tag='" . str_replace(' ', '%20', $author)
                                //         ."'ORDER BY articles.published DESC LIMIT $offset, $count");
                                break;
                            case 'waiting':
                                // print("SELECT * FROM articles WHERE waiting=1\n");
                                $result = $conn->query("SELECT * FROM articles WHERE waiting=1");
                                break;
                            case 'all':
                                $where = $admin ? "" : "WHERE section!='' AND (pub=1 OR author='$user')";
                                // print("SELECT * FROM articles $where ORDER BY published DESC LIMIT $offset, $count\n");
                                $result = $conn->query("SELECT * FROM articles $where ORDER BY published DESC LIMIT $offset, $count");
                                break;
                        }

                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            $id = $row->id;
                            if ($filter == 'waiting') {
                                $content = getArticle($id, false);
                            } else {
                                $author = $row->author;
                                $pub = $row->pub;
                                if ($filter == 'author' && $admin == 1) {
                                    $content = getArticle($id, false);
                                } else {
                                    if ($author == $user) {
                                        $content = getArticle($id, false);
                                    } else {
                                        $content = getArticle($id, true);
                                    }
                                }
                            }
                            if ($content) {
                                if ($response != '[') {
                                    $response .= ",\n";
                                }
                                $content->pub = $pub;
                                $response .= json_encode($content);
                            }
                        }
                        $response .= ']';
                        mysqli_free_result($result);
                        print $response;
                        break;
                    case 'lead':
                        // Endpoint: {site root}/rest.php/_/articles/lead/{section}
                        // Get the lead article for a given section
                        $section = $request[0];
                        $result = $conn->query("SELECT slug from articles WHERE section='$section' ORDER BY published ASC");
                        if ($row = mysqli_fetch_object($result)) {
                            $slug = $row->slug;
                            print "$slug\n";
                        } else {
                            http_response_code(404);
                            log_error("{\"message\":\"Unknown section '$section'.\"}");
                        }
                        mysqli_free_result($result);
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in 'articles'.\"}");
                        break;
                    }
                break;
            case 'sections':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/sections/count/{section}
                        // Return the number of articles in this section
                        $name = $request[0];
                        $result = $conn->query("SELECT id from articles
                            WHERE section='" . str_replace(' ', '%20', $name) ."'");
                        print mysqli_num_rows($result);
                        mysqli_free_result($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/sections/list/{section}
                        // List the article IDs from this section
                        $name = $request[0];
                        $result = $conn->query("SELECT id from articles
                            WHERE section='" . str_replace(' ', '%20', $name) ."'");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->id;
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    case 'enum':
                        // Endpoint: {site root}/rest.php/_/sections/enum
                        // Enumerate sections
                        $result = $conn->query("SELECT DISTINCT section from articles");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            $section = $row->section;
                            if ($section) {
                                if ($response != '[') {
                                    $response .= ',';
                                }
                                $response .= "\"$section\"";
                            }
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in 'sections'.\"}");
                        break;
                }
                break;
            case 'authors':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/authors/count/{author}
                        // Return the number of articles from this author
                        $name = $request[0];
                        $result = $conn->query("SELECT id from articles
                            WHERE author='" . str_replace(' ', '%20', $name) ."'");
                        print mysqli_num_rows($result);
                        mysqli_free_result($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/authors/list/{author}
                        // List the article IDs from this author
                        $name = $request[0];
                        $result = $conn->query("SELECT id from articles
                            WHERE author='" . str_replace(' ', '%20', $name) ."'");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            if ($response != '[') {
                                $response .= ',';
                            }
                            $response .= $row->id;
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    case 'enum':
                        // Endpoint: {site root}/rest.php/_/authors/enum
                        // Enumerate authors
                        $result = $conn->query("SELECT DISTINCT author from articles");
                        $response = '[';
                        while ($row = mysqli_fetch_object($result)) {
                            $author = $row->author;
                            if ($author) {
                                if ($response != '[') {
                                    $response .= ',';
                                }
                                $response .= "\"$author\"";
                            }
                        }
                        $response .= ']';
                        print $response;
                        mysqli_free_result($result);
                        break;
                    default:
                        http_response_code(404);
                        log_error("{\"message\":\"REST: Unknown action '$action' in 'authors'.\"}");
                        break;
                }
                break;
            case 'tags':
                switch ($action) {
                    case 'count':
                        // Endpoint: {site root}/rest.php/_/tags/count/{tag}
                        // Return the number of items with this tag
                        $tag = $request[0];
                        $result = $conn->query(
                            "SELECT articles.id from tags INNER JOIN articles
                              ON tags.page = articles.id WHERE tag='$tag'");
                        print mysqli_num_rows($result);
                        break;
                    case 'list':
                        // Endpoint: {site root}/rest.php/_/tags/list/{tag}
                        $tag = $request[0];
                        $result = $conn->query(
                            "SELECT articles.id from tags INNER JOIN articles
                              ON tags.page = articles.id WHERE tag='$tag'");
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
                        // Endpoint: {site root}/rest.php/_/tags/tags
                        $id = $request[0];
                        $result = $conn->query("SELECT tag FROM tags WHERE page=$id");
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
                        log_error("{\"message\":\"REST: Unknown action '$action' in 'tags'.\"}");
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
           case 'articles':
                 switch ($action) {
                    case 'update':
                        // Endpoint: {site root}/rest.php/_/articles/update/{id}
                        // Update an article record
                        $id = $request[0];
                        header("Content-Type: application/json");
                        $value = stripslashes(file_get_contents("php://input"));
                        $json = json_decode($value);
                        $slug = $json->slug;
                        $section = $json->section;
                        $author = $json->author;
                        $published = $json->published;
                        // See if there's an item with this id;
                        if (is_numeric($id)) {
                            logger("SELECT id FROM articles WHERE id=$id");
                            $result = $conn->query("SELECT id FROM articles WHERE id=$id");
                        } else {
                            logger("SELECT id FROM articles WHERE slug='$id'");
                            $result = $conn->query("SELECT id FROM articles WHERE slug='$id'");
                        }
                        $json->id = $id;

                        saveArticle($json, false);

                        // Update the article record
                        if ($row = mysqli_fetch_object($result)) {
                             // It exists, so update it
                            $id = $row->id;
                            $slug = ec_getUniqueSlug($conn, $id, $slug);
                            $json->slug = $slug;
                            logger("UPDATE articles SET slug='$slug',section='$section',author='$author',published=$published,ts=$ts WHERE id=$id");
                            $conn->query("UPDATE articles SET slug='$slug',section='$section',author='$author',published=$published,ts=$ts WHERE id=$id");
                            ec_process_tags($conn, $id, $json->tags);
                            ec_process_words($conn, $id, $json);
                            print 'OK';
                        } else {
                            // Not found
                            http_response_code(404);
                            log_error("{\"code\":\"404\",\"message\":\"Cannot update record $id of articles.\"}");
                        }
                        break;
                    case 'new':
                        // Endpoint: {site root}/rest.php/_/articles/new
                        // Add a new record
                        $name = $request[0];
                        header("Content-Type: application/json");
                        $value = stripslashes(file_get_contents("php://input"));
                        $json = json_decode($value);
                        $author = $json->author;
                        $published = $json->published;
                        $conn->query("INSERT INTO articles (author,published,ts) VALUES ('$author','$published','$ts')");
                        $id = mysqli_insert_id($conn);
                        $json->id = $id;
                        $json->title = "Record $id";
                        $json->slug = "record-$id";
                        saveArticle($json, false);
                        $value = json_encode($json);
                        $conn->query("UPDATE articles SET slug='record-$id' WHERE id=$id");
                        http_response_code(201);
                        print $value;
                        break;
                    case 'request-release':
                        // Endpoint: {site root}/rest.php/_/articles/request-release/{id}
                        // Request to release a new or updated record
                        $id = $request[0];
                        $conn->query("UPDATE articles SET waiting=1 WHERE id=$id");
                        print "OK";
                        break;
                    case 'release':
                        // Endpoint: {site root}/rest.php/_/articles/release/{id}
                        // Release a record
                        $id = $request[0];
                        $article = getArticle($id, false);
                        saveArticle($article, true);
                        $conn->query("UPDATE articles SET waiting=0,pub=1 WHERE id=$id");
                        print "OK";
                        break;
                    default:
                        http_response_code(400);
                        log_error("{\"message\":\"Action '$action' should be 'update' or 'new'.\"}");
                        break;
                }
                break;
            case 'tags':
                switch ($action) {
                    case 'set':
                        ec_process_tags($conn, $request[0], $request[1]);
                        print 'OK';
                        break;
                    default:
                        http_response_code(400);
                        log_error("{\"message\":\"REST: Unknown action '$action' in 'articles'.\"}");
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
                        log_error("{\"message\":\"REST: Unknown action '$action' in 'articles'.\"}");
                        break;
                    }
                break;
            default:
                http_response_code(404);
                log_error("{\"message\":\"REST: Unknown identifier '$table'.\"}");
                break;
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // Save an article to the server, into 'unsaved'
    function saveArticle($json, $saved) {
        $id = $json->id;
        $group = intval(intval($id) / 1000);
        $articles = "resources/articles/$group/" . ($saved ? "saved" : "unsaved");
        if (!file_exists($articles)) {
            $result = mkdir($articles, 0777, true);
        }
        while (strlen($id) < 3) {
            $id = '0' . $id;
        }
        $file = getRoot() . "$articles/$id";
        $fp = fopen($file, "w");
        if ($fp) {
            fwrite($fp, json_encode($json));
            fclose($fp);
        } else {
            http_response_code(400);
            log_error("{\"message\":\"REST: Can't open file '$file'.\"}");
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // Get an article from the server
    function getArticle($id, $saved) {
        $group = intval(intval($id) / 1000);
        $articles = "resources/articles/$group/" . ($saved ? "saved" : "unsaved");
        while (strlen($id) < 3) {
            $id = '0' . $id;
        }
        $file = getRoot() . "$articles/$id";
        if (file_exists($file)) {
            $content = file_get_contents($file);
        } else {
            $content = "";
        }
        return json_decode($content);
    }

    /////////////////////////////////////////////////////////////////////////
    function ec_getUniqueSlug($conn, $id, $slug) {
        $original = $slug;
        $n = 0;
        while (true) {
            logger("ec_getUniqueSlug: SELECT id from articles WHERE slug='$slug'");
            $result = $conn->query("SELECT id FROM articles WHERE id!=$id AND slug='$slug'");
            if (!mysqli_num_rows($result)) {
                logger("Slug '$slug'");
                return $slug;
            }
            $slug = $original . '-' . ++$n;
        }
    }
    
    /////////////////////////////////////////////////////////////////////////
    function ec_process_tags($conn, $page, $tags) {
        logger("ec_process_tags($page)");
        $result = $conn->query("UPDATE tags SET tag='' WHERE page='$page'");
        $tags = explode(',', $tags);
        foreach ($tags as $tag) {
            $tag = trim($tag);
            $result = $conn->query("SELECT id FROM tags WHERE tag=''");
            if ($row = mysqli_fetch_object($result)) {
                $id = $row->id;
                $conn->query("UPDATE tags SET page=$page,tag='$tag' WHERE id=$id");
            } else {
                $conn->query("INSERT INTO tags (page,tag) VALUES ($page,'$tag')");
            }
            mysqli_free_result($result);
        }
    }
    
    /////////////////////////////////////////////////////////////////////////
    function ec_process_words($conn, $page, $json) {
         logger("ec_process_words($page)");
         $conn->query("UPDATE words SET word='' WHERE page='$page'");
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
            $result = $conn->query("SELECT id FROM words WHERE word=''");
            if ($row = mysqli_fetch_object($result)) {
                $id = $row->id;
                $conn->query("UPDATE words SET page=$page,word='$word' WHERE id=$id");
            } else {
                $conn->query("INSERT INTO words (page,word) VALUES ($page,'$word')");
            }
            mysqli_free_result($result);
        }
    }

?>
