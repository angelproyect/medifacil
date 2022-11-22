/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100902
 Source Host           : localhost:3306
 Source Schema         : medifacil

 Target Server Type    : MySQL
 Target Server Version : 100902
 File Encoding         : 65001

 Date: 22/11/2022 00:04:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bitacora
-- ----------------------------
DROP TABLE IF EXISTS `bitacora`;
CREATE TABLE `bitacora`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `fk_empleado` int NOT NULL,
  `fecha_entrada` date NOT NULL,
  `tiempo_trascurrido` time(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `fkempleado`(`fk_empleado`) USING BTREE,
  CONSTRAINT `fkempleado` FOREIGN KEY (`fk_empleado`) REFERENCES `empleados` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for caja
-- ----------------------------
DROP TABLE IF EXISTS `caja`;
CREATE TABLE `caja`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Total` double NOT NULL,
  `IVA` double NOT NULL,
  `Subtotal` double NOT NULL,
  `FK_idmetodo` int NOT NULL,
  `Fecha_compra` date NOT NULL,
  `Fk_empleado` int NOT NULL,
  `Factura` int NOT NULL,
  `Remision` int NOT NULL,
  `Descuento` double NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `metodofk`(`FK_idmetodo`) USING BTREE,
  INDEX `empleadofk7`(`Fk_empleado`) USING BTREE,
  CONSTRAINT `empleadofk7` FOREIGN KEY (`Fk_empleado`) REFERENCES `empleados` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `metodofk` FOREIGN KEY (`FK_idmetodo`) REFERENCES `metodopago` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cajadetalle
-- ----------------------------
DROP TABLE IF EXISTS `cajadetalle`;
CREATE TABLE `cajadetalle`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fk_idproducto` int NOT NULL,
  `Cantidad` int NULL DEFAULT NULL,
  `Fk_idcaja` int NOT NULL,
  `Precio` double NOT NULL,
  `Descuento` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `cajafk`(`Fk_idcaja`) USING BTREE,
  INDEX `productoidfk2`(`Fk_idproducto`) USING BTREE,
  CONSTRAINT `cajafk` FOREIGN KEY (`Fk_idcaja`) REFERENCES `caja` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productoidfk2` FOREIGN KEY (`Fk_idproducto`) REFERENCES `productos` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for consultas
-- ----------------------------
DROP TABLE IF EXISTS `consultas`;
CREATE TABLE `consultas`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fk_medico` int NOT NULL,
  `Fk_paciente` int NOT NULL,
  `FK_medicamentos` int NULL DEFAULT NULL,
  `Diagnostico` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Peso` float NULL DEFAULT NULL,
  `Estatura` float NULL DEFAULT NULL,
  `Sintomas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Temperatura` float NULL DEFAULT NULL,
  `Presion` float NULL DEFAULT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `medicofk3`(`Fk_medico`) USING BTREE,
  INDEX `pacienteFk3`(`Fk_paciente`) USING BTREE,
  CONSTRAINT `medicofk3` FOREIGN KEY (`Fk_medico`) REFERENCES `medicos` (`ID_medico`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pacienteFk3` FOREIGN KEY (`Fk_paciente`) REFERENCES `pacientes` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for empleados
-- ----------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Apellidos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fk_idpuesto` int NOT NULL,
  `Telefono` int NOT NULL,
  `fk_idhorario` int NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `horario`(`fk_idhorario`) USING BTREE,
  INDEX `puesto`(`fk_idpuesto`) USING BTREE,
  CONSTRAINT `horario` FOREIGN KEY (`fk_idhorario`) REFERENCES `horario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `puesto` FOREIGN KEY (`fk_idpuesto`) REFERENCES `puesto` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for especilidad
-- ----------------------------
DROP TABLE IF EXISTS `especilidad`;
CREATE TABLE `especilidad`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `especilidad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for estadocita
-- ----------------------------
DROP TABLE IF EXISTS `estadocita`;
CREATE TABLE `estadocita`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for estudios
-- ----------------------------
DROP TABLE IF EXISTS `estudios`;
CREATE TABLE `estudios`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fk_consulta` int NULL DEFAULT NULL,
  `Nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `consultaFk`(`Fk_consulta`) USING BTREE,
  CONSTRAINT `consultaFk` FOREIGN KEY (`Fk_consulta`) REFERENCES `consultas` (`ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for horario
-- ----------------------------
DROP TABLE IF EXISTS `horario`;
CREATE TABLE `horario`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `horario` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for marca
-- ----------------------------
DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Marca` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medicacion
-- ----------------------------
DROP TABLE IF EXISTS `medicacion`;
CREATE TABLE `medicacion`  (
  `ID` int NOT NULL,
  `Nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Dosis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Horario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Comentarios` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Fk_consulta` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `consultafk2`(`Fk_consulta`) USING BTREE,
  CONSTRAINT `consultafk2` FOREIGN KEY (`Fk_consulta`) REFERENCES `consultas` (`ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for medicos
-- ----------------------------
DROP TABLE IF EXISTS `medicos`;
CREATE TABLE `medicos`  (
  `ID_medico` int NOT NULL AUTO_INCREMENT,
  `Fk_id_modulo` int NOT NULL,
  `fk_id_especialidad` int NOT NULL,
  `fk_id_registroEmpleado` int NOT NULL,
  PRIMARY KEY (`ID_medico`) USING BTREE,
  INDEX `empleadofk`(`fk_id_registroEmpleado`) USING BTREE,
  INDEX `especilidadFK`(`fk_id_especialidad`) USING BTREE,
  INDEX `modulofk`(`Fk_id_modulo`) USING BTREE,
  CONSTRAINT `empleadofk` FOREIGN KEY (`fk_id_registroEmpleado`) REFERENCES `empleados` (`ID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `especilidadFK` FOREIGN KEY (`fk_id_especialidad`) REFERENCES `especilidad` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `modulofk` FOREIGN KEY (`Fk_id_modulo`) REFERENCES `modulos` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for metodopago
-- ----------------------------
DROP TABLE IF EXISTS `metodopago`;
CREATE TABLE `metodopago`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MetodoPago` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for modulos
-- ----------------------------
DROP TABLE IF EXISTS `modulos`;
CREATE TABLE `modulos`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `modulo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pacientes
-- ----------------------------
DROP TABLE IF EXISTS `pacientes`;
CREATE TABLE `pacientes`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Apellido_Paterno` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Apellido_Materno` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CURP` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Genero` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Correo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Telefono` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Fecha_nacimiento` date NULL DEFAULT NULL,
  `Fecha_creacion` date NOT NULL,
  `fk_idempleado_agrego` int NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `usuario`(`fk_idempleado_agrego`) USING BTREE,
  CONSTRAINT `usuario` FOREIGN KEY (`fk_idempleado_agrego`) REFERENCES `empleados` (`ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pacientes_datosclinicos
-- ----------------------------
DROP TABLE IF EXISTS `pacientes_datosclinicos`;
CREATE TABLE `pacientes_datosclinicos`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fk_idpaceinte` int NOT NULL,
  `Padecimientos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Medicamentos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Alergias` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `pacientefk`(`Fk_idpaceinte`) USING BTREE,
  CONSTRAINT `pacientefk` FOREIGN KEY (`Fk_idpaceinte`) REFERENCES `pacientes` (`ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Nombre_clinico` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Fk_idtipo` int NOT NULL,
  `Fk_idmarca` int NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `tipofk`(`Fk_idtipo`) USING BTREE,
  INDEX `MARCAFK`(`Fk_idmarca`) USING BTREE,
  CONSTRAINT `MARCAFK` FOREIGN KEY (`Fk_idmarca`) REFERENCES `marca` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tipofk` FOREIGN KEY (`Fk_idtipo`) REFERENCES `tipomedicamento` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for puesto
-- ----------------------------
DROP TABLE IF EXISTS `puesto`;
CREATE TABLE `puesto`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `puesto` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reservacion
-- ----------------------------
DROP TABLE IF EXISTS `reservacion`;
CREATE TABLE `reservacion`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `fk_idpaceinte` int NOT NULL,
  `Dia` date NOT NULL,
  `Hora` time(0) NOT NULL,
  `sintomas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `fk_estadocita` int NOT NULL DEFAULT 1,
  `fk_empleado` int NOT NULL,
  `fk_medico` int NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `estadofk`(`fk_estadocita`) USING BTREE,
  INDEX `empleadofk2`(`fk_empleado`) USING BTREE,
  INDEX `medicofk`(`fk_medico`) USING BTREE,
  INDEX `pacientefk2`(`fk_idpaceinte`) USING BTREE,
  CONSTRAINT `empleadofk2` FOREIGN KEY (`fk_empleado`) REFERENCES `empleados` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `estadofk` FOREIGN KEY (`fk_estadocita`) REFERENCES `estadocita` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `medicofk` FOREIGN KEY (`fk_medico`) REFERENCES `medicos` (`ID_medico`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pacientefk2` FOREIGN KEY (`fk_idpaceinte`) REFERENCES `pacientes` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Fecha_ingreso` date NOT NULL,
  `Cantidad` int NOT NULL,
  `Salidad` int NOT NULL,
  `Precio` double NOT NULL,
  `Fk_idproducto` int NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `prodcutofk`(`Fk_idproducto`) USING BTREE,
  CONSTRAINT `prodcutofk` FOREIGN KEY (`Fk_idproducto`) REFERENCES `productos` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tipomedicamento
-- ----------------------------
DROP TABLE IF EXISTS `tipomedicamento`;
CREATE TABLE `tipomedicamento`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Tipo_Medicamento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tipoproducto
-- ----------------------------
DROP TABLE IF EXISTS `tipoproducto`;
CREATE TABLE `tipoproducto`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contraseña` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fk_idEmpleado` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `empleado`(`fk_idEmpleado`) USING BTREE,
  CONSTRAINT `empleado` FOREIGN KEY (`fk_idEmpleado`) REFERENCES `empleados` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
