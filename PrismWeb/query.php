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
$sql = 'SELECT * FROM prism_actions WHERE 1=1';



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
    $sql .= ' AND LEFT(prism_actions.action_type,5) !=  "prism"';

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

//    // Timeframe
//    if(!$peregrine->post->isEmpty('time')){
//        $world = explode(",", $peregrine->post->getUsername('time'));
//        $sql .= buildOrQuery('prism_actions.world',$world);
//    }


// Order by
$sql .= ' ORDER BY action_time DESC, id DESC';

// Limit
$sql .= ' LIMIT 0,25';


$results = array();

$prism_result = mysql_query($sql);
if($prism_result){
    while( $row = mysql_fetch_assoc($prism_result)){

        if(strpos($row['data'], "{") !== false){
            $row['data'] = (array)json_decode($row['data']);
        }

        $results[] = $row;

    }
}

print json_encode( array('results'=>$results) );