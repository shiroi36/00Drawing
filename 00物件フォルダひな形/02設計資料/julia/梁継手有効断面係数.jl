# 梁継手有効断面係数の計算
# 計算方法はSCSSに準拠している
# 本プログラムで得た有効断面係数に降伏応力度をかけて梁継手の設計曲げモーメントとする

struct HJoint
    h::Float64
    btf::Float64
    btw::Float64
    g::Float64
    d::Float64
    i0::Float64
end

function ze(j::HJoint)
    ie = j.i0 - 2.0 * j.g * (1.0 / 12.0 * j.d * j.btf^3 + j.d * j.btf * ((j.h - j.btf) / 2.0)^2)
    return ie / 0.5 / j.h
end

wj39 = HJoint(396, 11, 7, 2.0, 22, 19800e4)
wj35 = HJoint(350, 11, 7, 2.0, 22, 13500e4)
wj24 = HJoint(248, 8, 5, 2.0, 18, 3450e4)
mj59 = HJoint(596, 15, 10, 2.0, 22, 66600e4)

println("wj39: " , ze(wj39) / 1e3)
println("wj35: " , ze(wj35) / 1e3)
println("wj24: " , ze(wj24) / 1e3)
println("mj59: " , ze(mj59) / 1e3)

