function plot_ga_evolution(fitness_best, fitness_mean, i)

    figure(1)
    plot(1:i,fitness_best(1:i),'b-')
    hold on
    plot(1:i,fitness_mean(1:i),'r-')
    legend('Best fitness', 'Mean fitness')
%     xlim([0 i])
    drawnow;
    
end