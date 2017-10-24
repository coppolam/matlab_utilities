function verbose_ga_evolution(verbose, i, fitness_best, fitness_mean)

if verbose
    disp(['Iteration: ', num2str(i), ...
        ' Best Fitness: ', num2str(fitness_best(i)),...
        ' Mean Fitness: ', num2str(fitness_mean(i))]);
end

end

