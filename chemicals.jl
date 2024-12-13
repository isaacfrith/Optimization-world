# soaps and laundry detergent
# combined production of A and B = 350 gallons
# separate order of 125 gallons

# product A takes 2 hours of processing time per gallon
# product B takes 1 hour of processing time per gallon 

# 600 hours of total time avaialble 
# minimise cost 
# production costs 2 dollars per gallon for A 
# 3 dollars per gallon for B 

# time: 
# Va1 * 2 + Vb1 * 1 + 125 * 2 < 600 

# volume: 
# Va + Vb >= 350 
# Va = 125 for another order

# Objective function
# minimise cost => Va1 * 2 + Vb1 * 3 + 125 * 2

# variables:
# Va >= 125
# Va + Vb >= 350

# Va * 2 + Vb < 450

# Objective function 
# minimise: Va * 2 + Vb * 3 + 150 

using JuMP
using HiGHS

chemicals = Model(HiGHS.Optimizer)
set_silent(chemicals)

@variables(chemicals, begin
    Va >= 0
    Vb >= 0
end)


@constraint(chemicals, c2, Va +Vb + 125>= 350)
@constraint(chemicals, c3, (Va + 125) * 2 + Vb <= 600)
@constraint(chemicals, c4, Va >= 125)


@objective(chemicals, Min, Va*2 + Vb*3 + 2*150)

optimize!(chemicals)

println("Optimal Va: ", value(Va))
println("Optimal Vb: ", value(Vb))
println("Minimum Cost: ", objective_value(chemicals))