<?php


ini_set("display_errors", true);
error_reporting(E_ALL);

require_once('libs/Peregrine.php');
require_once('config.php');

$peregrine = new Peregrine;
$peregrine->init();


// Connect with db
$link = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD);
$db_selected = mysql_select_db(MYSQL_DATABASE, $link);

// @todo handle mysql errors

// Build our query
$sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM prism_actions WHERE 1=1';

    function buildOrQuery( $fieldname, $values ){
        $where = "";
        if(!empty($values)){
            $where .= " AND (";
            $c = 1;
            foreach($values as $val){
                if($c > 1 && $c <= count($values)){
                    $where .= " OR ";
                }
                $where .= $fieldname . " = '".$val."'";
                $c++;
            }
            $where .= ")";
        }
        return $where;
    }

    function buildOrLikeQuery( $fieldname, $values ){
        $where = "";
        if(!empty($values)){
            $where .= " AND (";
            $c = 1;
            foreach($values as $val){
                if($c > 1 && $c <= count($values)){
                    $where .= " OR ";
                }
                $where .= $fieldname . " LIKE '%".$val."%'";
                $c++;
            }
            $where .= ")";
        }
        return $where;
    }


    // World
    if(!$peregrine->post->isEmpty('world')){
        $world = explode(",", $peregrine->post->getUsername('world'));
        $sql .= buildOrQuery('prism_actions.world',$world);
    }

    // Coordinates
    if(!$peregrine->post->isEmpty('x') && !$peregrine->post->isEmpty('y') && !$peregrine->post->isEmpty('z')){
        $x = $peregrine->post->getInt('x');
        $y = $peregrine->post->getInt('y');
        $z = $peregrine->post->getInt('z');
        if(!$peregrine->post->isEmpty('radius')){
            $radius = $peregrine->post->getInt('radius');
            $sql .= ' AND ( prism_actions.x BETWEEN '.($x-$radius) . ' AND '.($x+$radius).' )';
            $sql .= ' AND ( prism_actions.y BETWEEN '.($y-$radius) . ' AND '.($y+$radius).' )';
            $sql .= ' AND ( prism_actions.z BETWEEN '.($z-$radius) . ' AND '.($z+$radius).' )';
        } else {
            $sql .= ' AND prism_actions.x = '.$x;
            $sql .= ' AND prism_actions.y = '.$y;
            $sql .= ' AND prism_actions.z = '.$z;
        }
    }

    // Actions
    if(!$peregrine->post->isEmpty('actions')){
        $actions = explode(",", $peregrine->post->getRaw('actions'));
        $sql .= buildOrQuery('prism_actions.action_type',$actions);
    }
    $sql .= ' AND prism_actions.action_type NOT LIKE "%prism%"';

    // Players
    if(!$peregrine->post->isEmpty('players')){
        $users = explode(",", $peregrine->post->getRaw('players'));
        $sql .= buildOrQuery('prism_actions.player',$users);
    }

    // Entities
    if(!$peregrine->post->isEmpty('entities')){
        $entities = explode(",", $peregrine->post->getRaw('entities'));
        $matches = array();
        if(is_array($entities)){
            foreach($entities as $e){
                $matches[] = 'entity_name":"'.$e;
            }
        }
        $sql .= buildOrLikeQuery('prism_actions.data',$matches);
    }

    // Blocks
    if(!$peregrine->post->isEmpty('blocks')){
        $blocks = explode(",", $peregrine->post->getRaw('blocks'));
        $match = array();
        foreach($blocks as $block){
            $match[] = 'block_id":'.$block.',';
        }
        $sql .= buildOrLikeQuery('prism_actions.data',$match);
    }

    // Timeframe
    if(!$peregrine->post->isEmpty('time')){
        preg_match_all('/([0-9]+)(s|h|m|d|w)/', $peregrine->post->getAlnum('time'), $matches);
        $timeAgo = array();
        if($matches){
            if(is_array($matches[0])){
                foreach($matches[0] as $key => $match){
                    if($matches[2][$key] == "s"){
                        $timeAgo[] = $matches[1][$key] . " seconds";
                    }
                    if($matches[2][$key] == "m"){
                        $timeAgo[] = $matches[1][$key] . " minutes";
                    }
                    if($matches[2][$key] == "h"){
                        $timeAgo[] = $matches[1][$key] . " hours";
                    }
                    if($matches[2][$key] == "d"){
                        $timeAgo[] = $matches[1][$key] . " days";
                    }
                    if($matches[2][$key] == "w"){
                        $timeAgo[] = $matches[1][$key] . " weeks";
                    }
                }
            }
        }
        if(!empty($timeAgo)){
            $beforeDate = date("Y-m-d H:i:s", strtotime( implode(" ", $timeAgo) . " ago" ));
            $sql .= ' AND prism_actions.action_time >=  "'.$beforeDate.'"';
        }
    }


// Order by
$sql .= ' ORDER BY action_time DESC, id DESC';

$response = array(
    'results' => false,
    'total_results' => 0,
    'per_page' => 25,
    'pages' => 0,
    'curr_page' => $peregrine->post->getInt('curr_page')
);


// Limit
$offset = ($response['curr_page']-1)*$response['per_page'];
$sql .= ' LIMIT '.$offset.','.$response['per_page'];

$prism_result = mysql_query( $sql );
if($prism_result){
    $results = array();
    while( $row = mysql_fetch_assoc($prism_result)){
        if(strpos($row['data'], "{") !== false){
            $row['data'] = (array)json_decode($row['data']);
        }
        $results[] = $row;
    }
    $response['results'] = $results;

    // total records
    $prism_result = mysql_query( 'SELECT FOUND_ROWS()' );
    while( $row = mysql_fetch_array($prism_result)){
        $response['total_results'] = $row[0];
    }

    $response['pages'] = ($response['total_results'] > 0 ? ceil($response['total_results'] / $response['per_page']) : 0);
}

header('Content-type: text/javascript');
print json_encode( $response );