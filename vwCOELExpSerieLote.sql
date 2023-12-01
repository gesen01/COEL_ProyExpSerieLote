SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

IF EXISTS(SELECT * FROM sysobjects WHERE TYPE='v' AND NAME='vwCOELExpSerieLote')
DROP VIEW vwCOELExpSerieLote
GO
CREATE VIEW vwCOELExpSerieLote
AS
SELECT s.Articulo
       ,a.Descripcion1
       ,s.Almacen
       ,s.SerieLote
       ,SUM(s.Existencia) AS 'Existencia'
       ,s.Empresa AS 'Empresas'
       ,s.sucursal AS 'Sucursales'
FROM vwCOELSerieLoteMov s
JOIN Art a ON s.Articulo=a.Articulo
WHERE s.almacen LIKE '%MERC'
GROUP BY s.Articulo,a.Descripcion1,s.Almacen,s.SerieLote,s.Empresa,s.sucursal
