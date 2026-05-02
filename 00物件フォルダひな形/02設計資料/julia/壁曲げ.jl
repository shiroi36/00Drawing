# 曲げを受ける壁の検討
# 物流倉庫における段差スラブ部壁などが該当する

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

