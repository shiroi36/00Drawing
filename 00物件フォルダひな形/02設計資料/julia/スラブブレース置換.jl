# スラブのブレース置換断面積の計算

g = 8750.0
e = 21000.0
kappa = 1.2

function area(l, h, t)
    length = sqrt(l^2 + h^2)
    return g * t * length^3 / 2 / kappa / e / l / h
end

println("hv1: " , area(6000, 7400, 95) / 1e2)
