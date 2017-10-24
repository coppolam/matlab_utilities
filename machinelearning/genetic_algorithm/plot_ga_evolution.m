function plot_ga_evolution(fitness_best, fitness_mean)

    figure(1)
    plot(fitness_best,'b-')
    hold on
    plot(fitness_mean,'r-')
    legend('Best fitness', 'Mean fitness')
    drawnow;
    
end