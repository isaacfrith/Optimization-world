
# cost 4-cylinder connecting rods is $2000
# cost 6-cylinder connecting rods is $3500

# Manufacturing costs are $15 for each 4-cylinder connecting rod 
# and $18 for each 6-cylinder connecting rod.

# the weekly production capacities are 6000 6-cylinder connecting rods and 8000 4-cylinder connecting rods.

# x4 = the number of 4-cylinder connecting rods produced next week
# x6 = the number of 6-cylinder connecting rods produced next week
# s4 = 1 if the production line is set up to produce the 4-cylinder connecting rods; 0 if otherwise
# s6 = 1 if the production line is set up to produce the 6-cylinder connecting rods; 0 if otherwise


# a. Using the decision variables x4 and s4, write a constraint that limits next week’s production of the 4-cylinder connecting rods to either 0 or 8000 units.
#      
#  s4 = 1 , x4 <= 8000     
#  s4 = 0, x4 = 0

# b. Using the decision variables x6 and s6, write a constraint that limits next week’s production of the 6-cylinder connecting rods to either 0 or 6000 units.
#  
# s6 = 1, x6 <= 6000     
# s6 = 0, x6 = 0

# c. Write three constraints that, taken together, limit the production of connecting rods for next week.

# c1: s4 + s6 = 1
# c2: x4 <= 8000 and x6 <= 6000
# c3: x4 <= 8000 * s4
#     x6 <= 6000 * s6


# d. Write an objective function for minimizing the cost of production for next week.
# MINIMISE: (2000 + x4 * 15) + (3500 + x6 * 18)
#

using JuMP
using HiGHS

manufacturing = Model(HiGHS.Optimizer)
set_silent(manufacturing)

@variables(manufacturing, begin
    0 <= x4 <= 8000
    0 <= x6 <= 6000
    s4, Bin
    s6, Bin
end)

@constraint(manufacturing, c1, s4 + s6 == 1)
@constraint(manufacturing, c4, x4 <= 8000 * s4)
@constraint(manufacturing, c5, x6 <= 6000 * s6)


@objective(manufacturing, Min,((2000 * s4 + x4 * 15) + (3500 * s6 + x6 * 18)) )

optimize!(manufacturing)

println("x4 (4-cylinder rods produced): ", value(x4))
println("x6 (6-cylinder rods produced): ", value(x6))
println("s4 (4-cylinder setup): ", value(s4))
println("s6 (6-cylinder setup): ", value(s6))