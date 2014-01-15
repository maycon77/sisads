<?php
/**
 * Sistema de vendas em jQuery. O PHP é usado apenas como template das páginas
 * funcionando da seguinte forma:
 * 
 * index.php?go=<nomeDaPagina>
 * 
 * nomeDaPagina será carregado como um arquivo PHP na DIV "pagina".
 * js/nomeDaPagna.js será carregado após o jquery carregar
 * 
 * Todo acesso a dados é feito pelo PHP. Cada arquivo PHP possui a parte
 * HTMl e a parte JavaScript no mesmo arquivo, para facilitar
 * 
 */
session_start();
if (isset($_GET["go"])) {
    if(isset($_SESSION['nome'])){
        if (!file_exists($_GET["go"] . ".html"))
            $_GET["go"] = "login";    
    }else{
        $_GET["go"] = "login";
    }
    
}
else {
    $_GET["go"] = "login";
}
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Sistema Vendas</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--<link href="css/bootstrap.metro.min.css" rel="stylesheet"/>-->
        <link href="css/bootstrap.min.css" rel="stylesheet"/>
        <link href="css/bootstrap-responsive.min.css" rel="stylesheet"/>
        <link href="css/base/jquery-ui.css" rel="stylesheet"/>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->


        <link href="css/app.css" rel="stylesheet"/>
    </head>
    <body>

        <div class="navbar navbar-inverse">
            <div class="navbar-inner">
                <div class="container" style="width:auto">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="index.php?go=bemVindo">ADS MOVEIS</a>
                    <div class="nav-collapse">
                        <ul class="nav">

                            <?php

                            //Obtém o session da pessoa logada
                            /*Fazer verificação via Session*/
                            if(isset($_SESSION['nome'])){
                            ?>
                                                            
                                    <li ><a href='index.php?go=bemVindo'>Home</a></li>
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Clientes<span class="caret"></span></a>
                                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                            <a  href="index.php?go=clientes" style="display:block;">Cadastro</a>
                                            <a  href="#">Relatório</a>
                                        </ul>
                                    </li>
                                    <li ><a href='#'>Compras</a></li>
                                    <li ><a href='#'>Financeiro</a></li>
                                    <li ><a href='#'>Relatórios</a></li>
                                    
                          <?php      
                            }
                            ?>


                        </ul>

                        <p class="navbar-text pull-right">Olá <?php echo "{$_SESSION['nome']}"; ?> <a id="linkSair" href="#" class="navbar-link">[Sair]</a></p>

                    </div><!--/.nav-collapse -->
                </div>
            </div>
        </div>

        <div class="container">
            <?php require($_GET["go"] . ".html") ?>
        </div> <!-- /container -->

        <script src="js/libs/jquery.js" type="text/javascript"></script>
        <script src="js/libs/jquery-ui-1.10.0.custom.min.js" type="text/javascript"></script>
        <script src="js/libs/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/libs/jquery.cookie.js" type="text/javascript"></script>
        <script src="js/libs/jquery.maskMoney.js" type="text/javascript"></script>        
        <script src="js/app.js" type="text/javascript"></script>
        
        <!-- toda página tem o seu arquivo JS relativo -->
        <script src="<?php echo 'js/'.$_GET["go"] . ".js"?>" type="text/javascript"></script>
        
    </body>
</html>