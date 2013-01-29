<?php
/**
 *
 */
class Prism {

    /**
     * @var array|void
     */
    protected $items = array();


    /**
     *
     */
    public function __construct(){
        $this->parseItemList();
    }


    /**
     *
     */
    public function getActionTypes(){

        return array(
        'block-break',
        'block-burn',
        'block-fade',
        'block-fall',
        'block-form',
        'block-place',
        'block-shift',
        'block-spread',
        'block-use',
        'bonemeal-use',
        'container-access',
        'creeper-explode',
        'crop-trample',
        'enderman-pickup',
        'enderman-place',
        'entity-break',
        'entity-explode',
        'entity-follow',
        'entity-kill',
        'entity-shear',
        'entity-spawn',
        'fireball',
        'hangingitem-break',
        'hangingitem-place',
        'item-drop',
        'item-insert',
        'item-pickup',
        'item-remove',
        'lava-break',
        'lava-bucket',
        'lava-flow',
        'lava-ignite',
        'leaf-decay',
        'lighter',
        'lightning',
        'mushroom-grow',
        'player-chat',
        'player-command',
        'player-death',
        'player-join',
        'player-quit',
        'sheep-eat',
        'sign-change',
        'spawnegg-use',
        'tnt-explode',
        'tnt-prime',
        'tree-grow',
        'water-break',
        'water-bucket',
        'water-flow',
        'world-edit'
        );
    }


    /**
     * @return array|void
     */
    public function getItemList(){
        return $this->items;
    }


    /**
     *
     */
    protected function parseItemList(){

        $items = array();

        $path = str_replace("libs", "js", dirname(__FILE__));

        if(file_exists($path . DIRECTORY_SEPARATOR . 'items.json')){
            $fcontents = file_get_contents( $path . DIRECTORY_SEPARATOR . 'items.json');
            if($fcontents){
                $items = (array)json_decode($fcontents, true);
                if($items){
                    asort($items);
                    $this->items = $items;
                }
            }
        }
    }
}
