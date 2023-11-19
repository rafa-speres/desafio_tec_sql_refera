-- Valor total das vendas e dos fretes por produto e ordem de venda
SELECT
    fd.ProdutoID,
    fd.CupomID,
    SUM(fd.ValorLiquido) AS ValorTotalVendas,
    fc.ValorFrete
FROM
    FatoDetalhes fd
JOIN
    FatoCabeçalho fc ON fd.CupomID = fc.CupomID
GROUP BY
    fd.ProdutoID, fd.CupomID, fc.ValorFrete
ORDER BY
    fd.ProdutoID, fd.CupomID;

--Valor de venda por tipo de produto
SELECT
    dp.Categoria,
    SUM(fd.ValorLiquido) AS ValorTotalVendas
FROM
    FatoDetalhes fd
JOIN
    DimensoesProdutos dp ON fd.ProdutoID = dp.ProdutoID
GROUP BY
    dp.Categoria;

--Quantidade e valor das vendas por dia, mês, ano
SELECT
    DATE_FORMAT(fc.Data, '%Y') AS Ano,
    DATE_FORMAT(fc.Data, '%m') AS Mes,
    DATE_FORMAT(fc.Data, '%d') AS Dia,
    COUNT(fd.CupomID) AS QuantidadeVendas,
    SUM(fd.ValorLiquido) AS ValorTotalVendas
FROM
    FatoDetalhes fd
JOIN
    FatoCabeçalho fc ON fd.CupomID = fc.CupomID
GROUP BY
    Ano, Mes, Dia;

--Lucro dos meses
SELECT
    DATE_FORMAT(fc.Data, '%Y') AS Ano,
    DATE_FORMAT(fc.Data, '%m') AS Mes,
    SUM(fd.ValorLiquido - fd.Custo) AS Lucro
FROM
    FatoDetalhes fd
JOIN
    FatoCabeçalho fc ON fd.CupomID = fc.CupomID
GROUP BY
    Ano, Mes;

--Venda por produto
SELECT
    dp.Produto,
    SUM(fd.ValorLiquido) AS ValorTotalVendas
FROM
    FatoDetalhes fd
JOIN
    DimensoesProdutos dp ON fd.ProdutoID = dp.ProdutoID
GROUP BY
    dp.Produto;

--Venda por cliente, cidade do cliente e estado
SELECT
    dc.Cliente,
    dc.Cidade,
    dc.Pais,
    SUM(fd.ValorLiquido) AS ValorTotalVendas
FROM
    FatoDetalhes fd
JOIN
    FatoCabeçalho fc ON fd.CupomID = fc.CupomID
JOIN
    DimensoesCliente dc ON fc.ClienteID = dc.ClienteID
GROUP BY
    dc.Cliente, dc.Cidade, dc.Pais;

--Média de produtos vendidos
SELECT
    AVG(Quantidade) AS MediaProdutosVendidos
FROM
    FatoDetalhes;

--Média de compras que um cliente faz
SELECT
    dc.Cliente,
    AVG(fd.Quantidade) AS MediaComprasCliente
FROM
    FatoDetalhes fd
JOIN
    FatoCabeçalho fc ON fd.CupomID = fc.CupomID
JOIN
    DimensoesCliente dc ON fc.ClienteID = dc.ClienteID
GROUP BY
    dc.Cliente;
