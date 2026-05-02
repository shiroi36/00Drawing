# 片持ちRC階段の検討

using Printf

@printf("○設計条件\n")
l = 1100 # mm
@printf("梁長さ		L=%.0fmm\n", l)
b = 375 # mm
@printf("梁幅			b=%.0fmm\n", b)
large_d = 300 # mm
@printf("梁せい		D=%.0fmm\n", large_d)
d = 250 # mm
@printf("有効せい		d=%.0fmm\n", d)
@printf("\n")

@printf("○設計荷重\n")
w = 1.8 * b / 1e3 + 24 * b * large_d / 1e6 # kN/m
@printf("等分布荷重		w = 24kN/m3×%.3fm×%.3fm + 1.8kN/m2×%.3fm = %.1fkN/m\n", b / 1e3, large_d / 1e3, b / 1e3, w)
md = w * l^2 / 2
@printf("設計曲げモーメント	Md = w・L^2/2 = %.1fkNm\n", md / 1e6)
qd = w * l # N
@printf("設計せん断力		Qd = w・L = %.1fkN\n", qd / 1e3)
@printf("\n")

@printf("○応力計算\n")
j = 7.0 / 8.0 * d # mm
@printf("応力中心間距離		j=7/8・d=%.1fmm\n", j)
at = 127.0 * 2
@printf("引張鉄筋断面積(2-D13)	at=%.0fmm2\n", at)
ft = 195
@printf("鉄筋長期許容引張応力度	ft=%.0fN/mm2\n", ft)
ma = ft * at * j
@printf("許容曲げモーメント		Ma=ft・at・j=%.1fkNm>Md", ma / 1e6)
println(ma > md ? "→【OK】" : "→【NG】")

fs = 0.7
@printf("許容せん断応力度		fs=%.1fN/mm2\n", fs)
qa = fs * b * j
@printf("許容せん断力			Qa=fs・b・j=%.1fkN>Qd", qa / 1e3)
println(qa > qd ? "→【OK】" : "→【NG】")
@printf("\n")

@printf("○たわみ計算\n")
e = 21000 # N/mm2
@printf("ヤング率		E=%.0fN/mm2\n", e)
ix = b * large_d^3 / 12 # mm4
@printf("断面二次モーメント	Ix=b・D^3/12=%.1fcm4\n", ix / 1e4)
k = 8
@printf("変形増大倍率		K=%.1f\n", k)
d = k * 1.0 / 8.0 * w * l^4 / e / ix
@printf("たわみ		d=k・1/8・w・L^4/E/Ix=%.1fmm...L/%.0f", d, l / d)
println(l / d > 250 ? "→【OK】" : "→【NG】")

