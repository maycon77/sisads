<?php
session_start();

require_once 'DB.php';
require_once 'config.php';

require 'Slim/Slim.php';

\Slim\Slim::registerAutoloader();


$app = new \Slim\Slim(array(
	'debug' => false
));

$app->contentType("application/json");

$app->error(function (Exception $e) use ($app) {
    $erroObj = new stdClass();
    $erroObj->message = $e->getMessage();
    $erroObj->file = $e->getFile();
    $erroObj->line = $e->getLine();

    echo "{ 'error': " . json_encode($erroObj) . " }";
});


$app->get('/:controller/:action(/:parameter)', function ($controller, $action, $parameter = null) {
        include_once "classes/{$controller}.php";
        $classe = new $controller();
        $retorno = call_user_func_array(array($classe,"get_" . $action),
         array($parameter));
        echo '{"result":'.json_encode($retorno).'}';
    });

// POST route
$app->post('/:controller/:action', function($controller, $action) use ($app){
    $request = json_decode(\Slim\Slim::getInstance()->request()->getBody());
    include_once "classes/{$controller}.php";
    $classe = new $controller();
    $retorno = call_user_func_array(array($classe, 'post_' . $action),
        array($request));
    echo '{"result":'. json_encode($retorno) .'}';
});

$app->run();
