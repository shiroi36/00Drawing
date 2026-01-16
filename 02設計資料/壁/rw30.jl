using Printf

# OW18の検討

@printf("○設計条件\n")
gamma = 17 # kN/m3
ka = 0.4
q = 24 * 0.2 + 6 # kN/m2
h = 3.4 # m
t = 0.30 # m
@printf("土の単位体積重量		γ=%.0fkN/m3\n", gamma)
@printf("土圧係数			KA=%.1f\n", ka)
@printf("上載荷重（土間コン荷重+スラブ用積載荷重）	q=%.3fkN/m2\n", q)
@printf("底盤下端から土上端までの高さ	h=%.2fm\n", h)
@printf("擁壁厚さ			t=%.2fm\n", t)

@printf("\n")

@printf("○荷重およびモーメント\n")
p1 = ka * q
@printf("上端土圧		P1=KA×q=%.1fkN/m2\n", p1)
p2 = ka * gamma * h + ka * q
@printf("下端土圧		P2=KA×γ×h+KA×q=%.1fkN/m2\n", p2)
rh = (p1 + p2) * h / 2
@printf("土圧合力		Rh=(P1+P2)・h/2=%.1fkN/m\n", rh)
y = (p2 + 2 * p1) * h / 3 / (p2 + p1)
@printf("土圧作用位置		y=(P2+2・P1)・h/3/(P2+P1)=%.3fm\n", y)
mr = rh * y
@printf("転倒モーメント	Mr=%.1fkN/m×%.3fm=%.1fkNm/m\n", rh, y, mr)

@printf("\n")

@printf("○応力計算\n")
md = mr
@printf("設計曲げモーメント		Md=Mr=%.1fkNm/m\n", md)
j = 7.0 / 8.0 * (t * 1000 - 80)
@printf("応力中心間距離		j=7/8×(%.0fmm-80mm)=%.1fmm\n", t * 1000, j)
at = 199.0 * 1000 / 100 # D16@100
@printf("引張鉄筋断面積		at=%.0fmm2/m\n", at)
ft = 195
@printf("鉄筋長期許容引張応力度	ft=%.0fN/mm2\n", ft)
ma = ft * at * j * 1e-6
@printf("許容曲げモーメント		Ma=ft・at・j=%.1fkNm/m>Md", ma)
println(ma > md ? "→【OK】" : "→【NG】")

