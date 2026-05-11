# Commands to run Haskell code:
runghc file-name.hs


# Command to run Prolog code:
swipl file-name.pl

# Example command to run prolog-1-1
// first is the list, second is a number of the smallest elements to delete
run_task([10, 1, 2, 5, 1, 1, 7], 2). 

# Example command to run prolog-1-2
// input is the list of numbers
run_task([0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270]).

# Example command to run prolog-2
// input is the list of numbers
set_prolog_flag(answer_write_options, [max_depth(0)]).
solve([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30], R).

# Example command to run prolog-3
// input is epmty
run_task.

# Example command to run prolog-4
// input is epmty
run_task.