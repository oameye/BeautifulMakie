using GLMakie
GLMakie.activate!()
GLMakie.closeall() # close any open screen

x = y = LinRange(-2, 2, 51)
z = (-x .* exp.(-x .^ 2 .- (y') .^ 2)) .* 4
zmin, zmax = minimum(z), maximum(z)
cmap = :viridis

fig = Figure(size = (1200, 800), fontsize = 22)
ax = Axis3(fig[1, 1], aspect = :data, perspectiveness = 0.5, elevation = π / 9,
    xzpanelcolor = (:black, 0.75), yzpanelcolor = (:black, 0.75),
    zgridcolor = :grey, ygridcolor = :grey, xgridcolor = :grey)
sm = surface!(ax, x, y, z; colormap = cmap, colorrange = (zmin, zmax),
    transparency = true)
xm, ym, zm = minimum(ax.finallimits[])
contour!(ax, x, y, z; levels = 20, colormap = cmap, linewidth = 2,
    colorrange = (zmin, zmax), transformation = (:xy, zmin),
    transparency = true)
wireframe!(ax, x, y, z; overdraw = true, transparency = true,
    color = (:black, 0.1))
Colorbar(fig[1, 2], sm, height = Relative(0.5))
colsize!(fig.layout, 1, Aspect(1, 1.0))
fig

save("surface.png", fig); # hide

# ![](surface.png)