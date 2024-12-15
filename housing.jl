# Eastborne Realty has $2 million available for the purchase of new rental property. 
# After an initial screening, Eastborne reduced the investment alternatives to townhouses and apartment buildings. 
# Each townhouse can be purchased for $282,000, and five are available. 
# Each apartment building can be purchased for $400,000, and the developer will construct as many buildings as Eastborne wants to purchase.

# Eastborne’s property manager can devote up to 140 hours per month to these new properties; each townhouse is expected to require 4 hours per month, 
# and each apartment building is expected to require 40 hours per month. The annual cash flow, after deducting mortgage payments and operating expenses, 
# is estimated to be $10,000 per townhouse and $15,000 per apartment building. 
# Eastborne’s owner would like to determine the number of townhouses and the number of apartment buildings to purchase to maximize annual cash flow.


#total 2 million to spend
#townhouse purchase = 282,000 and n = 5
#apartment = 400,000, n = unlimited

#total time = 140 hours per month
#townhouse = 4hours per month 
#apartment building = 40 hours per month 

# cashflow townhouse = 10,000
# cashflow apartment = 15,000

# number of apartments and townhouses to purchase to max cashflow 

#variables and constraints
# 0 <= nT <= 5
# 0 <= nA
# 2,000,000 >= 282,000 * nT + 400,000 * nA 

# 4*nT + 40*nA = 140


#objective function
# 10,000 * nT + 15,000 * nA MAXIMISE


using JuMP
using HiGHS

housing = Model(HiGHS.Optimizer)
set_silent(housing)

@variables(housing, begin
    0 <= nT <= 5, Int 
    0 <= nA, Int
end)

@constraint(housing, c2, 4*nT + 40*nA <= 140)
@constraint(housing, c1, 2000000 >= 282000 * nT + 400000 * nA)

@objective(housing, Max, 10000 * nT + 15000 * nA)

optimize!(housing)

println("Optimal townhouse: ", value(nT))
println("Optimal apartment: ", value(nA))