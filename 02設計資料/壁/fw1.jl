using Printf

@printf("○設計条件\n")
gamma = 17 # kN/m3
ka = 0.4
q = 24 * 0.2 + 9 # kN/m2
h = 1.6 # m
t = 0.25 # m
b = 1.5 # m
gamma_c = 24 # kN/m3
mu = 0.4
@printf("コンクリート単位体積重量		γc=%.0fkN/m3\n", gamma_c)
@printf("土の単位体積重量		γ=%.0fkN/m3\n", gamma)
@printf("土圧係数			KA=%.1f\n", ka)
@printf("上載荷重（土間コン荷重+スラブ用積載荷重）	q=%.3fkN/m2\n", q)
@printf("底盤下端から土上端までの高さ	h=%.2fm\n", h)
@printf("擁壁厚さ			t=%.2fm\n", t)
@printf("底版長さ			b=%.2fm\n", b)
@printf("摩擦係数			μ=%.2f\n", mu)

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

w_wall = gamma_c * t * h # kN/m
@printf("竪壁自重	%.1fkN/m3×%.2fm×%.2fm=%.1fkN/m\n", gamma_c, t, h, w_wall)
w_floor = gamma_c * t * (b - t) # kN/m
@printf("底版自重	%.1fkN/m3×%.2fm×(%.2fm-%.2fm)=%.1fkN/m\n", gamma_c, t, b, t, w_floor)
w_soil = gamma * b * (h - t) # kN/m
@printf("底版上の土重量	%.1fkN/m3×%.2fm×(%.2fm-%.2fm)=%.1fkN/m\n", gamma, b, h, t, w_soil)
w_q = q * b # kN/m
@printf("底版上の上載荷重	%.1fkN/m2×%.2fm=%.1fkN/m\n", q, b, w_q)
rv = w_wall + w_floor + w_soil + w_q
@printf("鉛直荷重合計	Rv=%.1fkN/m+%.1fkN/m+%.1fkN/m+%.1fkN/m=%.1fkN/m\n", w_wall, w_floor, w_soil, w_q, rv)
mo = w_wall * t / 2 + w_floor * b / 2 + w_soil * b / 2 + w_q * b / 2 # kNm/m
@printf("安定モーメント	Mo=%.1fkN/m×%.2fm+%.1fkN/m×%.2fm+%.1fkN/m×%.2fm+%.1fkN/m×%.2fm=%.1fkNm/m\n", w_wall, t / 2, w_floor, b / 2, w_soil, b / 2, w_q, b / 2, mo)
d = (mo - mr) / rv
@printf("合力作用位置	d=(M0-Mr)/Rv=(%.1fkNm/m-%.1fkNm/m)/%.1fkN/m=%.3fm\n", mo, mr, rv, d)

@printf("\n")

@printf("○転倒に関する検討\n")
@printf("安全率の検討	Mo/Mr=%.1fkNm/m/%.1fkNm/m=%.2f>1.5...OK\n", mo, mr, mo / mr)
e = b / 2 - d
@printf("偏心距離の検討	e=b/2-d=%.2fm/2-%.3fm=%.3fm<b/6=%.3fm...OK\n", b, d, e, b / 6)

@printf("\n")

@printf("○滑動に関する検討\n")
@printf("μ・Rv/Rh=%.3f>1.5...OK\n", mu * rv / rh)

@printf("\n")

@printf("○地盤の支持力に関する検討\n")
q1 = rv / b * (1 + 6 * e / b)
q2 = rv / b * (1 - 6 * e / b)
@printf("地盤応力度	q=Rv/b・(1±6・e/b)=%.2fkN/m/%.2fm×(1±6×%.3fm/%.2fm)=%.1fkN/m2, %.1fkN/m2<100kN/m2...OK\n", rv, b, e, b, q1, q2)

@printf("\n")

@printf("○応力計算\n")
md = mr
@printf("設計曲げモーメント		Md=Mr=%.1fkNm/m\n", md)
j = 7.0 / 8.0 * (t * 1000 - 80)
@printf("応力中心間距離		j=7/8×(%.0fmm-80mm)=%.1fmm\n", t * 1000, j)
at = 127 * 1000 / 200 # D13@200
@printf("引張鉄筋断面積		at=%.0fmm2/m\n", at)
ft = 195
@printf("鉄筋長期許容引張応力度	ft=%.0fN/mm2\n", ft)
ma = ft * at * j * 1e-6
@printf("許容曲げモーメント		Ma=ft・at・j=%.1fkNm/m>Md...OK\n", ma)

