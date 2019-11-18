# frozen_string_literal: true

# V0.1 Newtown and first Dungeon

ap = AdminPanel::Seeder.new(:xp)

ap.seed(id: 1, required: 200, cap: 250) # 25%
ap.seed(id: 2, required: 800, cap: 980) # 22.5% (-2.5%)
ap.seed(id: 3, required: 2000, cap: 2425) # 21.25% (-1.25%)
ap.seed(id: 4, required: 5000, cap: 6000) # 20% (-1.25%)
ap.seed(id: 5, required: 11_000, cap: 13_063) # 18.75% (-1.25%)
ap.seed(id: 6, required: 20_000, cap: 23_625) # 18.125% (-0.625%)
ap.seed(id: 7, required: 37_500, cap: 44_063) # 17.5% (-0.625%)
ap.seed(id: 8, required: 70_000, cap: 81_813) # 16.875% (-0.625%)
ap.seed(id: 9, required: 110_000, cap: 127_875) # 16.25% (-0.625%)
ap.seed(id: 10, required: 180_000, cap: 208_125) # 15.625% (-0.625%)
