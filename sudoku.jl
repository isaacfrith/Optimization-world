using JuMP
using HiGHS


sudoku = Model(HiGHS.Optimizer)
set_silent(sudoku)

#create variables
@variable(sudoku, x[i = 1:9, j = 1:9, k = 1:9], Bin);

for i in 1:9
    for j in 1:9 
        @constraint(sudoku, sum(x[i, j, k] for k in 1:9) == 1)
    end
end

for ind in 1:9 #each row or column 
    for k in 1:9
        @constraint(sudoku, sum(x[ind, j, k] for j in 1:9) == 1)
        @constraint(sudoku, sum(x[i, ind, k] for i in 1:9) == 1)
    end
end

for i in 1:3:7
    for j in 1:3:7
        for k in 1:9
            @constraint(
                sudoku,
                sum(x[r, c, k] for r in i:(i+2), c in j:(j+2)) == 1
            )
        end
    end
end

init_sol = [
    5 3 0 0 7 0 0 0 0
    6 0 0 1 9 5 0 0 0
    0 9 8 0 0 0 0 6 0
    8 0 0 0 6 0 0 0 3
    4 0 0 8 0 3 0 0 1
    7 0 0 0 2 0 0 0 6
    0 6 0 0 0 0 2 8 0
    0 0 0 4 1 9 0 0 5
    0 0 0 0 8 0 0 7 9
]

for i in 1:9
    for j in 1:9
        if init_sol[i, j] != 0
            fix(x[i, j, init_sol[i, j]], 1; force = true)
        end
    end
end 

optimize!(sudoku)
@assert is_solved_and_feasible(sudoku)

x_val = value.(x);

sol = zeros(Int, 9, 9)
for i in 1:9
    for j in 1:9 
        for k in 1:9 
            if round(Int, x_val[i, j ,k]) == 1
                sol[i, j] = k
            end
        end
    end
end 