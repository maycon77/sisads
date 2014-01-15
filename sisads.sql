/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50612
Source Host           : localhost:3306
Source Database       : sisads

Target Server Type    : MYSQL
Target Server Version : 50612
File Encoding         : 65001

Date: 2013-11-11 09:04:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(30) NOT NULL,
  `password` varchar(15) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `lastIp` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_admin_usuario_1` (`idUsuario`),
  CONSTRAINT `fk_admin_usuario_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('3', 'a', 'a', '3', '2013-11-11 08:22:57', '127.0.0.1');

-- ----------------------------
-- Table structure for `chequesemitidos`
-- ----------------------------
DROP TABLE IF EXISTS `chequesemitidos`;
CREATE TABLE `chequesemitidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destino` varchar(255) NOT NULL,
  `dataDesconto` date NOT NULL,
  `idContasPagar` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chequesemitidos_contaspagar_1` (`idContasPagar`),
  CONSTRAINT `fk_chequesemitidos_contaspagar_1` FOREIGN KEY (`idContasPagar`) REFERENCES `contaspagar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chequesemitidos
-- ----------------------------

-- ----------------------------
-- Table structure for `chequesrebidos`
-- ----------------------------
DROP TABLE IF EXISTS `chequesrebidos`;
CREATE TABLE `chequesrebidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPagamento` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `dataDescontar` date NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chequesrebidos_pedidospagamentos_1` (`idPagamento`),
  CONSTRAINT `fk_chequesrebidos_pedidospagamentos_1` FOREIGN KEY (`idPagamento`) REFERENCES `pedidospagamentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chequesrebidos
-- ----------------------------

-- ----------------------------
-- Table structure for `clientes`
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `cpf` char(11) DEFAULT NULL,
  `cnpj` char(14) DEFAULT NULL,
  `ie` char(14) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_clientes_usuario_1` (`idUsuario`),
  CONSTRAINT `fk_clientes_usuario_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES ('1', '4', '11231231312', '', null);

-- ----------------------------
-- Table structure for `compra_notas`
-- ----------------------------
DROP TABLE IF EXISTS `compra_notas`;
CREATE TABLE `compra_notas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `numero` int(11) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data` date NOT NULL,
  `idForncedor` int(11) NOT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1',
  `statusPag` smallint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_compra_notas_usuario_1` (`idForncedor`),
  CONSTRAINT `fk_compra_notas_usuario_1` FOREIGN KEY (`idForncedor`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of compra_notas
-- ----------------------------

-- ----------------------------
-- Table structure for `contasbancarias`
-- ----------------------------
DROP TABLE IF EXISTS `contasbancarias`;
CREATE TABLE `contasbancarias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agencia` int(10) NOT NULL,
  `banco` int(10) NOT NULL,
  `nomeBanco` varchar(30) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `saldoInicial` decimal(8,2) NOT NULL,
  `dataCadastro` date NOT NULL,
  `status` int(1) NOT NULL,
  `dataUpdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contasBancarias_usuario_1` (`idUsuario`),
  CONSTRAINT `fk_contasBancarias_usuario_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contasbancarias
-- ----------------------------

-- ----------------------------
-- Table structure for `contaspagar`
-- ----------------------------
DROP TABLE IF EXISTS `contaspagar`;
CREATE TABLE `contaspagar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `dataCadastro` date NOT NULL,
  `dataVencimento` date NOT NULL,
  `dataPagamento` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of contaspagar
-- ----------------------------

-- ----------------------------
-- Table structure for `controlecaixa`
-- ----------------------------
DROP TABLE IF EXISTS `controlecaixa`;
CREATE TABLE `controlecaixa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idMovimento` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of controlecaixa
-- ----------------------------

-- ----------------------------
-- Table structure for `descontos_pedidos`
-- ----------------------------
DROP TABLE IF EXISTS `descontos_pedidos`;
CREATE TABLE `descontos_pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPedidos` int(11) NOT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `fk_descontos_pedidos_pedidos_1` (`idPedidos`),
  CONSTRAINT `fk_descontos_pedidos_pedidos_1` FOREIGN KEY (`idPedidos`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of descontos_pedidos
-- ----------------------------

-- ----------------------------
-- Table structure for `especie`
-- ----------------------------
DROP TABLE IF EXISTS `especie`;
CREATE TABLE `especie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of especie
-- ----------------------------

-- ----------------------------
-- Table structure for `fornecedores`
-- ----------------------------
DROP TABLE IF EXISTS `fornecedores`;
CREATE TABLE `fornecedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `cnpj` char(14) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fornecedores_usuarios_1` (`idUsuario`),
  CONSTRAINT `fk_fornecedores_usuarios_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fornecedores
-- ----------------------------

-- ----------------------------
-- Table structure for `movimentosbancarios`
-- ----------------------------
DROP TABLE IF EXISTS `movimentosbancarios`;
CREATE TABLE `movimentosbancarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idConta` int(11) NOT NULL,
  `tipo` char(1) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `data` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `status` int(1) NOT NULL,
  `dataUpdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_movimentosBancarios_contasBancarias_1` (`idConta`),
  CONSTRAINT `fk_movimentosBancarios_contasBancarias_1` FOREIGN KEY (`idConta`) REFERENCES `contasbancarias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movimentosbancarios
-- ----------------------------

-- ----------------------------
-- Table structure for `pedidos`
-- ----------------------------
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` char(1) NOT NULL,
  `data` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `statusPagamento` int(11) NOT NULL,
  `statusDelete` smallint(1) NOT NULL,
  `dataDelete` date DEFAULT NULL,
  `dataPrazo` date DEFAULT NULL,
  `dataEntrega` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedidos_status_pedido_1` (`status`),
  KEY `fk_pedidos_clientes_1` (`idCliente`),
  CONSTRAINT `fk_pedidos_clientes_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_pedidos_status_pedido_1` FOREIGN KEY (`status`) REFERENCES `status_pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pedidos
-- ----------------------------

-- ----------------------------
-- Table structure for `pedidositens`
-- ----------------------------
DROP TABLE IF EXISTS `pedidositens`;
CREATE TABLE `pedidositens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qtd` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `vlrUnitario` decimal(8,2) NOT NULL,
  `idPedido` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedidosItens_pedidos_1` (`idPedido`),
  CONSTRAINT `fk_pedidosItens_pedidos_1` FOREIGN KEY (`idPedido`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pedidositens
-- ----------------------------

-- ----------------------------
-- Table structure for `pedidospagamentos`
-- ----------------------------
DROP TABLE IF EXISTS `pedidospagamentos`;
CREATE TABLE `pedidospagamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPedido` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `dataVencimento` date NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `especie` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `status` smallint(1) NOT NULL,
  `statusDelete` smallint(1) NOT NULL,
  `dataDelete` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedidospagamentos_pedidos_1` (`idPedido`),
  KEY `fk_pedidospagamentos_especie_1` (`especie`),
  CONSTRAINT `fk_pedidospagamentos_especie_1` FOREIGN KEY (`especie`) REFERENCES `especie` (`id`),
  CONSTRAINT `fk_pedidospagamentos_pedidos_1` FOREIGN KEY (`idPedido`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pedidospagamentos
-- ----------------------------

-- ----------------------------
-- Table structure for `producao`
-- ----------------------------
DROP TABLE IF EXISTS `producao`;
CREATE TABLE `producao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPedido` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `dataUpdate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_producao_pedidos_1` (`idPedido`),
  KEY `fk_producao_status_producao_1` (`status`),
  CONSTRAINT `fk_producao_pedidos_1` FOREIGN KEY (`idPedido`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `fk_producao_status_producao_1` FOREIGN KEY (`status`) REFERENCES `status_producao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of producao
-- ----------------------------

-- ----------------------------
-- Table structure for `status_pedidos`
-- ----------------------------
DROP TABLE IF EXISTS `status_pedidos`;
CREATE TABLE `status_pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of status_pedidos
-- ----------------------------

-- ----------------------------
-- Table structure for `status_producao`
-- ----------------------------
DROP TABLE IF EXISTS `status_producao`;
CREATE TABLE `status_producao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of status_producao
-- ----------------------------

-- ----------------------------
-- Table structure for `tipo_usuarios`
-- ----------------------------
DROP TABLE IF EXISTS `tipo_usuarios`;
CREATE TABLE `tipo_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tipo_usuarios
-- ----------------------------
INSERT INTO `tipo_usuarios` VALUES ('1', 'cliente');
INSERT INTO `tipo_usuarios` VALUES ('2', 'fornecedor');
INSERT INTO `tipo_usuarios` VALUES ('3', 'administrador');

-- ----------------------------
-- Table structure for `usuarios`
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `endereco` varchar(80) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `bairro` varchar(80) DEFAULT NULL,
  `cidade` int(10) NOT NULL,
  `uf` int(11) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `obs` text,
  `tipo` int(11) NOT NULL,
  `telefone` char(10) DEFAULT NULL,
  `celular` char(10) DEFAULT NULL,
  `data_cad` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuario_tipo_usuario_1` (`tipo`),
  CONSTRAINT `fk_usuario_tipo_usuario_1` FOREIGN KEY (`tipo`) REFERENCES `tipo_usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES ('3', 'maycon', 'braz izo', '123', 'fadsfas', '1', '2', 'maydg@hotmail.com', 'fadfa', '3', '0000000000', '0000000000', '2013-11-04');
INSERT INTO `usuarios` VALUES ('4', 'cliente', 'yromo dfaji', '243', 'dadfkljl', '1', '2', 'maydg@dfd', 'fdaffda', '1', '000000', '00000000', '2013-11-11');
