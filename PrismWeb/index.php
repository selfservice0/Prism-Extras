<?php

require_once('config.php');

if(!$auth->authUser( $peregrine->session->getUsername('username'), $peregrine->session->getRaw('token'))){
//    exit;
}

?>
<!DOCTYPE html>
<html>
    <head>
        <title>Prism</title>
        <meta charset="utf-8" />
        <link href="./css/bootstrap.min.css" media="all" rel="stylesheet">
        <link href="./css/app.css" media="all" rel="stylesheet">
    </head>
    <body>
        <article>
            <div class="container">
                <h1>Prism</h1>
                <form id="frm-search" action="#" method="post">
                    <input type="hidden" id="curr_page" name="curr_page" value="1" />
                    <div class="row">
                        <fieldset class="span6">
                            <div class="well">
                                <div class="row">
                                    <div class="control-group span2">
                                        <label class="control-label" for="world">World</label>
                                        <div class="controls">
                                            <input type="text" class="span2" placeholder="world" id="world" name="world" value="">
                                        </div>
                                    </div>
                                    <div class="control-group span1">
                                        <label class="control-label" for="x">X</label>
                                        <div class="controls">
                                            <input type="text" class="span1" placeholder="" id="x" name="x" value="">
                                        </div>
                                    </div>
                                    <div class="control-group span1">
                                        <label class="control-label" for="y">Y</label>
                                        <div class="controls">
                                            <input type="text" class="span1" placeholder="" id="y" name="y" value="">
                                        </div>
                                    </div>
                                    <div class="control-group span1">
                                        <label class="control-label" for="z">Z</label>
                                        <div class="controls">
                                            <input type="text" class="span1" placeholder="" id="z" name="z" value="">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="control-group span1">
                                        <label class="control-label" for="radius">Radius</label>
                                        <div class="controls">
                                            <input type="text" class="span1" placeholder="20" id="radius" name="radius" value="">
                                        </div>
                                    </div>
                                    <div class="control-group span4">
                                        <label class="control-label" for="players">Players</label>
                                        <div class="controls">
                                            <input type="text" class="span4" placeholder="viveleroi" id="players" name="players" value="">
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="entities">Entities</label>
                                    <div class="controls">
                                        <input type="text" class="span5" placeholder="sheep" id="entities" name="entities" value="">
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset class="span6">
                            <div class="well">
                                <div class="control-group">
                                    <label class="control-label" for="actions">Actions</label>
                                    <div class="controls">
                                        <input type="text" class="span5" placeholder="break,burn" id="actions" name="actions" value="">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="blocks">Blocks</label>
                                    <div class="controls">
                                        <input type="text" class="span5" placeholder="2,3" id="blocks" name="blocks" value="">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="time">Time Since</label>
                                    <div class="controls">
                                        <input type="text" class="span5" placeholder="1h" id="time" name="time" value="">
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <button id="submit" type="submit" class="">Search</button>
                </form>
                <div id="results">
                    <div class="meta">
                        <div>Found <span>897</span> records. Page <span>1</span> of <span>200</span></div>
                        <ol>
                           <li>1</li>
                        </ol>
                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>World</th>
                                <th>Loc</th>
                                <th>Action</th>
                                <th>Player</th>
                                <th>Data</th>
                                <th>Timestamp</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
                <footer><p>2013 &mdash; By Viveleroi</p></footer>
            </div>
        </article>
        <script src="js/jquery.js"></script>
        <script src="js/app.js"></script>
    </body>
</html>
