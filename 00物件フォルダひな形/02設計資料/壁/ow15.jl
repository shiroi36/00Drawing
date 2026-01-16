using Printf

@printf("○設計条件\n")
t = 150 # mm
@printf("壁厚さ			t=%.0fmm\n", t)
d = 110 # mm
@printf("有効せい		d=%.0fmm\n", d)
@printf("\n")

@printf("○設計荷重\n")
md = 35 # kNm/m
@printf("設計曲げモーメント	Md=%.1fkNm/m\n", md)
@printf("\n")

@printf("○応力計算\n")
j = 7.0 / 8.0 * d # mm
@printf("応力中心間距離		j=7/8・d=%.1fmm\n", j)
at = 127.0 * 1000 / 100 # D13@100
@printf("引張鉄筋断面積(D13@100)	at=%.0fmm2/m\n", at)
ft = 295
@printf("鉄筋短期許容引張応力度	ft=%.0fN/mm2\n", ft)
ma = ft * at * j * 1e-6
@printf("許容曲げモーメント	Ma=ft・at・j=%.1fkNm/m>Md", ma)
println(ma > md ? "→【OK】" : "→【NG】")

# g = 9000
# @printf("せん断弾性係数		G=%.0fN/mm2\n", g)
# l = 3e3 + 1000
# @printf("スラブ・壁長さ		L=%.1fmm\n", l)
# d = 2 # mm 一貫計算結果より
# @printf("水平変位		d=%.1fmm\n", d)
# tau = g * d / l
# @printf("せん断応力度		τ=G・d/L=%.3fN/mm2\n", tau)
# fs = 1.4
# @printf("許容せん断応力度		fs=%.1fN/mm2>τ→【OK】\n", fs)

# @printf("○設計条件\n")
# t = 150 # mm
# @printf("壁厚さ			t=%.2fm\n", t)
# 
# @printf("○荷重およびモーメント\n")
# e = 21000
# @printf("ヤング率		E=%.0fN/mm2\n", e)
# i = 1000 * t^3 / 12
# l = 1000
# d = 6 # mm 一貫計算結果より
# m = 6 * e * i * d / l^2 * 1e-6
# @printf("設計曲げモーメント		Md=6・E・I・d/L^2=%.1fkNm/m\n", m)
# 
# @printf("○応力計算\n")
# j = 7.0 / 8.0 * (t - 80)
# @printf("応力中心間距離		j=7/8×(%.0fmm-80mm)=%.1fmm\n", t, j)
# at = 127 * 1000 / 200 # D13@200
# @printf("引張鉄筋断面積		at=%.0fmm2/m\n", at)
# ft = 195
# @printf("鉄筋長期許容引張応力度	ft=%.0fN/mm2\n", ft)
# ma = ft * at * j * 1e-6
# @printf("許容曲げモーメント		Ma=ft・at・j=%.1fkNm/m>Md→【OK】\n", ma)

